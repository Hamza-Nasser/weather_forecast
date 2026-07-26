import 'package:flutter/material.dart';
import 'package:weather_app/configurations/ui/dimensions/app_dimensions.dart';
import 'package:weather_app/configurations/ui/theme/theme_data.dart';
import 'package:weather_app/l10n/app_localizations.dart';
import 'package:weather_app/shared/ui/widgets/text.dart';

class VisibilityContent extends StatelessWidget {
  final double visibility;

  const VisibilityContent({
    super.key,
    required this.visibility,
  });

  @override
  Widget build(BuildContext context) {
    final palette = Theme.of(context).colorPalette;
    final l10n = AppLocalizations.of(context)!;

    String description;
    if (visibility >= 15) {
      description = l10n.excellentVisibility;
    } else if (visibility >= 8) {
      description = l10n.goodVisibility;
    } else {
      description = l10n.moderateVisibility;
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        UiText.headlineRegular(
          '${visibility.round()} km',
          color: palette.white,
          style: const TextStyle(fontSize: 34, height: 1.1),
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                UiText.captionRegular(
                  l10n.low,
                  color: palette.white.withValues(alpha: 0.4),
                ),
                UiText.captionRegular(
                  l10n.high,
                  color: palette.white.withValues(alpha: 0.4),
                ),
              ],
            ),
            const SizedBox(height: 2),
            // Custom Visibility Slider Bar
            Container(
              height: 4,
              width: double.infinity,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(2),
                color: palette.white.withValues(alpha: 0.15),
              ),
              child: Align(
                alignment: Alignment(-1.0 + (visibility / 20.0) * 2.0, 0),
                child: Container(
                  width: 6,
                  height: 6,
                  decoration: BoxDecoration(
                    color: palette.white,
                    shape: BoxShape.circle,
                  ),
                ),
              ),
            ),
            const SizedBox(height: AppSpacing.s),
            UiText.captionRegular(
              description,
              color: palette.white.withValues(alpha: 0.8),
            ),
          ],
        ),
      ],
    );
  }
}
