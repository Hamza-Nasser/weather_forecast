import 'dart:ui' show Tristate;

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:weather_app/features/weather/domain/entities/weather_entity.dart';
import 'package:weather_app/features/weather/presentation/bloc/weather_state.dart';
import 'package:weather_app/features/weather/presentation/components/hourly_forecast_item.dart';
import 'package:weather_app/features/weather/presentation/components/quick_city_chips.dart';
import 'package:weather_app/features/weather/presentation/components/responsive_weather_layout.dart';
import 'package:weather_app/features/weather/presentation/components/weather_details_section.dart';
import 'package:weather_app/features/weather/presentation/components/weather_freshness_label.dart';
import 'package:weather_app/features/weather/presentation/components/weather_home_card.dart';
import 'package:weather_app/features/weather/presentation/components/weather_loading_card.dart';
import 'package:weather_app/features/weather/presentation/components/weather_stat_item.dart';
import 'package:weather_app/features/weather/presentation/components/weather_state_content.dart';
import 'package:weather_app/features/weather/presentation/components/weather_welcome_card.dart';
import 'package:weather_app/features/weather/presentation/components/weekly_forecast_section.dart';
import 'package:weather_app/shared/ui/widgets/error_state.dart';

import '../../../../widget_test_helper.dart';

void main() {
  group('weather components', () {
    testWidgets('QuickCityChips renders semantics and reports selection', (
      tester,
    ) async {
      String? selected;
      await tester.pumpWidget(
        WidgetTestApp(
          child: Scaffold(
            body: QuickCityChips(
              cities: const [
                QuickCity(query: 'Cairo', displayName: 'Cairo'),
                QuickCity(query: 'Doha', displayName: 'Doha'),
              ],
              selectedCity: 'Cairo',
              onSelected: (city) => selected = city,
            ),
          ),
        ),
      );

      final semantics = tester.getSemantics(find.text('Cairo'));
      expect(semantics.flagsCollection.isButton, isTrue);
      expect(semantics.flagsCollection.isSelected, Tristate.isTrue);
      await tester.tap(find.text('Doha'));
      expect(selected, 'Doha');
    });

    testWidgets('WeatherWelcomeCard renders localized copy', (tester) async {
      await tester.pumpWidget(
        WidgetTestApp(child: const Scaffold(body: WeatherWelcomeCard())),
      );

      expect(find.text('Welcome to Homa Weather'), findsOneWidget);
      expect(find.byIcon(Icons.wb_sunny_outlined), findsOneWidget);
    });

    testWidgets('HourlyForecastItem renders time, icon, and temperature', (
      tester,
    ) async {
      await tester.pumpWidget(
        WidgetTestApp(
          child: const Scaffold(
            body: HourlyForecastItem(
              time: '14:00',
              icon: Icons.wb_sunny,
              iconColor: Colors.amber,
              temperature: '28°C',
            ),
          ),
        ),
      );

      expect(find.text('14:00'), findsOneWidget);
      expect(find.text('28°C'), findsOneWidget);
      expect(find.byIcon(Icons.wb_sunny), findsOneWidget);
    });

    testWidgets('WeatherStatItem renders value and label', (tester) async {
      await tester.pumpWidget(
        WidgetTestApp(
          child: const Scaffold(
            body: WeatherStatItem(value: '55%', label: 'Humidity'),
          ),
        ),
      );

      expect(find.text('55%'), findsOneWidget);
      expect(find.text('Humidity'), findsOneWidget);
    });

    testWidgets('WeatherDetailsSection renders sun times and all stats', (
      tester,
    ) async {
      await tester.pumpWidget(
        WidgetTestApp(
          child: const Scaffold(
            body: WeatherDetailsSection(
              sunrise: '05:30 AM',
              sunset: '06:30 PM',
              sunProgress: 0.5,
              feelsLike: '30°C',
              humidity: '55%',
              windForce: '12 km/h',
              pressure: '1015 hPa',
            ),
          ),
        ),
      );

      for (final value in [
        '05:30 AM',
        '06:30 PM',
        '30°C',
        '55%',
        '12 km/h',
        '1015 hPa',
      ]) {
        expect(find.text(value), findsOneWidget);
      }
    });

    testWidgets('WeatherHomeCard renders actual hourly forecast data', (
      tester,
    ) async {
      await tester.pumpWidget(
        WidgetTestApp(
          child: const Scaffold(
            body: SingleChildScrollView(
              child: WeatherHomeCard(
                cityName: 'Cairo',
                region: 'Cairo',
                country: 'Egypt',
                temperature: '28',
                condition: 'Sunny',
                feelsLike: '30°C',
                humidity: '55%',
                windForce: '12 km/h',
                pressure: '1015 hPa',
                sunrise: '05:30 AM',
                sunset: '06:30 PM',
                sunProgress: 0.5,
                hourlyForecast: [
                  HourlyForecastData(
                    time: '14:00',
                    icon: Icons.wb_sunny,
                    iconColor: Colors.amber,
                    temperature: '28°C',
                  ),
                ],
              ),
            ),
          ),
        ),
      );

      expect(find.text('Cairo'), findsWidgets);
      expect(find.text('Sunny'), findsOneWidget);
      expect(find.text('14:00'), findsOneWidget);
    });

    testWidgets('WeeklyForecastSection renders count and rows', (tester) async {
      await tester.pumpWidget(
        WidgetTestApp(
          child: const Scaffold(
            body: WeeklyForecastSection(
              forecastList: [
                WeeklyForecastData(
                  dayName: 'Today',
                  condition: 'Sunny',
                  icon: Icons.wb_sunny,
                  tempMax: '30°',
                  tempMin: '20°',
                ),
              ],
            ),
          ),
        ),
      );

      expect(find.text('1-Day Forecast'), findsOneWidget);
      expect(find.text('Today'), findsOneWidget);
      expect(find.text('Sunny'), findsOneWidget);
    });

    testWidgets('WeatherFreshnessLabel exposes cached and stale sources', (
      tester,
    ) async {
      await tester.pumpWidget(
        WidgetTestApp(
          child: Scaffold(
            body: Column(
              children: [
                WeatherFreshnessLabel(
                  lastUpdated: DateTime.now().toUtc(),
                  isFromCache: true,
                  isStale: false,
                ),
                WeatherFreshnessLabel(
                  lastUpdated: DateTime.now().toUtc().subtract(
                    const Duration(hours: 2),
                  ),
                  isFromCache: true,
                  isStale: true,
                ),
              ],
            ),
          ),
        ),
      );

      expect(find.text('Showing saved weather'), findsOneWidget);
      expect(
        find.text('Offline — showing older saved weather'),
        findsOneWidget,
      );
      expect(find.textContaining('Last updated'), findsNWidgets(2));
    });

    testWidgets('ResponsiveWeatherLayout stacks on mobile', (tester) async {
      const heroKey = Key('mobile-hero');
      const secondaryKey = Key('mobile-secondary');
      await tester.pumpWidget(
        WidgetTestApp(
          size: const Size(390, 800),
          child: const Scaffold(
            body: SizedBox(
              width: 390,
              child: ResponsiveWeatherLayout(
                heroCard: SizedBox(key: heroKey, height: 40),
                secondaryContent: SizedBox(key: secondaryKey, height: 40),
              ),
            ),
          ),
        ),
      );

      expect(
        tester.getTopLeft(find.byKey(secondaryKey)).dy,
        greaterThan(tester.getTopLeft(find.byKey(heroKey)).dy),
      );
    });

    testWidgets('ResponsiveWeatherLayout splits into columns on tablet', (
      tester,
    ) async {
      const heroKey = Key('tablet-hero');
      const secondaryKey = Key('tablet-secondary');
      await tester.pumpWidget(
        WidgetTestApp(
          size: const Size(1024, 1000),
          child: const Scaffold(
            body: ResponsiveWeatherLayout(
              heroCard: SizedBox(key: heroKey, height: 40),
              secondaryContent: SizedBox(key: secondaryKey, height: 40),
            ),
          ),
        ),
      );

      expect(
        tester.getTopLeft(find.byKey(secondaryKey)).dy,
        tester.getTopLeft(find.byKey(heroKey)).dy,
      );
      expect(
        tester.getTopLeft(find.byKey(secondaryKey)).dx,
        greaterThan(tester.getTopLeft(find.byKey(heroKey)).dx),
      );
    });

    testWidgets('WeatherLoadingCard renders its skeleton composition', (
      tester,
    ) async {
      await tester.pumpWidget(
        WidgetTestApp(
          size: const Size(900, 2400),
          child: const Scaffold(
            body: SingleChildScrollView(child: WeatherLoadingCard()),
          ),
        ),
      );

      expect(find.byType(WeatherLoadingCard), findsOneWidget);
      expect(find.byType(WeatherHomeCard), findsOneWidget);
      expect(find.byType(WeeklyForecastSection), findsOneWidget);
    });
  });

  group('WeatherStateContent', () {
    const blobs = [Colors.blue, Colors.purple];

    testWidgets('renders welcome for initial state', (tester) async {
      await tester.pumpWidget(
        WidgetTestApp(
          child: const Scaffold(
            body: WeatherStateContent(
              state: WeatherState(),
              blobColors: blobs,
              onRetry: _noop,
            ),
          ),
        ),
      );

      expect(find.byType(WeatherWelcomeCard), findsOneWidget);
    });

    testWidgets('renders loading card while fetching', (tester) async {
      await tester.pumpWidget(
        WidgetTestApp(
          size: const Size(900, 2400),
          child: const Scaffold(
            body: SingleChildScrollView(
              child: WeatherStateContent(
                state: WeatherState(status: WeatherStatus.loading),
                blobColors: blobs,
                onRetry: _noop,
              ),
            ),
          ),
        ),
      );

      expect(find.byType(WeatherLoadingCard), findsOneWidget);
    });

    testWidgets('renders error state and retries', (tester) async {
      var retried = false;
      await tester.pumpWidget(
        WidgetTestApp(
          child: Scaffold(
            body: WeatherStateContent(
              state: const WeatherState(
                status: WeatherStatus.failure,
                errorMessage: 'Could not load',
              ),
              blobColors: blobs,
              onRetry: () => retried = true,
            ),
          ),
        ),
      );

      expect(find.byType(ErrorState), findsOneWidget);
      await tester.tap(find.text('Retry'));
      expect(retried, isTrue);
    });

    testWidgets('renders success content with API forecast values', (
      tester,
    ) async {
      final nowEpoch =
          DateTime.now()
              .toUtc()
              .add(const Duration(hours: 1))
              .millisecondsSinceEpoch ~/
          1000;
      final state = WeatherState(
        status: WeatherStatus.success,
        searchQuery: 'Cairo',
        cityName: 'Cairo',
        country: 'Egypt',
        temperatureCelsius: 28,
        condition: 'Sunny',
        conditionCode: 1000,
        humidity: 55,
        windKph: 12,
        windDirection: 'N',
        feelsLikeCelsius: 30,
        visibilityKm: 10,
        pressureMb: 1015,
        uvIndex: 4,
        sunrise: '05:30 AM',
        sunset: '06:30 PM',
        moonPhase: 'Full Moon',
        moonrise: '08:00 PM',
        lastUpdated: DateTime.now().toUtc(),
        hourlyForecast: [
          WeatherHourEntity(
            time: '2026-07-26 14:00',
            timeEpoch: nowEpoch,
            tempC: 28,
            condition: 'Sunny',
            conditionCode: 1000,
            iconUrl: '',
            isDay: true,
          ),
        ],
        dailyForecast: const [
          WeatherDailyForecastEntity(
            date: '2026-07-26',
            maxTempC: 30,
            minTempC: 20,
            condition: 'Sunny',
            conditionCode: 1000,
            iconUrl: '',
          ),
        ],
      );

      await tester.pumpWidget(
        WidgetTestApp(
          size: const Size(1000, 3000),
          child: Scaffold(
            body: SingleChildScrollView(
              child: WeatherStateContent(
                state: state,
                blobColors: blobs,
                onRetry: _noop,
              ),
            ),
          ),
        ),
      );

      expect(find.byType(WeatherHomeCard), findsOneWidget);
      expect(find.byType(WeeklyForecastSection), findsOneWidget);
      expect(find.text('14:00'), findsOneWidget);
    });
  });
}

void _noop() {}
