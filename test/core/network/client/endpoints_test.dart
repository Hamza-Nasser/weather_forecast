import 'package:flutter_test/flutter_test.dart';
import 'package:weather_app/core/network/client/endpoints.dart';

void main() {
  group('Endpoints', () {
    test('baseUrl points to weatherapi.com', () {
      expect(Endpoints.baseUrl, 'https://api.weatherapi.com/v1');
    });

    test('currentWeather endpoint is correct', () {
      expect(Endpoints.currentWeather, '/current.json');
    });

    test('forecast endpoint is correct', () {
      expect(Endpoints.forecast, '/forecast.json');
    });

    test('search endpoint is correct', () {
      expect(Endpoints.search, '/search.json');
    });
  });
}
