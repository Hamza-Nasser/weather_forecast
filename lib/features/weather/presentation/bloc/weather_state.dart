import 'package:equatable/equatable.dart';
import 'package:weather_app/core/app_exceptions/app_exceptions.dart';
import 'package:weather_app/features/weather/domain/entities/weather_entity.dart';

enum WeatherStatus { initial, loading, success, failure }

class WeatherState extends Equatable {
  const WeatherState({
    this.status = WeatherStatus.initial,
    this.searchQuery = '',
    this.cityName = '',
    this.region = '',
    this.country = '',
    this.temperatureCelsius = 0,
    this.condition = '',
    this.conditionCode = 0,
    this.isDay = true,
    this.humidity = 0,
    this.windKph = 0,
    this.windDirection = '',
    this.windDegree = 0,
    this.iconUrl,
    this.errorMessage,
    this.error,
    this.feelsLikeCelsius = 0,
    this.visibilityKm = 0,
    this.pressureMb = 0,
    this.uvIndex = 0,
    this.sunrise = '',
    this.sunset = '',
    this.moonPhase = '',
    this.moonrise = '',
    this.locationUtcOffsetMinutes = 0,
    this.hourlyForecast = const [],
    this.dailyForecast = const [],
    this.lastUpdated,
    this.isFromCache = false,
    this.isStale = false,
  });

  final WeatherStatus status;
  final String searchQuery;
  final String cityName;
  final String region;
  final String country;
  final double temperatureCelsius;
  final String condition;
  final int conditionCode;
  final bool isDay;
  final int humidity;
  final double windKph;
  final String windDirection;
  final int windDegree;
  final String? iconUrl;
  final String? errorMessage;
  final UserFriendlyException? error;
  final double feelsLikeCelsius;
  final double visibilityKm;
  final double pressureMb;
  final double uvIndex;
  final String sunrise;
  final String sunset;
  final String moonPhase;
  final String moonrise;
  final int locationUtcOffsetMinutes;
  final List<WeatherHourEntity> hourlyForecast;
  final List<WeatherDailyForecastEntity> dailyForecast;
  final DateTime? lastUpdated;
  final bool isFromCache;
  final bool isStale;

  WeatherState copyWith({
    WeatherStatus? status,
    String? searchQuery,
    String? cityName,
    String? region,
    String? country,
    double? temperatureCelsius,
    String? condition,
    int? conditionCode,
    bool? isDay,
    int? humidity,
    double? windKph,
    String? windDirection,
    int? windDegree,
    String? iconUrl,
    String? errorMessage,
    UserFriendlyException? error,
    bool clearError = false,
    double? feelsLikeCelsius,
    double? visibilityKm,
    double? pressureMb,
    double? uvIndex,
    String? sunrise,
    String? sunset,
    String? moonPhase,
    String? moonrise,
    int? locationUtcOffsetMinutes,
    List<WeatherHourEntity>? hourlyForecast,
    List<WeatherDailyForecastEntity>? dailyForecast,
    DateTime? lastUpdated,
    bool? isFromCache,
    bool? isStale,
  }) {
    return WeatherState(
      status: status ?? this.status,
      searchQuery: searchQuery ?? this.searchQuery,
      cityName: cityName ?? this.cityName,
      region: region ?? this.region,
      country: country ?? this.country,
      temperatureCelsius: temperatureCelsius ?? this.temperatureCelsius,
      condition: condition ?? this.condition,
      conditionCode: conditionCode ?? this.conditionCode,
      isDay: isDay ?? this.isDay,
      humidity: humidity ?? this.humidity,
      windKph: windKph ?? this.windKph,
      windDirection: windDirection ?? this.windDirection,
      windDegree: windDegree ?? this.windDegree,
      iconUrl: iconUrl ?? this.iconUrl,
      errorMessage: clearError ? null : errorMessage ?? this.errorMessage,
      error: clearError ? null : error ?? this.error,
      feelsLikeCelsius: feelsLikeCelsius ?? this.feelsLikeCelsius,
      visibilityKm: visibilityKm ?? this.visibilityKm,
      pressureMb: pressureMb ?? this.pressureMb,
      uvIndex: uvIndex ?? this.uvIndex,
      sunrise: sunrise ?? this.sunrise,
      sunset: sunset ?? this.sunset,
      moonPhase: moonPhase ?? this.moonPhase,
      moonrise: moonrise ?? this.moonrise,
      locationUtcOffsetMinutes:
          locationUtcOffsetMinutes ?? this.locationUtcOffsetMinutes,
      hourlyForecast: hourlyForecast ?? this.hourlyForecast,
      dailyForecast: dailyForecast ?? this.dailyForecast,
      lastUpdated: lastUpdated ?? this.lastUpdated,
      isFromCache: isFromCache ?? this.isFromCache,
      isStale: isStale ?? this.isStale,
    );
  }

  @override
  List<Object?> get props => [
    status,
    searchQuery,
    cityName,
    region,
    country,
    temperatureCelsius,
    condition,
    conditionCode,
    isDay,
    humidity,
    windKph,
    windDirection,
    windDegree,
    iconUrl,
    errorMessage,
    error,
    feelsLikeCelsius,
    visibilityKm,
    pressureMb,
    uvIndex,
    sunrise,
    sunset,
    moonPhase,
    moonrise,
    locationUtcOffsetMinutes,
    hourlyForecast,
    dailyForecast,
    lastUpdated,
    isFromCache,
    isStale,
  ];
}
