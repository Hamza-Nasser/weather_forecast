import 'package:equatable/equatable.dart';
import 'package:weather_app/core/app_exceptions/app_exceptions.dart';
import 'package:weather_app/features/weather/domain/entities/weather_entity.dart';

/// Represents the current weather BLoC state.
///
/// Immutable and uses [Equatable] for efficient state comparison.
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
    this.humidity = 0,
    this.windKph = 0,
    this.iconUrl,
    this.errorMessage,
    this.error,
    this.feelsLikeCelsius = 0.0,
    this.visibilityKm = 0.0,
    this.pressureMb = 0.0,
    this.uvIndex = 0.0,
    this.sunrise = '',
    this.sunset = '',
    this.moonPhase = '',
    this.moonrise = '',
    this.hourlyForecast = const [],
    this.dailyForecast = const [],
    this.lastUpdated,
    this.isFromCache = false,
  });

  final WeatherStatus status;
  final String searchQuery;
  final String cityName;
  final String region;
  final String country;
  final double temperatureCelsius;
  final String condition;
  final int humidity;
  final double windKph;
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
  final List<WeatherHourEntity> hourlyForecast;
  final List<WeatherDailyForecastEntity> dailyForecast;

  /// When the weather data was last fetched or loaded from cache.
  final DateTime? lastUpdated;

  /// Whether the current data was served from cache.
  final bool isFromCache;

  WeatherState copyWith({
    WeatherStatus? status,
    String? searchQuery,
    String? cityName,
    String? region,
    String? country,
    double? temperatureCelsius,
    String? condition,
    int? humidity,
    double? windKph,
    String? iconUrl,
    String? errorMessage,
    UserFriendlyException? error,
    double? feelsLikeCelsius,
    double? visibilityKm,
    double? pressureMb,
    double? uvIndex,
    String? sunrise,
    String? sunset,
    String? moonPhase,
    String? moonrise,
    List<WeatherHourEntity>? hourlyForecast,
    List<WeatherDailyForecastEntity>? dailyForecast,
    DateTime? lastUpdated,
    bool? isFromCache,
  }) {
    return WeatherState(
      status: status ?? this.status,
      searchQuery: searchQuery ?? this.searchQuery,
      cityName: cityName ?? this.cityName,
      region: region ?? this.region,
      country: country ?? this.country,
      temperatureCelsius: temperatureCelsius ?? this.temperatureCelsius,
      condition: condition ?? this.condition,
      humidity: humidity ?? this.humidity,
      windKph: windKph ?? this.windKph,
      iconUrl: iconUrl ?? this.iconUrl,
      errorMessage: errorMessage ?? this.errorMessage,
      error: error ?? this.error,
      feelsLikeCelsius: feelsLikeCelsius ?? this.feelsLikeCelsius,
      visibilityKm: visibilityKm ?? this.visibilityKm,
      pressureMb: pressureMb ?? this.pressureMb,
      uvIndex: uvIndex ?? this.uvIndex,
      sunrise: sunrise ?? this.sunrise,
      sunset: sunset ?? this.sunset,
      moonPhase: moonPhase ?? this.moonPhase,
      moonrise: moonrise ?? this.moonrise,
      hourlyForecast: hourlyForecast ?? this.hourlyForecast,
      dailyForecast: dailyForecast ?? this.dailyForecast,
      lastUpdated: lastUpdated ?? this.lastUpdated,
      isFromCache: isFromCache ?? this.isFromCache,
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
    humidity,
    windKph,
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
    hourlyForecast,
    dailyForecast,
    lastUpdated,
    isFromCache,
  ];
}
