import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:weather_app/features/weather/presentation/components/weather_details_grid/grid_components/detail_card.dart';
import 'package:weather_app/features/weather/presentation/components/weather_details_grid/grid_components/feels_like_content.dart';
import 'package:weather_app/features/weather/presentation/components/weather_details_grid/grid_components/humidity_content.dart';
import 'package:weather_app/features/weather/presentation/components/weather_details_grid/grid_components/lifestyle_content.dart';
import 'package:weather_app/features/weather/presentation/components/weather_details_grid/grid_components/moon_phase_content.dart';
import 'package:weather_app/features/weather/presentation/components/weather_details_grid/grid_components/pressure_content.dart';
import 'package:weather_app/features/weather/presentation/components/weather_details_grid/grid_components/sunrise_sunset_content.dart';
import 'package:weather_app/features/weather/presentation/components/weather_details_grid/grid_components/uv_index_content.dart';
import 'package:weather_app/features/weather/presentation/components/weather_details_grid/grid_components/visibility_content.dart';
import 'package:weather_app/features/weather/presentation/components/weather_details_grid/grid_components/wind_content.dart';
import 'package:weather_app/features/weather/presentation/components/weather_details_grid/responsive_detail_pair.dart';
import 'package:weather_app/features/weather/presentation/components/weather_details_grid/weather_details_grid.dart';
import 'package:weather_app/shared/ui/widgets/text.dart';

import '../../../../widget_test_helper.dart';

class _ConstrainedTestApp extends StatelessWidget {
  const _ConstrainedTestApp({
    required this.child,
    this.height = 220,
    this.width = 360,
  });

  final Widget child;
  final double height;
  final double width;

  @override
  Widget build(BuildContext context) {
    return WidgetTestApp(
      child: Scaffold(
        body: SizedBox(width: width, height: height, child: child),
      ),
    );
  }
}

