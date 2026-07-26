import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:weather_app/configurations/ui/dimensions/app_dimensions.dart';
import 'package:weather_app/configurations/ui/theme/theme_data.dart';
import 'package:weather_app/l10n/app_localizations.dart';
import 'package:weather_app/shared/ui/widgets/text.dart';

class WindContent extends StatelessWidget {
  final double speedKph;
  final int bft;
  final String direction;
  final double angleDegrees;

  const WindContent({
    super.key,
    required this.speedKph,
    required this.bft,
    required this.direction,
    required this.angleDegrees,
  });

  @override
  Widget build(BuildContext context) {
    final palette = Theme.of(context).colorPalette;
    final l10n = AppLocalizations.of(context)!;

    String forceDescription;
    if (speedKph > 28) {
      forceDescription = l10n.windStrongBreeze;
    } else if (speedKph > 19) {
      forceDescription = l10n.windModerateBreeze;
    } else if (speedKph < 8) {
      forceDescription = l10n.windLightAir;
    } else {
      forceDescription = l10n.windGentleBreeze;
    }

    return Row(
      children: [
        // Compass CustomPaint
        SizedBox(
          width: 74,
          height: 74,
          child: CustomPaint(
            painter: CompassPainter(
              angleDegrees: angleDegrees,
              bft: bft,
              accentColor: palette.white,
              dialColor: palette.white.withValues(alpha: 0.15),
            ),
          ),
        ),
        const SizedBox(width: AppSpacing.s),
        // Wind descriptions
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              UiText.captionBold(
                l10n.windDirection(direction),
                color: palette.white,
              ),
              UiText.captionRegular(
                forceDescription,
                color: palette.white.withValues(alpha: 0.6),
                maxLines: 3,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class CompassPainter extends CustomPainter {
  final double angleDegrees;
  final int bft;
  final Color accentColor;
  final Color dialColor;

  const CompassPainter({
    required this.angleDegrees,
    required this.bft,
    required this.accentColor,
    required this.dialColor,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = size.width / 2;

    // Draw dial background circle
    final dialPaint = Paint()
      ..color = dialColor
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.0;
    canvas.drawCircle(center, radius - 2, dialPaint);

    // Draw ticks around the dial
    final tickPaint = Paint()
      ..color = accentColor.withValues(alpha: 0.3)
      ..strokeWidth = 1.0;

    for (int i = 0; i < 36; i++) {
      final angle = i * 10 * math.pi / 180;
      final startRadius = radius - (i % 9 == 0 ? 6 : 4);
      final p1 = Offset(
        center.dx + startRadius * math.cos(angle),
        center.dy + startRadius * math.sin(angle),
      );
      final p2 = Offset(
        center.dx + (radius - 2) * math.cos(angle),
        center.dy + (radius - 2) * math.sin(angle),
      );
      canvas.drawLine(p1, p2, tickPaint);
    }

    // Draw cardinal direction letters
    final textPainter = TextPainter(textDirection: TextDirection.ltr);

    void drawLetter(String text, Offset pos) {
      textPainter.text = TextSpan(
        text: text,
        style: TextStyle(
          color: accentColor.withValues(alpha: 0.7),
          fontSize: 7.5,
          fontWeight: FontWeight.bold,
        ),
      );
      textPainter.layout();
      textPainter.paint(
        canvas,
        Offset(pos.dx - textPainter.width / 2, pos.dy - textPainter.height / 2),
      );
    }

    drawLetter('N', Offset(center.dx, center.dy - radius + 10));
    drawLetter('S', Offset(center.dx, center.dy + radius - 10));
    drawLetter('E', Offset(center.dx + radius - 10, center.dy));
    drawLetter('W', Offset(center.dx - radius + 10, center.dy));

    // Draw center speed text (e.g. "2 Bft")
    final centerPaint = Paint()
      ..color = accentColor.withValues(alpha: 0.1)
      ..style = PaintingStyle.fill;
    canvas.drawCircle(center, 15, centerPaint);

    textPainter.text = TextSpan(
      text: '$bft\nBft',
      style: TextStyle(
        color: accentColor,
        fontSize: 8,
        fontWeight: FontWeight.bold,
        height: 1.1,
      ),
    );
    textPainter.layout();
    textPainter.paint(
      canvas,
      Offset(
        center.dx - textPainter.width / 2,
        center.dy - textPainter.height / 2,
      ),
    );

    // Draw wind direction arrow
    final angleRad =
        (angleDegrees - 90) * math.pi / 180; // offset so 0° is North
    final arrowPaint = Paint()
      ..color = accentColor
      ..style = PaintingStyle.fill;

    // Draw arrowhead pointing to the wind direction
    final arrowLength = radius - 8;
    final tip = Offset(
      center.dx + arrowLength * math.cos(angleRad),
      center.dy + arrowLength * math.sin(angleRad),
    );

    // Draw arrow base on the opposite side
    final baseCenter = Offset(
      center.dx - (radius - 12) * math.cos(angleRad),
      center.dy - (radius - 12) * math.sin(angleRad),
    );

    // Arrow shaft line
    canvas.drawLine(
      baseCenter,
      tip,
      Paint()
        ..color = accentColor.withValues(alpha: 0.8)
        ..strokeWidth = 2.0
        ..strokeCap = StrokeCap.round,
    );

    // Arrowhead shape
    final path = Path();
    final arrowWidthAngle = 160.0 * math.pi / 180;
    final tipSize = 6.0;

    final pLeft = Offset(
      tip.dx + tipSize * math.cos(angleRad + arrowWidthAngle),
      tip.dy + tipSize * math.sin(angleRad + arrowWidthAngle),
    );
    final pRight = Offset(
      tip.dx + tipSize * math.cos(angleRad - arrowWidthAngle),
      tip.dy + tipSize * math.sin(angleRad - arrowWidthAngle),
    );

    path.moveTo(tip.dx, tip.dy);
    path.lineTo(pLeft.dx, pLeft.dy);
    path.lineTo(pRight.dx, pRight.dy);
    path.close();
    canvas.drawPath(path, arrowPaint);

    // Draw small dot at the base
    canvas.drawCircle(baseCenter, 2.5, Paint()..color = accentColor);
  }

  @override
  bool shouldRepaint(covariant CompassPainter oldDelegate) =>
      angleDegrees != oldDelegate.angleDegrees ||
      bft != oldDelegate.bft ||
      accentColor != oldDelegate.accentColor ||
      dialColor != oldDelegate.dialColor;
}
