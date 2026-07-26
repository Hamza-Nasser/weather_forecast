import 'package:flutter/material.dart';
import 'package:weather_app/configurations/ui/dimensions/app_dimensions.dart';
import 'package:weather_app/configurations/ui/theme/theme_data.dart';
import 'package:weather_app/features/weather/presentation/components/sun_arc_painter.dart';
import 'package:weather_app/features/weather/presentation/components/weather_stat_item.dart';
import 'package:weather_app/l10n/app_localizations.dart';
import 'package:weather_app/shared/ui/widgets/text.dart';

/// The "Details" section of the weather card.
///
/// Shows:
/// - A sunrise/sunset arc with time labels
/// - A row of weather stats (RealFeel, Humidity, Wind, Pressure)
class WeatherDetailsSection extends StatelessWidget {
  final String sunrise;
  final String sunset;
  final double sunProgress;
  final String feelsLike;
  final String humidity;
  final String windForce;
  final String pressure;

  const WeatherDetailsSection({
    super.key,
    required this.sunrise,
    required this.sunset,
    required this.sunProgress,
    required this.feelsLike,
    required this.humidity,
    required this.windForce,
    required this.pressure,
  });

  @override
  Widget build(BuildContext context) {
    final palette = Theme.of(context).colorPalette;
    final l10n = AppLocalizations.of(context)!;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // "Details" label
        UiText.smallSemibold(l10n.details, color: palette.white),
        const SizedBox(height: AppSpacing.l),

        // Sunrise/sunset arc
        SizedBox(
          height: 60,
          child: Stack(
            children: [
              // Arc
              Positioned(
                left: 48,
                right: 48,
                top: 0,
                bottom: 0,
                child: CustomPaint(
                  painter: SunArcPainter(
                    progress: sunProgress,
                    arcColor: palette.white.withValues(alpha: 0.8),
                    dashColor: palette.white.withValues(alpha: 0.2),
                  ),
                ),
              ),
              // Sunrise icon + time
              Positioned(
                left: 0,
                bottom: 0,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      Icons.wb_sunny_outlined,
                      color: palette.dark04,
                      size: AppIconSize.m,
                    ),
                    const SizedBox(height: 2),
                    UiText.captionRegular(sunrise, color: palette.dark04),
                  ],
                ),
              ),
              // Sunset icon + time
              Positioned(
                right: 0,
                bottom: 0,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      Icons.wb_twilight_outlined,
                      color: palette.dark04,
                      size: AppIconSize.m,
                    ),
                    const SizedBox(height: 2),
                    UiText.captionRegular(sunset, color: palette.dark04),
                  ],
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: AppSpacing.xl),

        // Stats row
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: FittedBox(
                fit: BoxFit.scaleDown,
                child: WeatherStatItem(value: feelsLike, label: l10n.realFeel),
              ),
            ),
            Expanded(
              child: FittedBox(
                fit: BoxFit.scaleDown,
                child: WeatherStatItem(value: humidity, label: l10n.humidityLabel),
              ),
            ),
            Expanded(
              child: FittedBox(
                fit: BoxFit.scaleDown,
                child: WeatherStatItem(value: windForce, label: l10n.windForce),
              ),
            ),
            Expanded(
              child: FittedBox(
                fit: BoxFit.scaleDown,
                child: WeatherStatItem(value: pressure, label: l10n.pressure),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
