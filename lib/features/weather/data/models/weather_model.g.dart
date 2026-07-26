// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'weather_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

WeatherModel _$WeatherModelFromJson(Map<String, dynamic> json) => WeatherModel(
  location: WeatherLocationModel.fromJson(
    json['location'] as Map<String, dynamic>,
  ),
  current: WeatherCurrentModel.fromJson(
    json['current'] as Map<String, dynamic>,
  ),
  forecast: json['forecast'] == null
      ? null
      : WeatherForecastModel.fromJson(json['forecast'] as Map<String, dynamic>),
);

Map<String, dynamic> _$WeatherModelToJson(WeatherModel instance) =>
    <String, dynamic>{
      'location': instance.location.toJson(),
      'current': instance.current.toJson(),
      'forecast': instance.forecast?.toJson(),
    };

WeatherLocationModel _$WeatherLocationModelFromJson(
  Map<String, dynamic> json,
) => WeatherLocationModel(
  name: json['name'] as String,
  region: json['region'] as String?,
  country: json['country'] as String?,
);

Map<String, dynamic> _$WeatherLocationModelToJson(
  WeatherLocationModel instance,
) => <String, dynamic>{
  'name': instance.name,
  'region': instance.region,
  'country': instance.country,
};

WeatherCurrentModel _$WeatherCurrentModelFromJson(Map<String, dynamic> json) =>
    WeatherCurrentModel(
      tempC: (json['temp_c'] as num).toDouble(),
      condition: WeatherConditionModel.fromJson(
        json['condition'] as Map<String, dynamic>,
      ),
      humidity: (json['humidity'] as num).toInt(),
      windKph: (json['wind_kph'] as num).toDouble(),
      feelsLikeC: (json['feelslike_c'] as num).toDouble(),
      visKm: (json['vis_km'] as num).toDouble(),
      pressureMb: (json['pressure_mb'] as num).toDouble(),
      uv: (json['uv'] as num).toDouble(),
    );

Map<String, dynamic> _$WeatherCurrentModelToJson(
  WeatherCurrentModel instance,
) => <String, dynamic>{
  'temp_c': instance.tempC,
  'condition': instance.condition.toJson(),
  'humidity': instance.humidity,
  'wind_kph': instance.windKph,
  'feelslike_c': instance.feelsLikeC,
  'vis_km': instance.visKm,
  'pressure_mb': instance.pressureMb,
  'uv': instance.uv,
};

WeatherConditionModel _$WeatherConditionModelFromJson(
  Map<String, dynamic> json,
) => WeatherConditionModel(
  text: json['text'] as String,
  icon: json['icon'] as String,
);

Map<String, dynamic> _$WeatherConditionModelToJson(
  WeatherConditionModel instance,
) => <String, dynamic>{'text': instance.text, 'icon': instance.icon};

WeatherForecastModel _$WeatherForecastModelFromJson(
  Map<String, dynamic> json,
) => WeatherForecastModel(
  forecastDay: (json['forecastday'] as List<dynamic>)
      .map((e) => WeatherForecastDayModel.fromJson(e as Map<String, dynamic>))
      .toList(),
);

Map<String, dynamic> _$WeatherForecastModelToJson(
  WeatherForecastModel instance,
) => <String, dynamic>{
  'forecastday': instance.forecastDay.map((e) => e.toJson()).toList(),
};

WeatherForecastDayModel _$WeatherForecastDayModelFromJson(
  Map<String, dynamic> json,
) => WeatherForecastDayModel(
  date: json['date'] as String,
  astro: WeatherAstroModel.fromJson(json['astro'] as Map<String, dynamic>),
  day: WeatherDayModel.fromJson(json['day'] as Map<String, dynamic>),
  hour: (json['hour'] as List<dynamic>)
      .map((e) => WeatherHourModel.fromJson(e as Map<String, dynamic>))
      .toList(),
);

Map<String, dynamic> _$WeatherForecastDayModelToJson(
  WeatherForecastDayModel instance,
) => <String, dynamic>{
  'date': instance.date,
  'astro': instance.astro.toJson(),
  'day': instance.day.toJson(),
  'hour': instance.hour.map((e) => e.toJson()).toList(),
};

WeatherDayModel _$WeatherDayModelFromJson(Map<String, dynamic> json) =>
    WeatherDayModel(
      maxTempC: (json['maxtemp_c'] as num).toDouble(),
      minTempC: (json['mintemp_c'] as num).toDouble(),
      avgTempC: (json['avgtemp_c'] as num).toDouble(),
      maxWindKph: (json['maxwind_kph'] as num).toDouble(),
      uv: (json['uv'] as num).toDouble(),
      condition: WeatherConditionModel.fromJson(
        json['condition'] as Map<String, dynamic>,
      ),
    );

Map<String, dynamic> _$WeatherDayModelToJson(WeatherDayModel instance) =>
    <String, dynamic>{
      'maxtemp_c': instance.maxTempC,
      'mintemp_c': instance.minTempC,
      'avgtemp_c': instance.avgTempC,
      'maxwind_kph': instance.maxWindKph,
      'uv': instance.uv,
      'condition': instance.condition.toJson(),
    };

WeatherHourModel _$WeatherHourModelFromJson(Map<String, dynamic> json) =>
    WeatherHourModel(
      time: json['time'] as String,
      tempC: (json['temp_c'] as num).toDouble(),
      condition: WeatherConditionModel.fromJson(
        json['condition'] as Map<String, dynamic>,
      ),
      isDay: (json['is_day'] as num).toInt(),
    );

Map<String, dynamic> _$WeatherHourModelToJson(WeatherHourModel instance) =>
    <String, dynamic>{
      'time': instance.time,
      'temp_c': instance.tempC,
      'condition': instance.condition.toJson(),
      'is_day': instance.isDay,
    };

WeatherAstroModel _$WeatherAstroModelFromJson(Map<String, dynamic> json) =>
    WeatherAstroModel(
      sunrise: json['sunrise'] as String,
      sunset: json['sunset'] as String,
      moonrise: json['moonrise'] as String,
      moonPhase: json['moon_phase'] as String,
    );

Map<String, dynamic> _$WeatherAstroModelToJson(WeatherAstroModel instance) =>
    <String, dynamic>{
      'sunrise': instance.sunrise,
      'sunset': instance.sunset,
      'moonrise': instance.moonrise,
      'moon_phase': instance.moonPhase,
    };
