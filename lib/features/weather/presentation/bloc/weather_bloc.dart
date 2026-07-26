import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:weather_app/core/app_exceptions/app_exceptions.dart';
import 'package:weather_app/features/weather/domain/usecases/get_current_weather_usecase.dart';

import 'weather_event.dart';
import 'weather_state.dart';

/// BLoC managing weather data fetching and state.
///
/// Uses event-driven architecture for the multi-step fetch flow.
/// Inject use cases through the constructor — no service locator access.
@injectable
class WeatherBloc extends Bloc<WeatherEvent, WeatherState> {
  final GetCurrentWeatherUseCase _getCurrentWeather;

  WeatherBloc(this._getCurrentWeather) : super(const WeatherState()) {
    on<WeatherFetchRequested>(_onFetchRequested);
    on<WeatherRefreshRequested>(_onRefreshRequested);
  }

  Future<void> _onFetchRequested(
    WeatherFetchRequested event,
    Emitter<WeatherState> emit,
  ) async {
    emit(
      state.copyWith(
        status: WeatherStatus.loading,
        error: null,
        errorMessage: null,
      ),
    );

    try {
      final weather = await _getCurrentWeather(
        event.city,
        forceRefresh: event.forceRefresh,
      );
      if (isClosed) return;
      emit(
        state.copyWith(
          status: WeatherStatus.success,
          searchQuery: event.city,
          cityName: weather.cityName,
          region: weather.region,
          country: weather.country,
          temperatureCelsius: weather.temperatureCelsius,
          condition: weather.condition,
          humidity: weather.humidity,
          windKph: weather.windKph,
          iconUrl: weather.iconUrl,
          feelsLikeCelsius: weather.feelsLikeCelsius,
          visibilityKm: weather.visibilityKm,
          pressureMb: weather.pressureMb,
          uvIndex: weather.uvIndex,
          sunrise: weather.sunrise,
          sunset: weather.sunset,
          moonPhase: weather.moonPhase,
          moonrise: weather.moonrise,
          hourlyForecast: weather.hourlyForecast,
          dailyForecast: weather.dailyForecast,
          lastUpdated: DateTime.now(),
          isFromCache: !event.forceRefresh,
        ),
      );
    } on UserFriendlyException catch (e) {
      if (isClosed) return;
      emit(
        state.copyWith(
          status: WeatherStatus.failure,
          errorMessage: e.message,
          error: e,
        ),
      );
    } catch (_) {
      if (isClosed) return;
      emit(
        state.copyWith(
          status: WeatherStatus.failure,
          error: null,
          errorMessage: null,
        ),
      );
    }
  }

  Future<void> _onRefreshRequested(
    WeatherRefreshRequested event,
    Emitter<WeatherState> emit,
  ) async {
    if (state.searchQuery.isNotEmpty) {
      add(WeatherFetchRequested(state.searchQuery, forceRefresh: true));
    }
  }
}
