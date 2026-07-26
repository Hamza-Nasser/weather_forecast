import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:weather_app/core/network/client/endpoints.dart';
import 'package:weather_app/core/network/client/restful_client.dart';
import 'package:weather_app/features/weather/data/sources/weather_remote_source_impl.dart';

class MockRestfulClient extends Mock implements RestfulClient {}

void main() {
  late MockRestfulClient mockClient;
  late WeatherRemoteSourceImpl sut;

  setUp(() {
    mockClient = MockRestfulClient();
    sut = WeatherRemoteSourceImpl(mockClient);
  });

  group('WeatherRemoteSourceImpl', () {
    test('calls correct endpoint with query parameters', () async {
      when(
        () => mockClient.get(
          Endpoints.forecast,
          queryParameters: any(named: 'queryParameters'),
        ),
      ).thenAnswer((_) async => _validResponse());

      await sut.getCurrentWeather('Cairo');

      final captured = verify(
        () => mockClient.get(
          Endpoints.forecast,
          queryParameters: captureAny(named: 'queryParameters'),
        ),
      ).captured.single as Map;

      expect(captured['q'], 'Cairo');
      expect(captured['days'], 7);
      expect(captured.containsKey('key'), isTrue);
    });

    test('returns WeatherModel on valid Map response', () async {
      when(
        () => mockClient.get(
          Endpoints.forecast,
          queryParameters: any(named: 'queryParameters'),
        ),
      ).thenAnswer((_) async => _validResponse());

      final result = await sut.getCurrentWeather('Cairo');

      expect(result.location.name, 'Cairo');
      expect(result.current.tempC, 35.0);
      expect(result.current.condition.text, 'Sunny');
    });

    test('handles non-generic Map response', () async {
      // API might return Map<dynamic, dynamic> instead of Map<String, dynamic>
      when(
        () => mockClient.get(
          Endpoints.forecast,
          queryParameters: any(named: 'queryParameters'),
        ),
      ).thenAnswer((_) async => Map.from(_validResponse()));

      final result = await sut.getCurrentWeather('Cairo');

      expect(result.location.name, 'Cairo');
    });

    test('throws on invalid response format', () async {
      when(
        () => mockClient.get(
          Endpoints.forecast,
          queryParameters: any(named: 'queryParameters'),
        ),
      ).thenAnswer((_) async => 'invalid string response');

      expect(
        () => sut.getCurrentWeather('Cairo'),
        throwsA(isA<Exception>()),
      );
    });
  });
}

Map<String, dynamic> _validResponse() => {
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
        'forecastday': <Map<String, dynamic>>[],
      },
    };
