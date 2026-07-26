import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:weather_app/core/network/error/server_exceptions.dart';
import 'package:weather_app/features/weather/domain/entities/weather_entity.dart';
import 'package:weather_app/features/weather/domain/usecases/get_current_weather_usecase.dart';
import 'package:weather_app/features/weather/presentation/bloc/weather_bloc.dart';
import 'package:weather_app/features/weather/presentation/bloc/weather_event.dart';
import 'package:weather_app/features/weather/presentation/bloc/weather_state.dart';

class MockGetCurrentWeatherUseCase extends Mock
    implements GetCurrentWeatherUseCase {}

void main() {
  late MockGetCurrentWeatherUseCase mockUseCase;

  const testEntity = WeatherEntity(
    cityName: 'Cairo',
    temperatureCelsius: 35.0,
    condition: 'Sunny',
    humidity: 20,
    windKph: 15.0,
    iconUrl: 'https://icon.png',
    region: 'Cairo Governorate',
    country: 'Egypt',
    feelsLikeCelsius: 38.0,
    visibilityKm: 10.0,
    pressureMb: 1013.0,
    uvIndex: 8.0,
    sunrise: '05:30 AM',
    sunset: '07:15 PM',
    moonPhase: 'Waxing Crescent',
    moonrise: '10:30 PM',
  );

  setUp(() {
    mockUseCase = MockGetCurrentWeatherUseCase();
  });

  group('WeatherBloc', () {
    test('initial state is correct', () {
      final bloc = WeatherBloc(mockUseCase);
      expect(bloc.state.status, WeatherStatus.initial);
      expect(bloc.state.searchQuery, '');
      expect(bloc.state.cityName, '');
      expect(bloc.state.lastUpdated, isNull);
      expect(bloc.state.isFromCache, isFalse);
      bloc.close();
    });

    group('WeatherFetchRequested', () {
      blocTest<WeatherBloc, WeatherState>(
        'emits [loading, success] when fetch succeeds',
        setUp: () {
          when(() => mockUseCase('Cairo', forceRefresh: false))
              .thenAnswer((_) async => testEntity);
        },
        build: () => WeatherBloc(mockUseCase),
        act: (bloc) => bloc.add(const WeatherFetchRequested('Cairo')),
        expect: () => [
          isA<WeatherState>()
              .having((s) => s.status, 'status', WeatherStatus.loading),
          isA<WeatherState>()
              .having((s) => s.status, 'status', WeatherStatus.success)
              .having((s) => s.cityName, 'cityName', 'Cairo')
              .having((s) => s.temperatureCelsius, 'temp', 35.0)
              .having((s) => s.condition, 'condition', 'Sunny')
              .having((s) => s.humidity, 'humidity', 20)
              .having((s) => s.windKph, 'wind', 15.0)
              .having((s) => s.searchQuery, 'searchQuery', 'Cairo')
              .having((s) => s.lastUpdated, 'lastUpdated', isNotNull),
        ],
        verify: (_) {
          verify(() => mockUseCase('Cairo', forceRefresh: false)).called(1);
        },
      );

      blocTest<WeatherBloc, WeatherState>(
        'emits [loading, failure] when UserFriendlyException is thrown',
        setUp: () {
          when(() => mockUseCase('Invalid', forceRefresh: false))
              .thenThrow(const ServerException('City not found'));
        },
        build: () => WeatherBloc(mockUseCase),
        act: (bloc) => bloc.add(const WeatherFetchRequested('Invalid')),
        expect: () => [
          isA<WeatherState>()
              .having((s) => s.status, 'status', WeatherStatus.loading),
          isA<WeatherState>()
              .having((s) => s.status, 'status', WeatherStatus.failure)
              .having((s) => s.errorMessage, 'errorMessage', 'City not found')
              .having((s) => s.error, 'error', isA<ServerException>()),
        ],
      );

      blocTest<WeatherBloc, WeatherState>(
        'emits [loading, failure] with null error on generic exception',
        setUp: () {
          when(() => mockUseCase('Crash', forceRefresh: false))
              .thenThrow(Exception('Unexpected'));
        },
        build: () => WeatherBloc(mockUseCase),
        act: (bloc) => bloc.add(const WeatherFetchRequested('Crash')),
        expect: () => [
          isA<WeatherState>()
              .having((s) => s.status, 'status', WeatherStatus.loading),
          isA<WeatherState>()
              .having((s) => s.status, 'status', WeatherStatus.failure)
              .having((s) => s.error, 'error', isNull)
              .having((s) => s.errorMessage, 'errorMessage', isNull),
        ],
      );

      blocTest<WeatherBloc, WeatherState>(
        'passes forceRefresh: true to use case',
        setUp: () {
          when(() => mockUseCase('Cairo', forceRefresh: true))
              .thenAnswer((_) async => testEntity);
        },
        build: () => WeatherBloc(mockUseCase),
        act: (bloc) => bloc.add(
          const WeatherFetchRequested('Cairo', forceRefresh: true),
        ),
        expect: () => [
          isA<WeatherState>()
              .having((s) => s.status, 'status', WeatherStatus.loading),
          isA<WeatherState>()
              .having((s) => s.status, 'status', WeatherStatus.success)
              .having((s) => s.cityName, 'cityName', 'Cairo'),
        ],
        verify: (_) {
          verify(() => mockUseCase('Cairo', forceRefresh: true)).called(1);
        },
      );

      blocTest<WeatherBloc, WeatherState>(
        'maps all weather entity fields to state',
        setUp: () {
          when(() => mockUseCase('Cairo', forceRefresh: false))
              .thenAnswer((_) async => testEntity);
        },
        build: () => WeatherBloc(mockUseCase),
        act: (bloc) => bloc.add(const WeatherFetchRequested('Cairo')),
        expect: () => [
          isA<WeatherState>(),
          isA<WeatherState>()
              .having((s) => s.region, 'region', 'Cairo Governorate')
              .having((s) => s.country, 'country', 'Egypt')
              .having((s) => s.feelsLikeCelsius, 'feelsLike', 38.0)
              .having((s) => s.visibilityKm, 'visibility', 10.0)
              .having((s) => s.pressureMb, 'pressure', 1013.0)
              .having((s) => s.uvIndex, 'uv', 8.0)
              .having((s) => s.sunrise, 'sunrise', '05:30 AM')
              .having((s) => s.sunset, 'sunset', '07:15 PM')
              .having((s) => s.moonPhase, 'moonPhase', 'Waxing Crescent')
              .having((s) => s.moonrise, 'moonrise', '10:30 PM')
              .having((s) => s.iconUrl, 'iconUrl', 'https://icon.png'),
        ],
      );
    });

    group('WeatherRefreshRequested', () {
      blocTest<WeatherBloc, WeatherState>(
        'dispatches fetch with forceRefresh when searchQuery is set',
        setUp: () {
          when(() => mockUseCase('Cairo', forceRefresh: false))
              .thenAnswer((_) async => testEntity);
          when(() => mockUseCase('Cairo', forceRefresh: true))
              .thenAnswer((_) async => testEntity);
        },
        build: () => WeatherBloc(mockUseCase),
        act: (bloc) async {
          bloc.add(const WeatherFetchRequested('Cairo'));
          await Future.delayed(const Duration(milliseconds: 100));
          bloc.add(const WeatherRefreshRequested());
        },
        wait: const Duration(milliseconds: 300),
        expect: () => [
          // Initial fetch: loading -> success
          isA<WeatherState>()
              .having((s) => s.status, 'status', WeatherStatus.loading),
          isA<WeatherState>()
              .having((s) => s.status, 'status', WeatherStatus.success),
          // Refresh: loading -> success
          isA<WeatherState>()
              .having((s) => s.status, 'status', WeatherStatus.loading),
          isA<WeatherState>()
              .having((s) => s.status, 'status', WeatherStatus.success),
        ],
        verify: (_) {
          verify(() => mockUseCase('Cairo', forceRefresh: true)).called(1);
        },
      );

      blocTest<WeatherBloc, WeatherState>(
        'does nothing when searchQuery is empty',
        build: () => WeatherBloc(mockUseCase),
        act: (bloc) => bloc.add(const WeatherRefreshRequested()),
        expect: () => <WeatherState>[],
      );
    });
  });

  group('WeatherState', () {
    test('copyWith preserves values when no arguments provided', () {
      const state = WeatherState(
        status: WeatherStatus.success,
        cityName: 'Cairo',
        temperatureCelsius: 35.0,
      );
      final copied = state.copyWith();

      expect(copied.status, WeatherStatus.success);
      expect(copied.cityName, 'Cairo');
      expect(copied.temperatureCelsius, 35.0);
    });

    test('copyWith overrides provided fields', () {
      const state = WeatherState(cityName: 'Cairo');
      final copied = state.copyWith(
        cityName: 'London',
        status: WeatherStatus.loading,
      );

      expect(copied.cityName, 'London');
      expect(copied.status, WeatherStatus.loading);
    });

    test('supports lastUpdated and isFromCache', () {
      final now = DateTime(2026, 7, 25, 12, 0);
      final state = WeatherState(
        lastUpdated: now,
        isFromCache: true,
      );

      expect(state.lastUpdated, now);
      expect(state.isFromCache, isTrue);
    });
  });

  group('WeatherEvent', () {
    test('WeatherFetchRequested supports value equality', () {
      const event1 = WeatherFetchRequested('Cairo');
      const event2 = WeatherFetchRequested('Cairo');
      const event3 = WeatherFetchRequested('London');

      expect(event1, equals(event2));
      expect(event1, isNot(equals(event3)));
    });

    test('WeatherFetchRequested with different forceRefresh are not equal',
        () {
      const event1 = WeatherFetchRequested('Cairo');
      const event2 = WeatherFetchRequested('Cairo', forceRefresh: true);

      expect(event1, isNot(equals(event2)));
    });

    test('WeatherRefreshRequested supports value equality', () {
      const event1 = WeatherRefreshRequested();
      const event2 = WeatherRefreshRequested();

      expect(event1, equals(event2));
    });
  });
}
