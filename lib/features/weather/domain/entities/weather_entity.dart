import 'package:equatable/equatable.dart';

enum WeatherDataSource { network, cache, staleCache }

class WeatherEntity extends Equatable {
  const WeatherEntity({
    required this.cityName,
    required this.temperatureCelsius,
    required this.condition,
    required this.humidity,
    required this.windKph,
    this.conditionCode = 0,
    this.isDay = true,
    this.windDirection = '',
    this.windDegree = 0,
    this.iconUrl,
    this.region = '',
    this.country = '',
    this.feelsLikeCelsius = 0,
    this.visibilityKm = 0,
    this.pressureMb = 0,
    this.uvIndex = 0,
    this.sunrise = '',
    this.sunset = '',
    this.moonPhase = '',
    this.moonrise = '',
    this.locationUtcOffsetMinutes = 0,
    this.observedAt,
    this.hourlyForecast = const [],
    this.dailyForecast = const [],
    this.dataSource = WeatherDataSource.network,
  });

  final String cityName;
  final double temperatureCelsius;
  final String condition;
  final int conditionCode;
  final bool isDay;
  final int humidity;
  final double windKph;
  final String windDirection;
  final int windDegree;
  final String? iconUrl;
  final String region;
  final String country;
  final double feelsLikeCelsius;
  final double visibilityKm;
  final double pressureMb;
  final double uvIndex;
  final String sunrise;
  final String sunset;
  final String moonPhase;
  final String moonrise;
  final int locationUtcOffsetMinutes;
  final DateTime? observedAt;
  final List<WeatherHourEntity> hourlyForecast;
  final List<WeatherDailyForecastEntity> dailyForecast;
  final WeatherDataSource dataSource;

  @override
  List<Object?> get props => [
    cityName,
    temperatureCelsius,
    condition,
    conditionCode,
    isDay,
    humidity,
    windKph,
    windDirection,
    windDegree,
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
    locationUtcOffsetMinutes,
    observedAt,
    hourlyForecast,
    dailyForecast,
    dataSource,
  ];
}

class WeatherHourEntity extends Equatable {
  const WeatherHourEntity({
    required this.time,
    required this.tempC,
    required this.condition,
    required this.iconUrl,
    required this.isDay,
    this.timeEpoch = 0,
    this.conditionCode = 0,
  });

  final String time;
  final int timeEpoch;
  final double tempC;
  final String condition;
  final int conditionCode;
  final String iconUrl;
  final int isDay;

  @override
  List<Object?> get props => [
    time,
    timeEpoch,
    tempC,
    condition,
    conditionCode,
    iconUrl,
    isDay,
  ];
}

class WeatherDailyForecastEntity extends Equatable {
  const WeatherDailyForecastEntity({
    required this.date,
    required this.maxTempC,
    required this.minTempC,
    required this.condition,
    required this.iconUrl,
    this.dateEpoch = 0,
    this.conditionCode = 0,
  });

  final String date;
  final int dateEpoch;
  final double maxTempC;
  final double minTempC;
  final String condition;
  final int conditionCode;
  final String iconUrl;

  @override
  List<Object?> get props => [
    date,
    dateEpoch,
    maxTempC,
    minTempC,
    condition,
    conditionCode,
    iconUrl,
  ];
}