void main() {
  group('weather detail components', () {
    testWidgets('DetailCard renders its icon, title, and child', (
      tester,
    ) async {
      await tester.pumpWidget(
        _ConstrainedTestApp(
          child: const DetailCard(
            icon: Icons.water_drop,
            title: 'Humidity',
            child: UiText('Content'),
          ),
        ),
      );

      expect(find.text('HUMIDITY'), findsOneWidget);
      expect(find.text('Content'), findsOneWidget);
      expect(find.byIcon(Icons.water_drop), findsOneWidget);
    });

    testWidgets('UvIndexContent renders level and risk', (tester) async {
      await tester.pumpWidget(
        _ConstrainedTestApp(
          child: const UvIndexContent(uv: 7, riskText: 'Use sunscreen'),
        ),
      );

      expect(find.text('High'), findsOneWidget);
      expect(find.text('7'), findsOneWidget);
      expect(find.text('Use sunscreen'), findsOneWidget);
    });

    testWidgets('FeelsLikeContent renders comparison', (tester) async {
      await tester.pumpWidget(
        _ConstrainedTestApp(
          child: const FeelsLikeContent(feelsLike: 31, actualTemp: 28),
        ),
      );

      expect(find.text('31°'), findsOneWidget);
      expect(find.text('Feels warmer than actual temperature'), findsOneWidget);
    });

    testWidgets('HumidityContent renders humidity description', (tester) async {
      await tester.pumpWidget(
        _ConstrainedTestApp(child: const HumidityContent(humidity: 55)),
      );

      expect(find.text('55%'), findsOneWidget);
      expect(find.text('Comfortable, normal humidity levels'), findsOneWidget);
    });

    testWidgets('VisibilityContent renders distance and quality', (
      tester,
    ) async {
      await tester.pumpWidget(
        _ConstrainedTestApp(child: const VisibilityContent(visibility: 10)),
      );

      expect(find.text('10 km'), findsOneWidget);
      expect(find.text('Good visibility'), findsOneWidget);
    });

    testWidgets('PressureContent renders gauge and description', (
      tester,
    ) async {
      await tester.pumpWidget(
        _ConstrainedTestApp(child: const PressureContent(pressure: 1015)),
      );

      expect(find.text('1015 hPa'), findsOneWidget);
      expect(find.text('Stable atmospheric conditions'), findsOneWidget);
      expect(find.byType(CustomPaint), findsWidgets);
    });

    testWidgets('SunriseSunsetContent renders both times', (tester) async {
      await tester.pumpWidget(
        _ConstrainedTestApp(
          child: const SunriseSunsetContent(
            sunrise: '05:30 AM',
            sunset: '06:30 PM',
            progress: 0.5,
          ),
        ),
      );

      expect(find.text('05:30 AM'), findsOneWidget);
      expect(find.text('Sunset: 06:30 PM'), findsOneWidget);
    });

    testWidgets('WindContent renders measured direction and force', (
      tester,
    ) async {
      await tester.pumpWidget(
        _ConstrainedTestApp(
          child: const WindContent(
            speedKph: 12,
            bft: 3,
            direction: 'NW',
            angleDegrees: 315,
          ),
        ),
      );

      expect(find.text('NW wind'), findsOneWidget);
      expect(find.text('gentle breeze on the face'), findsOneWidget);
    });

    testWidgets('MoonPhaseContent renders phase and moonrise', (tester) async {
      await tester.pumpWidget(
        _ConstrainedTestApp(
          child: const MoonPhaseContent(
            phaseName: 'Full Moon',
            moonriseText: '08:00 PM',
            phaseProgress: 0.5,
          ),
        ),
      );

      expect(find.text('Full Moon'), findsOneWidget);
      expect(find.text('08:00 PM'), findsOneWidget);
    });

    testWidgets('LifestyleContent and LifestyleItem render activities', (
      tester,
    ) async {
      await tester.pumpWidget(
        _ConstrainedTestApp(
          height: 300,
          child: const Column(
            children: [
              LifestyleContent(
                runningText: 'Run',
                fishingText: 'Fish',
                hikingText: 'Hike',
              ),
              Row(
                children: [
                  LifestyleItem(icon: Icons.directions_run, label: 'Walk'),
                ],
              ),
            ],
          ),
        ),
      );

      expect(find.text('Run'), findsOneWidget);
      expect(find.text('Fish'), findsOneWidget);
      expect(find.text('Hike'), findsOneWidget);
      expect(find.text('Walk'), findsOneWidget);
    });

    testWidgets('ResponsiveDetailPair stacks on narrow widths', (tester) async {
      const firstKey = Key('first');
      const secondKey = Key('second');
      await tester.pumpWidget(
        _ConstrainedTestApp(
          width: 280,
          child: const ResponsiveDetailPair(
            first: SizedBox(key: firstKey, height: 40),
            second: SizedBox(key: secondKey, height: 40),
          ),
        ),
      );

      expect(
        tester.getTopLeft(find.byKey(secondKey)).dy,
        greaterThan(tester.getTopLeft(find.byKey(firstKey)).dy),
      );
    });

    testWidgets('ResponsiveDetailPair uses a row on wide widths', (
      tester,
    ) async {
      const firstKey = Key('wide-first');
      const secondKey = Key('wide-second');
      await tester.pumpWidget(
        WidgetTestApp(
          size: const Size(700, 500),
          child: const Scaffold(
            body: SizedBox(
              width: 600,
              child: ResponsiveDetailPair(
                first: SizedBox(key: firstKey, height: 40),
                second: SizedBox(key: secondKey, height: 40),
              ),
            ),
          ),
        ),
      );

      expect(
        tester.getTopLeft(find.byKey(secondKey)).dy,
        tester.getTopLeft(find.byKey(firstKey)).dy,
      );
    });

    testWidgets('WeatherDetailsGrid renders every metric card', (tester) async {
      await tester.pumpWidget(
        WidgetTestApp(
          size: const Size(900, 2400),
          child: Scaffold(
            body: SingleChildScrollView(
              child: WeatherDetailsGrid(
                temperatureCelsius: 28,
                conditionCode: 1000,
                windKph: 12,
                windDirection: 'N',
                windDegree: 0,
                humidity: 55,
                feelsLikeCelsius: 30,
                visibilityKm: 10,
                pressureMb: 1015,
                uvIndex: 4,
                sunrise: '05:30 AM',
                sunset: '06:30 PM',
                moonPhase: 'Full Moon',
                moonrise: '08:00 PM',
                locationNow: DateTime(2026, 7, 26, 12),
              ),
            ),
          ),
        ),
      );

      for (final title in [
        'UV INDEX',
        'FEELS LIKE',
        'WIND',
        'SUNRISE',
        'HUMIDITY',
        'VISIBILITY',
        'PRESSURE',
        'MOON PHASE',
        'LIFESTYLE',
      ]) {
        expect(find.text(title), findsOneWidget);
      }
    });
  });
}
