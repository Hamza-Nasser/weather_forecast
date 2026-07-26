import 'package:flutter/material.dart';
import 'package:weather_app/features/weather/domain/utils/weather_condition_kind.dart';
import 'package:weather_app/features/weather/presentation/components/weather_colors.dart';

class WeatherVisuals {
  const WeatherVisuals._();

  static LinearGradient backgroundGradient(int conditionCode) {
    return switch (WeatherConditionClassifier.fromCode(conditionCode)) {
      WeatherConditionKind.clear => const LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: [
          WeatherColors.slateDark,
          WeatherColors.deepBlue,
          WeatherColors.sunsetRust,
          WeatherColors.slateDark,
        ],
        stops: [0, 0.4, 0.75, 1],
      ),
      WeatherConditionKind.rain ||
      WeatherConditionKind.snow ||
      WeatherConditionKind.storm => const LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: [
          WeatherColors.stormBlack,
          WeatherColors.deepIndigo,
          WeatherColors.midnightBlue,
          WeatherColors.slateDark,
        ],
        stops: [0, 0.35, 0.7, 1],
      ),
      WeatherConditionKind.cloudy ||
      WeatherConditionKind.fog => const LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: [
          WeatherColors.slateDark,
          WeatherColors.slateGrey,
          WeatherColors.blueSlateMid,
          WeatherColors.slateDark,
        ],
      ),
      WeatherConditionKind.unknown => defaultDarkGradient,
    };
  }

  static List<Color> blobColors(int conditionCode) {
    return switch (WeatherConditionClassifier.fromCode(conditionCode)) {
      WeatherConditionKind.clear => [
        WeatherColors.sunnyBlobPink.withValues(alpha: 0.35),
        WeatherColors.sunnyBlobGold.withValues(alpha: 0.25),
      ],
      WeatherConditionKind.rain ||
      WeatherConditionKind.snow ||
      WeatherConditionKind.storm => [
        WeatherColors.rainBlobBlue.withValues(alpha: 0.3),
        WeatherColors.rainBlobIndigo.withValues(alpha: 0.25),
      ],
      WeatherConditionKind.cloudy ||
      WeatherConditionKind.fog ||
      WeatherConditionKind.unknown => [
        WeatherColors.cloudBlobGrey.withValues(alpha: 0.25),
        WeatherColors.cloudBlobWhite.withValues(alpha: 0.15),
      ],
    };
  }

  static ({IconData icon, Color color}) conditionIcon(
    int conditionCode, {
    bool isDay = true,
  }) {
    return switch (WeatherConditionClassifier.fromCode(conditionCode)) {
      WeatherConditionKind.clear when !isDay => (
        icon: Icons.nightlight_round,
        color: WeatherColors.nightMoon,
      ),
      WeatherConditionKind.clear => (
        icon: Icons.wb_sunny,
        color: WeatherColors.sunnyGold,
      ),
      WeatherConditionKind.rain => (
        icon: Icons.umbrella,
        color: WeatherColors.rainBlue,
      ),
      WeatherConditionKind.snow => (
        icon: Icons.ac_unit,
        color: WeatherColors.cloudGrey,
      ),
      WeatherConditionKind.storm => (
        icon: Icons.thunderstorm,
        color: WeatherColors.rainBlue,
      ),
      WeatherConditionKind.cloudy || WeatherConditionKind.fog => (
        icon: Icons.cloud,
        color: WeatherColors.cloudGrey,
      ),
      WeatherConditionKind.unknown => (
        icon: Icons.wb_cloudy,
        color: WeatherColors.cloudGrey,
      ),
    };
  }

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
