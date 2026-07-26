import 'package:flutter_test/flutter_test.dart';
import 'package:weather_app/features/weather/data/models/weather_model.dart';
import 'package:weather_app/features/weather/domain/entities/weather_entity.dart';

void main() {
  group('WeatherModel', () {
    const fullJson = {
      'location': {
        'name': 'Cairo',
        'region': 'Cairo Governorate',
        'country': 'Egypt',
      },
      'current': {
        'temp_c': 35.0,
        'condition': {
          'text': 'Sunny',
          'icon': '//cdn.weatherapi.com/sunny.png',
        },
        'humidity': 20,
        'wind_kph': 15.0,
        'feelslike_c': 38.0,
        'vis_km': 10.0,
        'pressure_mb': 1013.0,
        'uv': 8.0,
      },
      'forecast': {
        'forecastday': [
          {
            'date': '2026-07-25',
            'astro': {
              'sunrise': '05:30 AM',
              'sunset': '07:15 PM',
              'moonrise': '10:30 PM',
              'moon_phase': 'Waxing Crescent',
            },
            'day': {
              'maxtemp_c': 38.0,
              'mintemp_c': 28.0,
              'avgtemp_c': 33.0,
              'maxwind_kph': 20.0,
              'uv': 8.0,
              'condition': {
                'text': 'Hot',
                'icon': '//cdn.weatherapi.com/hot.png',
              },
            },
            'hour': [
              {
                'time': '2026-07-25 14:00',
                'temp_c': 36.0,
                'condition': {
                  'text': 'Sunny',
                  'icon': '//cdn.weatherapi.com/sunny.png',
                },
                'is_day': 1,
              },
            ],
          },
        ],
      },
    };

    test('fromJson creates valid model', () {
      final model = WeatherModel.fromJson(fullJson);

      expect(model.location.name, 'Cairo');
      expect(model.location.region, 'Cairo Governorate');
      expect(model.location.country, 'Egypt');
      expect(model.current.tempC, 35.0);
      expect(model.current.condition.text, 'Sunny');
      expect(model.current.humidity, 20);
      expect(model.current.windKph, 15.0);
      expect(model.current.feelsLikeC, 38.0);
      expect(model.current.visKm, 10.0);
      expect(model.current.pressureMb, 1013.0);
      expect(model.current.uv, 8.0);
    });

    test('toJson produces valid serializable JSON map', () {
      final model = WeatherModel.fromJson(fullJson);
      final json = model.toJson();

      // With explicitToJson: true, toJson returns serializable Maps
      expect(json['location'], isA<Map<String, dynamic>>());
      expect(json['current'], isA<Map<String, dynamic>>());
      final location = json['location'] as Map<String, dynamic>;
      final current = json['current'] as Map<String, dynamic>;
      expect(location['name'], 'Cairo');
      expect(current['temp_c'], 35.0);
    });

    test('fromJson produces same entity on same input', () {
      final model1 = WeatherModel.fromJson(fullJson);
      final model2 = WeatherModel.fromJson(fullJson);

      final entity1 = model1.toEntity();
      final entity2 = model2.toEntity();

      expect(entity1, equals(entity2));
    });

    group('toEntity', () {
      test('maps all fields correctly', () {
        final entity = WeatherModel.fromJson(fullJson).toEntity();

        expect(entity.cityName, 'Cairo');
        expect(entity.region, 'Cairo Governorate');
        expect(entity.country, 'Egypt');
        expect(entity.temperatureCelsius, 35.0);
        expect(entity.condition, 'Sunny');
        expect(entity.humidity, 20);
        expect(entity.windKph, 15.0);
        expect(entity.feelsLikeCelsius, 38.0);
        expect(entity.visibilityKm, 10.0);
        expect(entity.pressureMb, 1013.0);
        expect(entity.uvIndex, 8.0);
        expect(entity.sunrise, '05:30 AM');
        expect(entity.sunset, '07:15 PM');
        expect(entity.moonPhase, 'Waxing Crescent');
        expect(entity.moonrise, '10:30 PM');
      });

      test('normalizes icon URLs with // prefix', () {
        final entity = WeatherModel.fromJson(fullJson).toEntity();

        expect(entity.iconUrl, startsWith('https://'));
        expect(entity.iconUrl, contains('cdn.weatherapi.com'));
      });

      test('maps hourly forecast correctly', () {
        final entity = WeatherModel.fromJson(fullJson).toEntity();

        expect(entity.hourlyForecast, hasLength(1));
        expect(entity.hourlyForecast.first.tempC, 36.0);
        expect(entity.hourlyForecast.first.condition, 'Sunny');
        expect(entity.hourlyForecast.first.isDay, isTrue);
      });

      test('maps daily forecast correctly', () {
        final entity = WeatherModel.fromJson(fullJson).toEntity();

        expect(entity.dailyForecast, hasLength(1));
        expect(entity.dailyForecast.first.maxTempC, 38.0);
        expect(entity.dailyForecast.first.minTempC, 28.0);
        expect(entity.dailyForecast.first.date, '2026-07-25');
        expect(entity.dailyForecast.first.condition, 'Hot');
      });

      test('handles missing forecast gracefully', () {
        final minimalJson = {
          'location': {'name': 'Test', 'region': null, 'country': null},
          'current': {
            'temp_c': 20.0,
            'condition': {'text': 'Cloudy', 'icon': 'https://icon.png'},
            'humidity': 50,
            'wind_kph': 10.0,
            'feelslike_c': 19.0,
            'vis_km': 8.0,
            'pressure_mb': 1010.0,
            'uv': 3.0,
          },
        };

        final entity = WeatherModel.fromJson(minimalJson).toEntity();

        expect(entity.cityName, 'Test');
        expect(entity.hourlyForecast, isEmpty);
        expect(entity.dailyForecast, isEmpty);
        expect(entity.sunrise, '');
        expect(entity.sunset, '');
      });
    });
  });

  group('WeatherEntity', () {
    test('equality works via Equatable', () {
      const entity1 = WeatherEntity(
        cityName: 'Cairo',
        temperatureCelsius: 35.0,
        condition: 'Sunny',
        humidity: 20,
        windKph: 15.0,
      );
      const entity2 = WeatherEntity(
        cityName: 'Cairo',
        temperatureCelsius: 35.0,
        condition: 'Sunny',
        humidity: 20,
        windKph: 15.0,
      );

      expect(entity1, equals(entity2));
    });

    test('different values produce inequality', () {
      const entity1 = WeatherEntity(
        cityName: 'Cairo',
        temperatureCelsius: 35.0,
        condition: 'Sunny',
        humidity: 20,
        windKph: 15.0,
      );
      const entity2 = WeatherEntity(
        cityName: 'London',
        temperatureCelsius: 18.0,
        condition: 'Cloudy',
        humidity: 70,
        windKph: 8.0,
      );

      expect(entity1, isNot(equals(entity2)));
    });
  });

  group('WeatherHourEntity', () {
    test('equality works via Equatable', () {
      const hour1 = WeatherHourEntity(
        time: '2026-07-25 14:00',
        tempC: 36.0,
        condition: 'Sunny',
        iconUrl: 'https://icon.png',
        isDay: true,
      );
      const hour2 = WeatherHourEntity(
        time: '2026-07-25 14:00',
        tempC: 36.0,
        condition: 'Sunny',
        iconUrl: 'https://icon.png',
        isDay: true,
      );

      expect(hour1, equals(hour2));
    });
  });

  group('WeatherDailyForecastEntity', () {
    test('equality works via Equatable', () {
      const daily1 = WeatherDailyForecastEntity(
        date: '2026-07-25',
        maxTempC: 38.0,
        minTempC: 28.0,
        condition: 'Hot',
        iconUrl: 'https://icon.png',
      );
      const daily2 = WeatherDailyForecastEntity(
        date: '2026-07-25',
        maxTempC: 38.0,
        minTempC: 28.0,
        condition: 'Hot',
        iconUrl: 'https://icon.png',
      );

      expect(daily1, equals(daily2));
    });
  });
}
