import 'package:injectable/injectable.dart';
import 'package:weather_app/features/weather/domain/entities/weather_entity.dart';
import 'package:weather_app/features/weather/domain/repositories/weather_repository.dart';

/// Use case for getting current weather data.
///
/// Single-purpose: fetches weather for a city via the repository contract.
@injectable
class GetCurrentWeatherUseCase {
  const GetCurrentWeatherUseCase(this._repository);
  final WeatherRepository _repository;

  Future<WeatherEntity> call(
    String city, {
    bool forceRefresh = false,
  }) =>
      _repository.getCurrentWeather(city, forceRefresh: forceRefresh);
}
