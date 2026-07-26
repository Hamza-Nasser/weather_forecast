import 'package:flutter/material.dart';
import 'package:weather_app/configurations/ui/dimensions/app_dimensions.dart';
import 'package:weather_app/configurations/ui/theme/theme_data.dart';
import 'package:weather_app/shared/ui/widgets/text.dart';

/// A single weather stat (e.g. RealFeel, Humidity, Pressure).
class WeatherStatItem extends StatelessWidget {
  final String value;
  final String label;

  const WeatherStatItem({super.key, required this.value, required this.label});

  @override
  Widget build(BuildContext context) {
    final palette = Theme.of(context).colorPalette;

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        UiText.baseSemibold(value, color: palette.white),
        const SizedBox(height: AppSpacing.xs),
        UiText.captionRegular(label, color: palette.white),
      ],
    );
  }
}
