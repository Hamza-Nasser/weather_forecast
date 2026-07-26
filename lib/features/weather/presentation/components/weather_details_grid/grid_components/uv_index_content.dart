import 'package:flutter/material.dart';
import 'package:weather_app/configurations/ui/dimensions/app_dimensions.dart';
import 'package:weather_app/configurations/ui/theme/theme_data.dart';
import 'package:weather_app/l10n/app_localizations.dart';
import 'package:weather_app/shared/ui/widgets/text.dart';

class UvIndexContent extends StatelessWidget {
  final int uv;
  final String riskText;

  const UvIndexContent({super.key, required this.uv, required this.riskText});

  @override
  Widget build(BuildContext context) {
    final palette = Theme.of(context).colorPalette;
    final l10n = AppLocalizations.of(context)!;

    String label;
    if (uv <= 2) {
      label = l10n.low;
    } else if (uv <= 5) {
      label = l10n.moderate;
    } else {
      label = l10n.high;
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            UiText.titleBold(label, color: palette.white),
            UiText.headlineRegular(
              '$uv',
              color: palette.white,
              style: const TextStyle(fontSize: 32, height: 1.1),
            ),
          ],
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // UV Index Color Line — semantic gradient (green→red→purple)
            Container(
              height: 4,
              width: double.infinity,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(2),
                gradient: LinearGradient(
                  colors: [
                    palette.success,
                    palette.warning,
                    palette.pending,
                    palette.error,
                    palette.destructive,
                  ],
                ),
              ),
              child: Align(
                alignment: Alignment(-1.0 + (uv / 10.0) * 2.0, 0),
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
              riskText,
              color: palette.white.withValues(alpha: 0.8),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
      ],
    );
  }
}
