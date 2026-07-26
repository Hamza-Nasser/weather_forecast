import 'package:json_annotation/json_annotation.dart';
import 'package:weather_app/features/weather/domain/entities/weather_entity.dart';
import 'package:weather_app/features/weather/domain/utils/weather_location_time.dart';

part 'weather_model.g.dart';

@JsonSerializable(explicitToJson: true)
class WeatherModel {
  const WeatherModel({
    required this.location,
    required this.current,
    this.forecast,
  });

  final WeatherLocationModel location;
  final WeatherCurrentModel current;
  final WeatherForecastModel? forecast;

  factory WeatherModel.fromJson(Map<String, dynamic> json) =>
      _$WeatherModelFromJson(json);

  Map<String, dynamic> toJson() => _$WeatherModelToJson(this);

  WeatherEntity toEntity({
    WeatherDataSource dataSource = WeatherDataSource.network,
  }) {
    final astro = forecast?.forecastDay.firstOrNull?.astro;
    return WeatherEntity(
      cityName: location.name,
      region: location.region,
      country: location.country,
      temperatureCelsius: current.tempC,
      condition: current.condition.text,
      conditionCode: current.condition.code,
      isDay: current.isDay != 0,
      humidity: current.humidity,
      windKph: current.windKph,
      windDirection: current.windDir,
      windDegree: current.windDegree,
      iconUrl: _normalizeIcon(current.condition.icon),
      feelsLikeCelsius: current.feelsLikeC,
      visibilityKm: current.visKm,
      pressureMb: current.pressureMb,
      uvIndex: current.uv,
      sunrise: astro?.sunrise ?? '',
      sunset: astro?.sunset ?? '',
      moonPhase: astro?.moonPhase ?? '',
      moonrise: astro?.moonrise ?? '',
      locationUtcOffsetMinutes: WeatherLocationTime.offsetMinutes(
        localTime: location.localtime,
        epochSeconds: location.localtimeEpoch,
      ),
      observedAt: current.lastUpdatedEpoch > 0
          ? DateTime.fromMillisecondsSinceEpoch(
              current.lastUpdatedEpoch * 1000,
              isUtc: true,
            )
          : null,
      hourlyForecast:
          forecast?.forecastDay.firstOrNull?.hour
              .map(
                (hour) => WeatherHourEntity(
                  time: hour.time,
                  timeEpoch: hour.timeEpoch,
                  tempC: hour.tempC,
                  condition: hour.condition.text,
                  conditionCode: hour.condition.code,
                  iconUrl: _normalizeIcon(hour.condition.icon),
                  isDay: hour.isDay,
                ),
              )
              .toList(growable: false) ??
          const [],
      dailyForecast:
          forecast?.forecastDay
              .map(
                (day) => WeatherDailyForecastEntity(
                  date: day.date,
                  dateEpoch: day.dateEpoch,
                  maxTempC: day.day.maxTempC,
                  minTempC: day.day.minTempC,
                  condition: day.day.condition.text,
                  conditionCode: day.day.condition.code,
                  iconUrl: _normalizeIcon(day.day.condition.icon),
                ),
              )
              .toList(growable: false) ??
          const [],
      dataSource: dataSource,
    );
  }

  static String _normalizeIcon(String icon) {
    if (icon.startsWith('http')) return icon;
    if (icon.startsWith('//')) return 'https:$icon';
    return 'https://$icon';
  }
}

@JsonSerializable()
class WeatherLocationModel {
  const WeatherLocationModel({
    required this.name,
    this.region = '',
    this.country = '',
    this.tzId = '',
    this.localtime = '',
    this.localtimeEpoch = 0,
  });

  final String name;
  @JsonKey(defaultValue: '')
  final String region;
  @JsonKey(defaultValue: '')
  final String country;
  @JsonKey(name: 'tz_id', defaultValue: '')
  final String tzId;
  @JsonKey(defaultValue: '')
  final String localtime;
  @JsonKey(name: 'localtime_epoch', defaultValue: 0)
  final int localtimeEpoch;

  factory WeatherLocationModel.fromJson(Map<String, dynamic> json) =>
      _$WeatherLocationModelFromJson(json);
  Map<String, dynamic> toJson() => _$WeatherLocationModelToJson(this);
}

@JsonSerializable(explicitToJson: true)
class WeatherCurrentModel {
  const WeatherCurrentModel({
    required this.tempC,
    required this.condition,
    required this.humidity,
    required this.windKph,
    required this.feelsLikeC,
    required this.visKm,
    required this.pressureMb,
    required this.uv,
    this.isDay = 1,
    this.windDegree = 0,
    this.windDir = '',
    this.lastUpdatedEpoch = 0,
  });

