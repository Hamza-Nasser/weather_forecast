import 'package:injectable/injectable.dart';
import 'package:flutter/foundation.dart';
import 'package:weather_app/core/network/client/endpoints.dart';
import 'package:weather_app/core/network/client/restful_client.dart';
import 'package:weather_app/core/network/error/server_exceptions.dart';
import 'package:weather_app/features/weather/data/models/weather_model.dart';
import 'package:weather_app/features/weather/data/sources/weather_remote_source.dart';

/// Implementation of [WeatherRemoteSource] fetching data from Weather API.
@Injectable(as: WeatherRemoteSource)
class WeatherRemoteSourceImpl implements WeatherRemoteSource {
  final RestfulClient _client;
  final String _apiKey;

  const WeatherRemoteSourceImpl(this._client)
    : _apiKey = const String.fromEnvironment('WEATHER_API_KEY');

  @visibleForTesting
  const WeatherRemoteSourceImpl.withApiKey(this._client, this._apiKey);

  @override
  Future<WeatherModel> getCurrentWeather(String city) async {
    if (_apiKey.trim().isEmpty) {
      throw const ConfigurationException();
    }
    final response = await _client.get(
      Endpoints.forecast,
      queryParameters: {'key': _apiKey, 'q': city, 'days': 7},
    );

    if (response is Map<String, dynamic>) {
      return WeatherModel.fromJson(response);
    } else if (response is Map) {
      return WeatherModel.fromJson(Map<String, dynamic>.from(response));
    }

    throw const FetchDataException();
  }
}
