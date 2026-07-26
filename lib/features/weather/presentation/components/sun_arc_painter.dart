import 'package:flutter/material.dart';
import 'package:weather_app/features/weather/presentation/components/weather_colors.dart';

/// A custom painter that draws a sunrise-to-sunset curve
/// modeled as a quadratic Bézier curve.
class SunArcPainter extends CustomPainter {
  final double progress;
  final Color arcColor;
  final Color dashColor;

  const SunArcPainter({
    required this.progress,
    required this.arcColor,
    required this.dashColor,
  });

  @override
  void paint(Canvas canvas, Size size) {
    const inset = 8.0;

    final cy = size.height - inset;
    const arcHeight = 45.0;

    final rx = size.width / 2 - inset;
    final ry = arcHeight;
    final cx = size.width / 2;

    Offset getBezierPoint(double t) {
      final x =
          (1 - t) * (1 - t) * (cx - rx) +
          2 * (1 - t) * t * cx +
          t * t * (cx + rx);
      final y =
          (1 - t) * (1 - t) * cy + 2 * (1 - t) * t * (cy - 2 * ry) + t * t * cy;
      return Offset(x, y);
    }

    // 1. Solid thin baseline
    final baselinePaint = Paint()
      ..color = dashColor
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.0;
    canvas.drawLine(Offset(cx - rx, cy), Offset(cx + rx, cy), baselinePaint);

    // 2. Dashed background Bézier curve
    const totalSegments = 40;
    const dashFraction = 0.5;
    final dashPaint = Paint()
      ..color = dashColor
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.0;

    for (var i = 0; i < totalSegments; i++) {
      final tStart = i / totalSegments;
      final tEnd = (i + dashFraction) / totalSegments;
      canvas.drawLine(getBezierPoint(tStart), getBezierPoint(tEnd), dashPaint);
    }

    if (progress > 0) {
      final clampedProgress = progress.clamp(0.0, 1.0);
      final sunPos = getBezierPoint(clampedProgress);
      final sunX = sunPos.dx;

      // 3. Daylight fill
      final fillPath = Path()..moveTo(cx - rx, cy);
      final fillSteps = (clampedProgress * 40).round().clamp(4, 40);
      for (int i = 0; i <= fillSteps; i++) {
        final t = (clampedProgress * i) / fillSteps;
        final pt = getBezierPoint(t);
        fillPath.lineTo(pt.dx, pt.dy);
      }
      fillPath.lineTo(sunX, cy);
      fillPath.close();

      final fillPaint = Paint()
        ..shader = LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            WeatherColors.sunOrange.withValues(alpha: 0.15),
            WeatherColors.daylightCream.withValues(alpha: 0.05),
            Colors.transparent,
          ],
          stops: const [0.0, 0.65, 1.0],
        ).createShader(Rect.fromLTRB(inset, cy - ry, size.width - inset, cy))
        ..style = PaintingStyle.fill;

      canvas.drawPath(fillPath, fillPaint);

      // 4. Highlighted gradient progress path
      final progressPath = Path()..moveTo(cx - rx, cy);
      final progressSteps = (clampedProgress * 40).round().clamp(4, 40);
      for (int i = 0; i <= progressSteps; i++) {
        final t = (clampedProgress * i) / progressSteps;
        final pt = getBezierPoint(t);
        progressPath.lineTo(pt.dx, pt.dy);
      }

      final progressPaint = Paint()
        ..shader = LinearGradient(
          colors: [
            arcColor.withValues(alpha: 0.3),
            WeatherColors.sunOrange.withValues(alpha: 0.8),
            WeatherColors.sunGold,
          ],
        ).createShader(Rect.fromLTRB(cx - rx, cy - ry, cx + rx, cy))
        ..style = PaintingStyle.stroke
        ..strokeWidth = 2.5
        ..strokeCap = StrokeCap.round;

      canvas.drawPath(progressPath, progressPaint);

      // 5. Glowing Sun Dot
      canvas.drawCircle(
        sunPos,
        13.0,
        Paint()..color = WeatherColors.sunDotAmber.withValues(alpha: 0.15),
      );
      canvas.drawCircle(
        sunPos,
        8.0,
        Paint()..color = WeatherColors.sunDotOrange.withValues(alpha: 0.3),
      );
      canvas.drawCircle(
        sunPos,
        5.5,
        Paint()
          ..color = WeatherColors.sunDotYellow
          ..style = PaintingStyle.stroke
          ..strokeWidth = 1.5,
      );
      canvas.drawCircle(sunPos, 4.0, Paint()..color = arcColor);
    }
  }

  @override
  bool shouldRepaint(SunArcPainter oldDelegate) =>
      progress != oldDelegate.progress ||
      arcColor != oldDelegate.arcColor ||
      dashColor != oldDelegate.dashColor;
}
