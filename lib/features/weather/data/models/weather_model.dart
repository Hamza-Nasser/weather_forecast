import 'package:json_annotation/json_annotation.dart';
import 'package:weather_app/features/weather/domain/entities/weather_entity.dart';

part 'weather_model.g.dart';

/// DTO model representing the raw weather API response.
@JsonSerializable(explicitToJson: true)
class WeatherModel {
  final WeatherLocationModel location;
  final WeatherCurrentModel current;
  final WeatherForecastModel? forecast;

  const WeatherModel({
    required this.location,
    required this.current,
    this.forecast,
  });

  factory WeatherModel.fromJson(Map<String, dynamic> json) =>
      _$WeatherModelFromJson(json);

  Map<String, dynamic> toJson() => _$WeatherModelToJson(this);

  /// Maps the API DTO model to the domain [WeatherEntity].
  WeatherEntity toEntity() {
    // Weather API icon URLs are typically relative starting with "//cdn.weatherapi.com/..."
    final icon = current.condition.icon;
    final normalizedIconUrl = icon.startsWith('http')
        ? icon
        : icon.startsWith('//')
            ? 'https:$icon'
            : 'https://$icon';

    final astro = forecast?.forecastDay.isNotEmpty == true
        ? forecast!.forecastDay.first.astro
        : null;

    final hours = forecast?.forecastDay.isNotEmpty == true
        ? forecast!.forecastDay.first.hour.map((h) {
            final hourIcon = h.condition.icon;
            final normalizedHourIconUrl = hourIcon.startsWith('http')
                ? hourIcon
                : hourIcon.startsWith('//')
                    ? 'https:$hourIcon'
                    : 'https://$hourIcon';
            return WeatherHourEntity(
              time: h.time,
              tempC: h.tempC,
              condition: h.condition.text,
              iconUrl: normalizedHourIconUrl,
              isDay: h.isDay,
            );
          }).toList()
        : const <WeatherHourEntity>[];

    final daily = forecast?.forecastDay.map((d) {
          final dayIcon = d.day.condition.icon;
          final normalizedDayIconUrl = dayIcon.startsWith('http')
              ? dayIcon
              : dayIcon.startsWith('//')
                  ? 'https:$dayIcon'
                  : 'https://$dayIcon';
          return WeatherDailyForecastEntity(
            date: d.date,
            maxTempC: d.day.maxTempC,
            minTempC: d.day.minTempC,
            condition: d.day.condition.text,
            iconUrl: normalizedDayIconUrl,
          );
        }).toList() ?? const <WeatherDailyForecastEntity>[];

    return WeatherEntity(
      cityName: location.name,
      temperatureCelsius: current.tempC,
      condition: current.condition.text,
      humidity: current.humidity,
      windKph: current.windKph,
      iconUrl: normalizedIconUrl,
      region: location.region ?? '',
      country: location.country ?? '',
      feelsLikeCelsius: current.feelsLikeC,
      visibilityKm: current.visKm,
      pressureMb: current.pressureMb,
      uvIndex: current.uv,
      sunrise: astro?.sunrise ?? '',
      sunset: astro?.sunset ?? '',
      moonPhase: astro?.moonPhase ?? '',
      moonrise: astro?.moonrise ?? '',
      hourlyForecast: hours,
      dailyForecast: daily,
    );
  }
}

@JsonSerializable(explicitToJson: true)
class WeatherLocationModel {
  final String name;
  final String? region;
  final String? country;

  const WeatherLocationModel({
    required this.name,
    this.region,
    this.country,
  });

  factory WeatherLocationModel.fromJson(Map<String, dynamic> json) =>
      _$WeatherLocationModelFromJson(json);

  Map<String, dynamic> toJson() => _$WeatherLocationModelToJson(this);
}

@JsonSerializable(explicitToJson: true)
class WeatherCurrentModel {
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

  const WeatherCurrentModel({
    required this.tempC,
    required this.condition,
    required this.humidity,
    required this.windKph,
    required this.feelsLikeC,
    required this.visKm,
    required this.pressureMb,
    required this.uv,
  });

  factory WeatherCurrentModel.fromJson(Map<String, dynamic> json) =>
      _$WeatherCurrentModelFromJson(json);

  Map<String, dynamic> toJson() => _$WeatherCurrentModelToJson(this);
}

@JsonSerializable(explicitToJson: true)
class WeatherConditionModel {
  final String text;
  final String icon;

  const WeatherConditionModel({
    required this.text,
    required this.icon,
  });

  factory WeatherConditionModel.fromJson(Map<String, dynamic> json) =>
      _$WeatherConditionModelFromJson(json);

  Map<String, dynamic> toJson() => _$WeatherConditionModelToJson(this);
}

@JsonSerializable(explicitToJson: true)
class WeatherForecastModel {
  @JsonKey(name: 'forecastday')
  final List<WeatherForecastDayModel> forecastDay;

  const WeatherForecastModel({
    required this.forecastDay,
  });

  factory WeatherForecastModel.fromJson(Map<String, dynamic> json) =>
      _$WeatherForecastModelFromJson(json);

  Map<String, dynamic> toJson() => _$WeatherForecastModelToJson(this);
}

@JsonSerializable(explicitToJson: true)
class WeatherForecastDayModel {
  final String date;
  final WeatherAstroModel astro;
  final WeatherDayModel day;
  final List<WeatherHourModel> hour;

  const WeatherForecastDayModel({
    required this.date,
    required this.astro,
    required this.day,
    required this.hour,
  });

  factory WeatherForecastDayModel.fromJson(Map<String, dynamic> json) =>
      _$WeatherForecastDayModelFromJson(json);

  Map<String, dynamic> toJson() => _$WeatherForecastDayModelToJson(this);
}

@JsonSerializable(explicitToJson: true)
class WeatherDayModel {
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

  const WeatherDayModel({
    required this.maxTempC,
    required this.minTempC,
    required this.avgTempC,
    required this.maxWindKph,
    required this.uv,
    required this.condition,
  });

  factory WeatherDayModel.fromJson(Map<String, dynamic> json) =>
      _$WeatherDayModelFromJson(json);

  Map<String, dynamic> toJson() => _$WeatherDayModelToJson(this);
}

@JsonSerializable(explicitToJson: true)
class WeatherHourModel {
  final String time;

  @JsonKey(name: 'temp_c')
  final double tempC;

  final WeatherConditionModel condition;

  @JsonKey(name: 'is_day')
  final int isDay;

  const WeatherHourModel({
    required this.time,
    required this.tempC,
    required this.condition,
    required this.isDay,
  });

  factory WeatherHourModel.fromJson(Map<String, dynamic> json) =>
      _$WeatherHourModelFromJson(json);

  Map<String, dynamic> toJson() => _$WeatherHourModelToJson(this);
}

@JsonSerializable(explicitToJson: true)
class WeatherAstroModel {
  final String sunrise;
  final String sunset;
  final String moonrise;
  
  @JsonKey(name: 'moon_phase')
  final String moonPhase;

  const WeatherAstroModel({
    required this.sunrise,
    required this.sunset,
    required this.moonrise,
    required this.moonPhase,
  });

  factory WeatherAstroModel.fromJson(Map<String, dynamic> json) =>
      _$WeatherAstroModelFromJson(json);

  Map<String, dynamic> toJson() => _$WeatherAstroModelToJson(this);
}
