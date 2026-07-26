import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:weather_app/core/cache/cache_client.dart';
import 'package:weather_app/features/weather/data/models/weather_model.dart';
import 'package:weather_app/features/weather/data/repositories/weather_repository_impl.dart';
import 'package:weather_app/features/weather/data/sources/weather_remote_source.dart';

class MockWeatherRemoteSource extends Mock implements WeatherRemoteSource {}

class MockCacheClient extends Mock implements CacheClient {}

void main() {
  late MockWeatherRemoteSource mockRemoteSource;
  late MockCacheClient mockCacheClient;
  late WeatherRepositoryImpl sut;

  const testCity = 'Cairo';
  const cacheKey = 'weather_current_cairo';

  final testModelJson = <String, dynamic>{
    'location': {
      'name': 'Cairo',
      'region': 'Cairo Governorate',
      'country': 'Egypt',
    },
    'current': {
      'temp_c': 35.0,
      'condition': {
        'text': 'Sunny',
        'icon': 'https://cdn.weatherapi.com/sunny.png',
      },
      'humidity': 20,
      'wind_kph': 15.0,
      'feelslike_c': 38.0,
      'vis_km': 10.0,
      'pressure_mb': 1013.0,
      'uv': 8.0,
    },
    'forecast': {
      'forecastday': <Map<String, dynamic>>[],
    },
  };

  late WeatherModel testModel;
  late String cachedJson;

  setUp(() {
    mockRemoteSource = MockWeatherRemoteSource();
    mockCacheClient = MockCacheClient();
    sut = WeatherRepositoryImpl(mockRemoteSource, mockCacheClient);

    testModel = WeatherModel.fromJson(testModelJson);
    cachedJson = jsonEncode(testModel.toJson());
  });

  group('WeatherRepositoryImpl', () {
    group('getCurrentWeather', () {
      test('returns cached data when cache hit and not forceRefresh', () async {
        when(() => mockCacheClient.get(cacheKey))
            .thenAnswer((_) async => cachedJson);

        final result = await sut.getCurrentWeather(testCity);

        expect(result.cityName, 'Cairo');
        expect(result.temperatureCelsius, 35.0);
        verifyNever(() => mockRemoteSource.getCurrentWeather(any()));
      });

      test('fetches from server on cache miss', () async {
        when(() => mockCacheClient.get(cacheKey))
            .thenAnswer((_) async => null);
        when(() => mockRemoteSource.getCurrentWeather(testCity))
            .thenAnswer((_) async => testModel);
        when(() => mockCacheClient.put(cacheKey, any()))
            .thenAnswer((_) async {});

        final result = await sut.getCurrentWeather(testCity);

        expect(result.cityName, 'Cairo');
        verify(() => mockRemoteSource.getCurrentWeather(testCity)).called(1);
        verify(() => mockCacheClient.put(cacheKey, any())).called(1);
      });

      test('skips cache and fetches from server when forceRefresh', () async {
        when(() => mockRemoteSource.getCurrentWeather(testCity))
            .thenAnswer((_) async => testModel);
        when(() => mockCacheClient.put(cacheKey, any()))
            .thenAnswer((_) async {});

        final result = await sut.getCurrentWeather(
          testCity,
          forceRefresh: true,
        );

        expect(result.cityName, 'Cairo');
        verifyNever(() => mockCacheClient.get(any()));
        verify(() => mockRemoteSource.getCurrentWeather(testCity)).called(1);
      });

      test('caches the response after successful server fetch', () async {
        when(() => mockCacheClient.get(cacheKey))
            .thenAnswer((_) async => null);
        when(() => mockRemoteSource.getCurrentWeather(testCity))
            .thenAnswer((_) async => testModel);
        when(() => mockCacheClient.put(cacheKey, any()))
            .thenAnswer((_) async {});

        await sut.getCurrentWeather(testCity);

        verify(() => mockCacheClient.put(cacheKey, any())).called(1);
      });

      test('falls back to stale cache when server fails', () async {
        when(() => mockCacheClient.get(cacheKey))
            .thenAnswer((_) async => null);
        when(() => mockRemoteSource.getCurrentWeather(testCity))
            .thenThrow(Exception('Network error'));
        when(() => mockCacheClient.getStale(cacheKey))
            .thenAnswer((_) async => cachedJson);

        final result = await sut.getCurrentWeather(testCity);

        expect(result.cityName, 'Cairo');
        verify(() => mockCacheClient.getStale(cacheKey)).called(1);
      });

      test('rethrows when server fails and no stale cache', () async {
        when(() => mockCacheClient.get(cacheKey))
            .thenAnswer((_) async => null);
        when(() => mockRemoteSource.getCurrentWeather(testCity))
            .thenThrow(Exception('Network error'));
        when(() => mockCacheClient.getStale(cacheKey))
            .thenAnswer((_) async => null);

        expect(
          () => sut.getCurrentWeather(testCity),
          throwsA(isA<Exception>()),
        );
      });

      test('normalizes city name for cache key (lowercase, trimmed)', () async {
        when(() => mockCacheClient.get('weather_current_cairo'))
            .thenAnswer((_) async => cachedJson);

        await sut.getCurrentWeather('  Cairo  ');

        verify(() => mockCacheClient.get('weather_current_cairo')).called(1);
      });

      test(
        'falls back to stale cache on forceRefresh when server fails',
        () async {
          when(() => mockRemoteSource.getCurrentWeather(testCity))
              .thenThrow(Exception('Offline'));
          when(() => mockCacheClient.getStale(cacheKey))
              .thenAnswer((_) async => cachedJson);

          final result = await sut.getCurrentWeather(
            testCity,
            forceRefresh: true,
          );

          expect(result.cityName, 'Cairo');
        },
      );
    });
  });
}
