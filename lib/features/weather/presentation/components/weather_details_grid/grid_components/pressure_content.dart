import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:weather_app/configurations/ui/dimensions/app_dimensions.dart';
import 'package:weather_app/configurations/ui/theme/theme_data.dart';
import 'package:weather_app/l10n/app_localizations.dart';
import 'package:weather_app/shared/ui/widgets/text.dart';

class PressureContent extends StatelessWidget {
  final int pressure;

  const PressureContent({
    super.key,
    required this.pressure,
  });

  @override
  Widget build(BuildContext context) {
    final palette = Theme.of(context).colorPalette;
    final l10n = AppLocalizations.of(context)!;

    String description;
    if (pressure < 1000) {
      description = l10n.pressureStuffy;
    } else if (pressure > 1013) {
      description = l10n.pressureStable;
    } else {
      description = l10n.pressureNormal;
    }

    return Row(
      children: [
        // Pressure Gauge CustomPaint
        SizedBox(
          width: 74,
          height: 74,
          child: CustomPaint(
            painter: PressureGaugePainter(
              pressure: pressure,
              accentColor: palette.white,
              gaugeColor: palette.white.withValues(alpha: 0.15),
            ),
          ),
        ),
        const SizedBox(width: AppSpacing.s),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              UiText.captionBold('$pressure hPa', color: palette.white),
              const SizedBox(height: AppSpacing.xs),
              UiText.captionRegular(
                description,
                color: palette.white.withValues(alpha: 0.6),
                maxLines: 4,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class PressureGaugePainter extends CustomPainter {
  final int pressure;
  final Color accentColor;
  final Color gaugeColor;

  const PressureGaugePainter({
    required this.pressure,
    required this.accentColor,
    required this.gaugeColor,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2 + 5);
    final radius = size.width / 2 - 4;

    const startAngle = 140 * math.pi / 180;
    const sweepAngle = 260 * math.pi / 180;

    final gaugePaint = Paint()
      ..color = gaugeColor
      ..style = PaintingStyle.stroke
      ..strokeWidth = 3.0
      ..strokeCap = StrokeCap.round;

    canvas.drawArc(
      Rect.fromCircle(center: center, radius: radius),
      startAngle,
      sweepAngle,
      false,
      gaugePaint,
    );

    final clampedPressure = pressure.clamp(960, 1040);
    final progress = (clampedPressure - 960) / (1040 - 960);

    final activePaint = Paint()
      ..color = accentColor
      ..style = PaintingStyle.stroke
      ..strokeWidth = 3.0
      ..strokeCap = StrokeCap.round;

    canvas.drawArc(
      Rect.fromCircle(center: center, radius: radius),
      startAngle,
      sweepAngle * progress,
      false,
      activePaint,
    );

    final tickPaint = Paint()
      ..color = accentColor.withValues(alpha: 0.3)
      ..strokeWidth = 1.0;

    const totalTicks = 11;
    for (int i = 0; i < totalTicks; i++) {
      final angle = startAngle + (sweepAngle * (i / (totalTicks - 1)));
      final p1 = Offset(
        center.dx + (radius - 8) * math.cos(angle),
        center.dy + (radius - 8) * math.sin(angle),
      );
      final p2 = Offset(
        center.dx + (radius - 4) * math.cos(angle),
        center.dy + (radius - 4) * math.sin(angle),
      );
      canvas.drawLine(p1, p2, tickPaint);
    }

    final activeAngle = startAngle + sweepAngle * progress;
    final needleTip = Offset(
      center.dx + (radius - 3) * math.cos(activeAngle),
      center.dy + (radius - 3) * math.sin(activeAngle),
    );
    canvas.drawCircle(needleTip, 2.5, Paint()..color = accentColor);
  }

  @override
  bool shouldRepaint(covariant PressureGaugePainter oldDelegate) =>
      pressure != oldDelegate.pressure ||
      accentColor != oldDelegate.accentColor ||
      gaugeColor != oldDelegate.gaugeColor;
}
