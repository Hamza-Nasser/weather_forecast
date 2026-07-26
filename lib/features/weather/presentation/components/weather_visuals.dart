import 'package:flutter/material.dart';
import 'package:weather_app/features/weather/presentation/components/weather_colors.dart';
import 'package:weather_app/features/weather/presentation/components/weather_home_card.dart';

/// Utility providing weather-condition-dependent visual properties.
///
/// Keeps gradient, blob, and icon-mapping logic out of the screen widget.
class WeatherVisuals {
  const WeatherVisuals._();

  /// Returns the background gradient for the given weather [condition].
  static LinearGradient backgroundGradient(String condition) {
    final cond = condition.toLowerCase();

    if (cond.contains('sunny') || cond.contains('clear')) {
      return const LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: [
          WeatherColors.slateDark,
          WeatherColors.deepBlue,
          WeatherColors.sunsetRust,
          WeatherColors.slateDark,
        ],
        stops: [0.0, 0.4, 0.75, 1.0],
      );
    }

    if (cond.contains('rain') ||
        cond.contains('drizzle') ||
        cond.contains('shower') ||
        cond.contains('storm') ||
        cond.contains('thunder')) {
      return const LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: [
          WeatherColors.stormBlack,
          WeatherColors.deepIndigo,
          WeatherColors.midnightBlue,
          WeatherColors.slateDark,
        ],
        stops: [0.0, 0.35, 0.7, 1.0],
      );
    }

    if (cond.contains('cloud') ||
        cond.contains('overcast') ||
        cond.contains('mist') ||
        cond.contains('fog') ||
        cond.contains('haze')) {
      return const LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: [
          WeatherColors.slateDark,
          WeatherColors.slateGrey,
          WeatherColors.blueSlateMid,
          WeatherColors.slateDark,
        ],
      );
    }

    return const LinearGradient(
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
      colors: [
        WeatherColors.slateDark,
        WeatherColors.blueSlateMid,
        WeatherColors.slateDark,
      ],
    );
  }

  /// Returns decorative blob colors for the given weather [condition].
  static List<Color> blobColors(String condition) {
    final cond = condition.toLowerCase();

    if (cond.contains('sunny') || cond.contains('clear')) {
      return [
        WeatherColors.sunnyBlobPink.withValues(alpha: 0.35),
        WeatherColors.sunnyBlobGold.withValues(alpha: 0.25),
      ];
    }

    if (cond.contains('rain') ||
        cond.contains('drizzle') ||
        cond.contains('shower') ||
        cond.contains('storm')) {
      return [
        WeatherColors.rainBlobBlue.withValues(alpha: 0.3),
        WeatherColors.rainBlobIndigo.withValues(alpha: 0.25),
      ];
    }

    if (cond.contains('cloud') || cond.contains('overcast')) {
      return [
        WeatherColors.cloudBlobGrey.withValues(alpha: 0.25),
        WeatherColors.cloudBlobWhite.withValues(alpha: 0.15),
      ];
    }

    return [
      WeatherColors.sunnyBlobPink.withValues(alpha: 0.35),
      WeatherColors.sunnyBlobGold.withValues(alpha: 0.25),
    ];
  }

  /// Maps a weather [condition] string to an icon and color for hourly display.
  static ({IconData icon, Color color}) conditionIcon(
    String condition, {
    bool isDay = true,
  }) {
    final cond = condition.toLowerCase();

    if (cond.contains('sunny') || cond.contains('clear')) {
      if (!isDay) {
        return (icon: Icons.nightlight_round, color: WeatherColors.nightMoon);
      }
      return (icon: Icons.wb_sunny, color: WeatherColors.sunnyGold);
    }

    if (cond.contains('rain') ||
        cond.contains('drizzle') ||
        cond.contains('shower')) {
      return (icon: Icons.umbrella, color: WeatherColors.rainBlue);
    }

    if (cond.contains('cloud') || cond.contains('overcast')) {
      return (icon: Icons.cloud, color: WeatherColors.cloudGrey);
    }

    return (icon: Icons.wb_cloudy, color: WeatherColors.sunnyGold);
  }

  /// Generates placeholder hourly forecast from base temperature and condition.
  static List<HourlyForecastData> generateForecast(
    double baseTemp,
    String condition,
  ) {
    final List<HourlyForecastData> list = [];
    final currentHour = DateTime.now().hour;

    final result = conditionIcon(condition);

    for (int i = 1; i <= 5; i++) {
      final hour = (currentHour + i) % 24;
      final timeStr = '${hour.toString().padLeft(2, '0')}:00';
      final tempDiff = -0.6 * i;
      final tempStr = '${(baseTemp + tempDiff).round()}°C';

      var itemIcon = result.icon;
      var itemColor = result.color;
      if (result.icon == Icons.wb_sunny && (hour >= 18 || hour < 6)) {
        itemIcon = Icons.nightlight_round;
        itemColor = WeatherColors.nightMoon;
      }

      list.add(
        HourlyForecastData(
          time: timeStr,
          icon: itemIcon,
          iconColor: itemColor,
          temperature: tempStr,
        ),
      );
    }
    return list;
  }

  /// The default background gradient used by screens without weather data
  /// (e.g. settings screen).
  static const LinearGradient defaultDarkGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [
      WeatherColors.slateDark,
      WeatherColors.blueSlateMid,
      WeatherColors.slateDark,
    ],
  );
}
