import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:weather_app/core/app_exceptions/app_exceptions.dart';
import 'package:weather_app/core/services/app_error_reporter.dart';
import 'package:weather_app/core/services/prefs/app_preferences.dart';
import 'package:weather_app/features/weather/domain/entities/weather_entity.dart';
import 'package:weather_app/features/weather/domain/usecases/get_current_weather_usecase.dart';

import 'weather_event.dart';
import 'weather_state.dart';

@injectable
class WeatherBloc extends Bloc<WeatherEvent, WeatherState> {
  WeatherBloc(this._getCurrentWeather, this._preferences, this._errorReporter)
    : super(const WeatherState()) {
    on<WeatherFetchRequested>(_onFetchRequested);
    on<WeatherRefreshRequested>(_onRefreshRequested);
  }

  final GetCurrentWeatherUseCase _getCurrentWeather;
  final AppPreferences _preferences;
  final AppErrorReporter _errorReporter;
  int _latestRequestId = 0;

  Future<void> _onFetchRequested(
    WeatherFetchRequested event,
    Emitter<WeatherState> emit,
  ) async {
    final requestId = ++_latestRequestId;
    final query = event.city.trim();
    emit(
      state.copyWith(
        status: WeatherStatus.loading,
        searchQuery: query,
        clearError: true,
      ),
    );

    try {
      final weather = await _getCurrentWeather(
        query,
        forceRefresh: event.forceRefresh,
      );
      if (isClosed || requestId != _latestRequestId) return;

      emit(
        state.copyWith(
          status: WeatherStatus.success,
          searchQuery: query,
          cityName: weather.cityName,
          region: weather.region,
          country: weather.country,
          temperatureCelsius: weather.temperatureCelsius,
          condition: weather.condition,
          conditionCode: weather.conditionCode,
          isDay: weather.isDay,
          humidity: weather.humidity,
          windKph: weather.windKph,
          windDirection: weather.windDirection,
          windDegree: weather.windDegree,
          iconUrl: weather.iconUrl,
          feelsLikeCelsius: weather.feelsLikeCelsius,
          visibilityKm: weather.visibilityKm,
          pressureMb: weather.pressureMb,
          uvIndex: weather.uvIndex,
          sunrise: weather.sunrise,
          sunset: weather.sunset,
          moonPhase: weather.moonPhase,
          moonrise: weather.moonrise,
          locationUtcOffsetMinutes: weather.locationUtcOffsetMinutes,
          hourlyForecast: weather.hourlyForecast,
          dailyForecast: weather.dailyForecast,
          lastUpdated: weather.observedAt ?? DateTime.now().toUtc(),
          isFromCache: weather.dataSource != WeatherDataSource.network,
          isStale: weather.dataSource == WeatherDataSource.staleCache,
          clearError: true,
        ),
      );

      try {
        await _preferences.setLastCity(query);
      } catch (error, stackTrace) {
        _errorReporter.record(
          error,
          stackTrace,
          context: 'Persist last successful city',
        );
      }
    } on UserFriendlyException catch (error) {
      if (isClosed || requestId != _latestRequestId) return;
      emit(
        state.copyWith(
          status: WeatherStatus.failure,
          errorMessage: error.message,
          error: error,
        ),
      );
    } catch (error, stackTrace) {
      _errorReporter.record(error, stackTrace, context: 'Fetch weather');
      if (isClosed || requestId != _latestRequestId) return;
      emit(state.copyWith(status: WeatherStatus.failure, clearError: true));
    }
  }

  void _onRefreshRequested(
    WeatherRefreshRequested event,
    Emitter<WeatherState> emit,
  ) {
    if (state.searchQuery.isNotEmpty) {
      add(WeatherFetchRequested(state.searchQuery, forceRefresh: true));
    }
  }
}
