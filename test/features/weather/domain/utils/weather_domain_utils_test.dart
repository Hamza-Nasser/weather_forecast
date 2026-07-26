import 'package:flutter_test/flutter_test.dart';
import 'package:weather_app/features/weather/domain/utils/weather_condition_kind.dart';
import 'package:weather_app/features/weather/domain/utils/weather_location_time.dart';
import 'package:weather_app/features/weather/domain/utils/weather_wind_scale.dart';

void main() {
  group('WeatherConditionClassifier', () {
    test('uses stable API codes instead of localized condition text', () {
      expect(
        WeatherConditionClassifier.fromCode(1000),
        WeatherConditionKind.clear,
      );
      expect(
        WeatherConditionClassifier.fromCode(1189),
        WeatherConditionKind.rain,
      );
      expect(
        WeatherConditionClassifier.fromCode(1276),
        WeatherConditionKind.storm,
      );
    });
  });

  group('WeatherWindScale', () {
    test('uses official Beaufort speed boundaries', () {
      expect(WeatherWindScale.beaufort(1), 0);
      expect(WeatherWindScale.beaufort(5), 1);
      expect(WeatherWindScale.beaufort(19), 3);
      expect(WeatherWindScale.beaufort(117), 11);
      expect(WeatherWindScale.beaufort(118), 12);
    });
  });

  group('WeatherLocationTime', () {
    test('calculates a location offset from wall time and epoch', () {
      final epoch =
          DateTime.utc(2026, 7, 26, 10).millisecondsSinceEpoch ~/ 1000;
      expect(
        WeatherLocationTime.offsetMinutes(
          localTime: '2026-07-26 13:00',
          epochSeconds: epoch,
        ),
        180,
      );
    });

    test('creates location now from a UTC instant', () {
      expect(
        WeatherLocationTime.nowAtLocation(
          180,
          utcNow: DateTime.utc(2026, 7, 26, 10),
        ),
        DateTime.utc(2026, 7, 26, 13),
      );
    });
  });
}
