import 'dart:convert';

import 'package:injectable/injectable.dart';
import 'package:weather_app/core/cache/cache_client.dart';
import 'package:weather_app/core/services/app_error_reporter.dart';
import 'package:weather_app/core/services/prefs/app_preferences.dart';
import 'package:weather_app/features/weather/data/models/weather_model.dart';
import 'package:weather_app/features/weather/data/sources/weather_remote_source.dart';
import 'package:weather_app/features/weather/domain/entities/weather_entity.dart';
import 'package:weather_app/features/weather/domain/repositories/weather_repository.dart';

@Injectable(as: WeatherRepository)
class WeatherRepositoryImpl implements WeatherRepository {
  const WeatherRepositoryImpl(
    this._remoteSource,
    this._cacheClient,
    this._preferences,
    this._errorReporter,
  );

  final WeatherRemoteSource _remoteSource;
  final CacheClient _cacheClient;
  final AppPreferences _preferences;
  final AppErrorReporter _errorReporter;

  @override
  Future<WeatherEntity> getCurrentWeather(
    String city, {
    bool forceRefresh = false,
  }) async {
    final normalizedCity = city.toLowerCase().trim();
    final locale = _preferences.getLocale().trim().toLowerCase();
    final cacheKey =
        'weather_current_${locale.isEmpty ? 'en' : locale}_$normalizedCity';

    if (!forceRefresh) {
      final cached = await _readCache(cacheKey, stale: false);
      if (cached != null) {
        return cached.toEntity(dataSource: WeatherDataSource.cache);
      }
    }

    try {
      final model = await _remoteSource.getCurrentWeather(city.trim());
      try {
        await _cacheClient.put(cacheKey, jsonEncode(model.toJson()));
      } catch (error, stackTrace) {
        _report(error, stackTrace, 'Write weather cache');
      }
      return model.toEntity();
    } catch (remoteError, remoteStackTrace) {
      final stale = await _readCache(cacheKey, stale: true);
      if (stale != null) {
        return stale.toEntity(dataSource: WeatherDataSource.staleCache);
      }
      Error.throwWithStackTrace(remoteError, remoteStackTrace);
    }
  }

  Future<WeatherModel?> _readCache(String key, {required bool stale}) async {
    try {
      final value = stale
          ? await _cacheClient.getStale(key)
          : await _cacheClient.get(key);
      if (value == null) return null;
      final decoded = jsonDecode(value);
      if (decoded is! Map) {
        throw const FormatException('Weather cache is not an object');
      }
      return WeatherModel.fromJson(Map<String, dynamic>.from(decoded));
    } catch (error, stackTrace) {
      _report(error, stackTrace, 'Read weather cache');
      try {
        await _cacheClient.remove(key);
      } catch (removeError, removeStackTrace) {
        _report(removeError, removeStackTrace, 'Remove invalid weather cache');
      }
      return null;
    }
  }

  void _report(Object error, StackTrace stackTrace, String context) {
    _errorReporter.record(error, stackTrace, context: context);
  }
}
