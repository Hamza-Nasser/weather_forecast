import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:weather_app/features/weather/domain/entities/weather_entity.dart';
import 'package:weather_app/features/weather/domain/repositories/weather_repository.dart';
import 'package:weather_app/features/weather/domain/usecases/get_current_weather_usecase.dart';

class MockWeatherRepository extends Mock implements WeatherRepository {}

void main() {
  late MockWeatherRepository mockRepository;
  late GetCurrentWeatherUseCase sut;

  const testEntity = WeatherEntity(
    cityName: 'Cairo',
    temperatureCelsius: 35.0,
    condition: 'Sunny',
    humidity: 20,
    windKph: 15.0,
  );

  setUp(() {
    mockRepository = MockWeatherRepository();
    sut = GetCurrentWeatherUseCase(mockRepository);
  });

  group('GetCurrentWeatherUseCase', () {
    test('delegates to repository with default forceRefresh', () async {
      when(() => mockRepository.getCurrentWeather('Cairo'))
          .thenAnswer((_) async => testEntity);

      final result = await sut('Cairo');

      expect(result, testEntity);
      verify(() => mockRepository.getCurrentWeather('Cairo')).called(1);
    });

    test('passes forceRefresh to repository', () async {
      when(
        () => mockRepository.getCurrentWeather(
          'Cairo',
          forceRefresh: true,
        ),
      ).thenAnswer((_) async => testEntity);

      final result = await sut('Cairo', forceRefresh: true);

      expect(result, testEntity);
      verify(
        () => mockRepository.getCurrentWeather(
          'Cairo',
          forceRefresh: true,
        ),
      ).called(1);
    });

    test('rethrows repository exceptions', () async {
      when(() => mockRepository.getCurrentWeather('Invalid'))
          .thenThrow(Exception('City not found'));

      expect(
        () => sut('Invalid'),
        throwsA(isA<Exception>()),
      );
    });
  });
}
