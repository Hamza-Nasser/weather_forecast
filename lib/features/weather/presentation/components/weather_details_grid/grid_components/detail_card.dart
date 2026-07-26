import 'package:flutter/material.dart';
import 'package:weather_app/configurations/ui/dimensions/app_dimensions.dart';
import 'package:weather_app/configurations/ui/theme/theme_data.dart';
import 'package:weather_app/shared/ui/widgets/glass_surface.dart';
import 'package:weather_app/shared/ui/widgets/text.dart';

/// Base container for each detail card.
class DetailCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final Widget child;
  final double? height;

  const DetailCard({
    super.key,
    required this.icon,
    required this.title,
    required this.child,
    this.height,
  });

  @override
  Widget build(BuildContext context) {
    final palette = Theme.of(context).colorPalette;

    return GlassSurface(
      blur: 20,
      opacity: 0.12,
      tintColor: palette.white,
      borderOpacity: 0.15,
      borderRadius: const BorderRadius.all(Radius.circular(AppBorderRadius.l)),
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.l,
        vertical: AppSpacing.m,
      ),
      height: height,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            children: [
              Icon(
                icon,
                color: palette.white.withValues(alpha: 0.5),
                size: AppIconSize.s,
              ),
              const SizedBox(width: AppSpacing.xs),
              UiText.captionBold(
                title.toUpperCase(),
                color: palette.white.withValues(alpha: 0.5),
              ),
            ],
          ),
          const SizedBox(height: AppSpacing.s),
          height != null ? Expanded(child: child) : child,
        ],
      ),
    );
  }
}
