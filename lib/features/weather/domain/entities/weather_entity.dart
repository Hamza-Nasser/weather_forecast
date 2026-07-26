import 'package:equatable/equatable.dart';

/// Domain entity representing weather data.
///
/// This is the core business object — UI and data layers depend on this.
/// Immutable and uses Equatable for value equality.
class WeatherEntity extends Equatable {
  const WeatherEntity({
    required this.cityName,
    required this.temperatureCelsius,
    required this.condition,
    required this.humidity,
    required this.windKph,
    this.iconUrl,
    this.region = '',
    this.country = '',
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
  });

  /// The name of the city.
  final String cityName;

  /// Temperature in Celsius.
  final double temperatureCelsius;

  /// Weather condition text (e.g., "Sunny", "Cloudy").
  final String condition;

  /// Humidity percentage.
  final int humidity;

  /// Wind speed in kilometers per hour.
  final double windKph;

  /// URL to the weather condition icon.
  final String? iconUrl;

  /// The geographic region.
  final String region;

  /// The geographic country.
  final String country;

  /// Feels like temperature in Celsius.
  final double feelsLikeCelsius;

  /// Visibility in kilometers.
  final double visibilityKm;

  /// Atmospheric pressure in millibars (hPa).
  final double pressureMb;

  /// UV Index.
  final double uvIndex;

  /// Sunrise time.
  final String sunrise;

  /// Sunset time.
  final String sunset;

  /// Moon phase name.
  final String moonPhase;

  /// Moonrise time.
  final String moonrise;

  /// Hourly weather forecast.
  final List<WeatherHourEntity> hourlyForecast;

  /// Daily weather forecast.
  final List<WeatherDailyForecastEntity> dailyForecast;

  @override
  List<Object?> get props => [
    cityName,
    temperatureCelsius,
    condition,
    humidity,
    windKph,
    iconUrl,
    region,
    country,
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
  ];
}

/// Domain entity representing hourly weather data.
class WeatherHourEntity extends Equatable {
  final String time;
  final double tempC;
  final String condition;
  final String iconUrl;
  final int isDay;

  const WeatherHourEntity({
    required this.time,
    required this.tempC,
    required this.condition,
    required this.iconUrl,
    required this.isDay,
  });

  @override
  List<Object?> get props => [time, tempC, condition, iconUrl, isDay];
}

/// Domain entity representing daily weather forecast.
class WeatherDailyForecastEntity extends Equatable {
  final String date;
  final double maxTempC;
  final double minTempC;
  final String condition;
  final String iconUrl;

  const WeatherDailyForecastEntity({
    required this.date,
    required this.maxTempC,
    required this.minTempC,
    required this.condition,
    required this.iconUrl,
  });

  @override
  List<Object?> get props => [date, maxTempC, minTempC, condition, iconUrl];
}
