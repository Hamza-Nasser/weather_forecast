import 'package:flutter/material.dart';
import 'package:weather_app/configurations/ui/theme/theme_data.dart';

/// A themed circular loading indicator.
///
/// Uses the app's primary color from the theme palette.
class CircularLoading extends StatelessWidget {
  /// Optional size for the indicator.
  final double? size;

  /// Optional stroke width.
  final double strokeWidth;

  /// Optional color override.
  final Color? color;

  const CircularLoading({
    super.key,
    this.size,
    this.strokeWidth = 3.0,
    this.color,
  });

  @override
  Widget build(BuildContext context) {
    final palette = Theme.of(context).colorPalette;

    final indicator = CircularProgressIndicator(
      strokeWidth: strokeWidth,
      color: color ?? palette.primary,
    );

    if (size != null) {
      return SizedBox(
        width: size,
        height: size,
        child: indicator,
      );
    }

    return indicator;
  }
}
