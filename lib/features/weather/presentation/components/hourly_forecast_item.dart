import 'package:flutter/material.dart';
import 'package:weather_app/configurations/ui/dimensions/app_dimensions.dart';
import 'package:weather_app/configurations/ui/theme/theme_data.dart';
import 'package:weather_app/shared/ui/widgets/text.dart';

/// A single hourly forecast item showing time, icon, and temperature.
class HourlyForecastItem extends StatelessWidget {
  final String time;
  final IconData icon;
  final Color iconColor;
  final String temperature;

  const HourlyForecastItem({
    super.key,
    required this.time,
    required this.icon,
    required this.iconColor,
    required this.temperature,
  });

  @override
  Widget build(BuildContext context) {
    final palette = Theme.of(context).colorPalette;

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        UiText.smallRegular(time, color: palette.white),
        const SizedBox(height: AppSpacing.s),
        Icon(icon, color: iconColor, size: AppIconSize.l),
        const SizedBox(height: AppSpacing.s),
        UiText.smallSemibold(temperature, color: palette.white),
      ],
    );
  }
}
