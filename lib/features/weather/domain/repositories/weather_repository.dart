import 'package:weather_app/features/weather/domain/entities/weather_entity.dart';

/// Repository contract for weather data.
///
/// Defined in the domain layer — implemented in the data layer.
abstract class WeatherRepository {
  /// Gets current weather for a given [city].
  ///
  /// If [forceRefresh] is `true`, bypasses cache and fetches from the server.
  Future<WeatherEntity> getCurrentWeather(
    String city, {
    bool forceRefresh = false,
  });
}
