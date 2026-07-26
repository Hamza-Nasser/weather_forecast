import 'package:flutter/material.dart';
import 'package:weather_app/configurations/ui/dimensions/app_dimensions.dart';
import 'package:weather_app/configurations/ui/theme/theme_data.dart';
import 'package:weather_app/l10n/app_localizations.dart';
import 'package:weather_app/shared/ui/widgets/text.dart';

class FeelsLikeContent extends StatelessWidget {
  final int feelsLike;
  final int actualTemp;

  const FeelsLikeContent({
    super.key,
    required this.feelsLike,
    required this.actualTemp,
  });

  @override
  Widget build(BuildContext context) {
    final palette = Theme.of(context).colorPalette;
    final l10n = AppLocalizations.of(context)!;
    final diff = feelsLike - actualTemp;

    String comparison;
    if (diff > 0) {
      comparison = l10n.feelsWarmer;
    } else if (diff < 0) {
      comparison = l10n.feelsCooler;
    } else {
      comparison = l10n.feelsSimilar;
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        UiText.headlineRegular(
          '$feelsLike°',
          color: palette.white,
          style: const TextStyle(fontSize: 38, height: 1.1),
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            UiText.captionRegular(
              l10n.actualTemperature(actualTemp),
              color: palette.white.withValues(alpha: 0.8),
            ),
            const SizedBox(height: AppSpacing.xs),
            UiText.captionRegular(
              comparison,
              color: palette.white.withValues(alpha: 0.6),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
      ],
    );
  }
}
