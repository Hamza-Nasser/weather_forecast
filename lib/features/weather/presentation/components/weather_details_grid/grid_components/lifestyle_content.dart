import 'package:flutter/material.dart';
import 'package:weather_app/configurations/ui/dimensions/app_dimensions.dart';
import 'package:weather_app/configurations/ui/theme/theme_data.dart';
import 'package:weather_app/shared/ui/widgets/text.dart';

class LifestyleContent extends StatelessWidget {
  final String runningText;
  final String fishingText;
  final String hikingText;

  const LifestyleContent({
    super.key,
    required this.runningText,
    required this.fishingText,
    required this.hikingText,
  });

  @override
  Widget build(BuildContext context) {
    final palette = Theme.of(context).colorPalette;

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: AppSpacing.s),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          LifestyleItem(icon: Icons.directions_run, label: runningText),
          Container(
            height: 32,
            width: 1,
            color: palette.white.withValues(alpha: 0.15),
          ),
          LifestyleItem(icon: Icons.waves, label: fishingText),
          Container(
            height: 32,
            width: 1,
            color: palette.white.withValues(alpha: 0.15),
          ),
          LifestyleItem(icon: Icons.directions_walk, label: hikingText),
        ],
      ),
    );
  }
}

class LifestyleItem extends StatelessWidget {
  final IconData icon;
  final String label;

  const LifestyleItem({super.key, required this.icon, required this.label});

  @override
  Widget build(BuildContext context) {
    final palette = Theme.of(context).colorPalette;

    return Expanded(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, color: palette.white, size: AppIconSize.l),
          const SizedBox(height: AppSpacing.s),
          UiText.captionRegular(
            label,
            color: palette.white.withValues(alpha: 0.7),
            textAlign: TextAlign.center,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }
}
