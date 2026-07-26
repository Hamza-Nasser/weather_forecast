import 'package:injectable/injectable.dart';
import 'package:weather_app/core/network/client/endpoints.dart';
import 'package:weather_app/core/network/client/restful_client.dart';
import 'package:weather_app/features/weather/data/models/weather_model.dart';
import 'package:weather_app/features/weather/data/sources/weather_remote_source.dart';

/// Implementation of [WeatherRemoteSource] fetching data from Weather API.
@Injectable(as: WeatherRemoteSource)
class WeatherRemoteSourceImpl implements WeatherRemoteSource {
  final RestfulClient _client;

  const WeatherRemoteSourceImpl(this._client);

  @override
  Future<WeatherModel> getCurrentWeather(String city) async {
    const apiKey = String.fromEnvironment('WEATHER_API_KEY');
    final response = await _client.get(
      Endpoints.forecast,
      queryParameters: {
        'key': apiKey,
        'q': city,
        'days': 7,
      },
    );

    if (response is Map<String, dynamic>) {
      return WeatherModel.fromJson(response);
    } else if (response is Map) {
      return WeatherModel.fromJson(Map<String, dynamic>.from(response));
    }

    throw Exception('Invalid weather response format');
  }
}
