import 'dart:convert';

import 'package:injectable/injectable.dart';
import 'package:weather_app/core/cache/cache_client.dart';
import 'package:weather_app/features/weather/data/models/weather_model.dart';
import 'package:weather_app/features/weather/data/sources/weather_remote_source.dart';
import 'package:weather_app/features/weather/domain/entities/weather_entity.dart';
import 'package:weather_app/features/weather/domain/repositories/weather_repository.dart';

/// Implementation of [WeatherRepository] coordinating data sources.
///
/// Integrates a memory → disk → server caching lookup strategy.
/// When offline, falls back to stale cached data so the app remains usable.
@Injectable(as: WeatherRepository)
class WeatherRepositoryImpl implements WeatherRepository {
  final WeatherRemoteSource _remoteSource;
  final CacheClient _cacheClient;

  const WeatherRepositoryImpl(this._remoteSource, this._cacheClient);

  @override
  Future<WeatherEntity> getCurrentWeather(
    String city, {
    bool forceRefresh = false,
  }) async {
    final cacheKey = 'weather_current_${city.toLowerCase().trim()}';

    // 1. Check cache (unless forcing a refresh)
    if (!forceRefresh) {
      final cachedData = await _cacheClient.get(cacheKey);
      if (cachedData != null) {
        final Map<String, dynamic> decoded = jsonDecode(cachedData);
        return WeatherModel.fromJson(decoded).toEntity();
      }
    }

    // 2. Fetch from server
    try {
      final model = await _remoteSource.getCurrentWeather(city);

      // Cache the raw model JSON for lossless reconstruction
      await _cacheClient.put(cacheKey, jsonEncode(model.toJson()));

      return model.toEntity();
    } catch (e) {
      // 3. Offline fallback — serve stale cached data if available
      final staleData = await _cacheClient.getStale(cacheKey);
      if (staleData != null) {
        final Map<String, dynamic> decoded = jsonDecode(staleData);
        return WeatherModel.fromJson(decoded).toEntity();
      }

      // No cached data at all — rethrow the original error
      rethrow;
    }
  }
}
