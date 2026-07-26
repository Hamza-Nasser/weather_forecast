import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:weather_app/configurations/ui/dimensions/app_dimensions.dart';
import 'package:weather_app/configurations/ui/theme/theme_data.dart';
import 'package:weather_app/features/weather/presentation/components/weather_colors.dart';
import 'package:weather_app/shared/ui/widgets/text.dart';

class MoonPhaseContent extends StatelessWidget {
  final String phaseName;
  final String moonriseText;
  final double phaseProgress;

  const MoonPhaseContent({
    super.key,
    required this.phaseName,
    required this.moonriseText,
    required this.phaseProgress,
  });

  @override
  Widget build(BuildContext context) {
    final palette = Theme.of(context).colorPalette;

    return Row(
      children: [
        // Custom Paint Moon Illustration
        SizedBox(
          width: 60,
          height: 60,
          child: CustomPaint(
            painter: MoonPainter(
              progress: phaseProgress,
              moonColor: palette.white.withValues(alpha: 0.9),
              moonHighlightColor: WeatherColors.moonHighlight,
              moonMidToneColor: WeatherColors.moonMidTone,
              shadowColor: WeatherColors.moonShadow,
            ),
          ),
        ),
        const SizedBox(width: AppSpacing.s),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              UiText.captionBold(phaseName, color: palette.white),
              const SizedBox(height: 2),
              UiText.captionRegular(
                moonriseText,
                color: palette.white.withValues(alpha: 0.6),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class MoonPainter extends CustomPainter {
  final double progress;
  final Color moonColor;
  final Color moonHighlightColor;
  final Color moonMidToneColor;
  final Color shadowColor;

  const MoonPainter({
    required this.progress,
    required this.moonColor,
    required this.moonHighlightColor,
    required this.moonMidToneColor,
    required this.shadowColor,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = size.width / 2 - 4;

    // Draw full moon body with a rich radial gradient
    final moonPaint = Paint()
      ..shader = RadialGradient(
        center: const Alignment(-0.25, -0.25),
        radius: 0.8,
        colors: [moonColor, moonHighlightColor, moonMidToneColor],
        stops: const [0.0, 0.6, 1.0],
      ).createShader(Rect.fromCircle(center: center, radius: radius))
      ..style = PaintingStyle.fill;

    canvas.drawCircle(center, radius, moonPaint);

    // Draw 3 subtle craters
    final craterPaint = Paint()
      ..color = shadowColor.withValues(alpha: 0.08)
      ..style = PaintingStyle.fill;

    canvas.drawCircle(
      Offset(center.dx - radius * 0.3, center.dy - radius * 0.2),
      radius * 0.15,
      craterPaint,
    );
    canvas.drawCircle(
      Offset(center.dx + radius * 0.2, center.dy + radius * 0.3),
      radius * 0.12,
      craterPaint,
    );
    canvas.drawCircle(
      Offset(center.dx - radius * 0.1, center.dy + radius * 0.4),
      radius * 0.08,
      craterPaint,
    );

    // Draw shadow for the moon phase
    final shadowPaint = Paint()
      ..color = shadowColor.withValues(alpha: 0.85)
      ..style = PaintingStyle.fill;

    final shadowPath = Path();
    shadowPath.moveTo(center.dx, center.dy - radius);
    shadowPath.arcTo(
      Rect.fromCircle(center: center, radius: radius),
      -math.pi / 2,
      -math.pi,
      false,
    );
    shadowPath.quadraticBezierTo(
      center.dx - radius * 0.4,
      center.dy,
      center.dx,
      center.dy - radius,
    );
    shadowPath.close();
    canvas.drawPath(shadowPath, shadowPaint);
  }

  @override
  bool shouldRepaint(covariant MoonPainter oldDelegate) =>
      progress != oldDelegate.progress ||
      moonColor != oldDelegate.moonColor ||
      shadowColor != oldDelegate.shadowColor;
}
