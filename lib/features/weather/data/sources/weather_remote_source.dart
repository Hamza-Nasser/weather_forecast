import 'package:weather_app/features/weather/data/models/weather_model.dart';

/// Data source interface for weather API calls.
///
/// Implementations receive [RestfulClient] and make raw backend calls.
abstract class WeatherRemoteSource {
  /// Fetches current weather data for a [city] from the remote API.
  Future<WeatherModel> getCurrentWeather(String city);
}