  @JsonKey(name: 'temp_c')
  final double tempC;
  final WeatherConditionModel condition;
  final int humidity;
  @JsonKey(name: 'wind_kph')
  final double windKph;
  @JsonKey(name: 'feelslike_c')
  final double feelsLikeC;
  @JsonKey(name: 'vis_km')
  final double visKm;
  @JsonKey(name: 'pressure_mb')
  final double pressureMb;
  final double uv;
  @JsonKey(name: 'is_day', defaultValue: 1)
  final int isDay;
  @JsonKey(name: 'wind_degree', defaultValue: 0)
  final int windDegree;
  @JsonKey(name: 'wind_dir', defaultValue: '')
  final String windDir;
  @JsonKey(name: 'last_updated_epoch', defaultValue: 0)
  final int lastUpdatedEpoch;

  factory WeatherCurrentModel.fromJson(Map<String, dynamic> json) =>
      _$WeatherCurrentModelFromJson(json);
  Map<String, dynamic> toJson() => _$WeatherCurrentModelToJson(this);
}

@JsonSerializable()
class WeatherConditionModel {
  const WeatherConditionModel({
    required this.text,
    required this.icon,
    this.code = 0,
  });

  final String text;
  final String icon;
  @JsonKey(defaultValue: 0)
  final int code;

  factory WeatherConditionModel.fromJson(Map<String, dynamic> json) =>
      _$WeatherConditionModelFromJson(json);
  Map<String, dynamic> toJson() => _$WeatherConditionModelToJson(this);
}

@JsonSerializable(explicitToJson: true)
class WeatherForecastModel {
  const WeatherForecastModel({required this.forecastDay});

  @JsonKey(name: 'forecastday')
  final List<WeatherForecastDayModel> forecastDay;

  factory WeatherForecastModel.fromJson(Map<String, dynamic> json) =>
      _$WeatherForecastModelFromJson(json);
  Map<String, dynamic> toJson() => _$WeatherForecastModelToJson(this);
}

@JsonSerializable(explicitToJson: true)
class WeatherForecastDayModel {
  const WeatherForecastDayModel({
    required this.date,
    required this.astro,
    required this.day,
    required this.hour,
    this.dateEpoch = 0,
  });

  final String date;
  @JsonKey(name: 'date_epoch', defaultValue: 0)
  final int dateEpoch;
  final WeatherAstroModel astro;
  final WeatherDayModel day;
  final List<WeatherHourModel> hour;

  factory WeatherForecastDayModel.fromJson(Map<String, dynamic> json) =>
      _$WeatherForecastDayModelFromJson(json);
  Map<String, dynamic> toJson() => _$WeatherForecastDayModelToJson(this);
}

@JsonSerializable(explicitToJson: true)
class WeatherDayModel {
  const WeatherDayModel({
    required this.maxTempC,
    required this.minTempC,
    required this.avgTempC,
    required this.maxWindKph,
    required this.uv,
    required this.condition,
  });

  @JsonKey(name: 'maxtemp_c')
  final double maxTempC;
  @JsonKey(name: 'mintemp_c')
  final double minTempC;
  @JsonKey(name: 'avgtemp_c')
  final double avgTempC;
  @JsonKey(name: 'maxwind_kph')
  final double maxWindKph;
  final double uv;
  final WeatherConditionModel condition;

  factory WeatherDayModel.fromJson(Map<String, dynamic> json) =>
      _$WeatherDayModelFromJson(json);
  Map<String, dynamic> toJson() => _$WeatherDayModelToJson(this);
}

@JsonSerializable(explicitToJson: true)
class WeatherHourModel {
  const WeatherHourModel({
    required this.time,
    required this.tempC,
    required this.condition,
    required this.isDay,
    this.timeEpoch = 0,
  });

  final String time;
  @JsonKey(name: 'time_epoch', defaultValue: 0)
  final int timeEpoch;
  @JsonKey(name: 'temp_c')
  final double tempC;
  final WeatherConditionModel condition;
  @JsonKey(name: 'is_day')
  final int isDay;

  factory WeatherHourModel.fromJson(Map<String, dynamic> json) =>
      _$WeatherHourModelFromJson(json);
  Map<String, dynamic> toJson() => _$WeatherHourModelToJson(this);
}

@JsonSerializable()
class WeatherAstroModel {
  const WeatherAstroModel({
    required this.sunrise,
    required this.sunset,
    required this.moonrise,
    required this.moonPhase,
  });

  final String sunrise;
  final String sunset;
  final String moonrise;
  @JsonKey(name: 'moon_phase')
  final String moonPhase;

  factory WeatherAstroModel.fromJson(Map<String, dynamic> json) =>
      _$WeatherAstroModelFromJson(json);
  Map<String, dynamic> toJson() => _$WeatherAstroModelToJson(this);
}
