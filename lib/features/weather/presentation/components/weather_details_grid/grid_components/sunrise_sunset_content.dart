import 'package:flutter/material.dart';
import 'package:weather_app/configurations/ui/theme/theme_data.dart';
import 'package:weather_app/features/weather/presentation/components/sun_arc_painter.dart';
import 'package:weather_app/l10n/app_localizations.dart';
import 'package:weather_app/shared/ui/widgets/text.dart';

class SunriseSunsetContent extends StatelessWidget {
  final String sunrise;
  final String sunset;
  final double progress;

  const SunriseSunsetContent({
    super.key,
    required this.sunrise,
    required this.sunset,
    required this.progress,
  });

  @override
  Widget build(BuildContext context) {
    final palette = Theme.of(context).colorPalette;
    final l10n = AppLocalizations.of(context)!;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        UiText.headlineRegular(
          sunrise,
          color: palette.white,
          style: const TextStyle(fontSize: 28, height: 1.1),
        ),
        // Mini sun arc
        SizedBox(
          height: 38,
          child: CustomPaint(
            painter: SunArcPainter(
              progress: progress,
              arcColor: palette.white.withValues(alpha: 0.8),
              dashColor: palette.white.withValues(alpha: 0.2),
            ),
          ),
        ),
        UiText.captionRegular(
          l10n.sunsetTime(sunset),
          color: palette.white.withValues(alpha: 0.8),
        ),
      ],
    );
  }
}
