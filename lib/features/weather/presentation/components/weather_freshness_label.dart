import 'package:flutter/material.dart';
import 'package:weather_app/configurations/ui/dimensions/app_dimensions.dart';
import 'package:weather_app/configurations/ui/theme/theme_data.dart';
import 'package:weather_app/l10n/app_localizations.dart';
import 'package:weather_app/shared/ui/widgets/text.dart';

class WeatherFreshnessLabel extends StatelessWidget {
  const WeatherFreshnessLabel({
    super.key,
    required this.lastUpdated,
    required this.isFromCache,
    required this.isStale,
  });

  final DateTime lastUpdated;
  final bool isFromCache;
  final bool isStale;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final palette = Theme.of(context).colorPalette;
    final difference = DateTime.now().toUtc().difference(lastUpdated.toUtc());
    final relative = difference.inMinutes < 1
        ? l10n.justNow
        : difference.inHours < 1
        ? l10n.minutesAgo(difference.inMinutes)
        : l10n.hoursAgo(difference.inHours);
    final sourceLabel = isStale
        ? l10n.staleWeather
        : isFromCache
        ? l10n.cachedWeather
        : null;

    return Semantics(
      liveRegion: true,
      child: Column(
        children: [
          if (sourceLabel != null) ...[
            UiText.smallSemibold(
              sourceLabel,
              color: palette.white,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: AppSpacing.xs),
          ],
          UiText.captionRegular(
            l10n.lastUpdated(relative),
            color: palette.white.withValues(alpha: 0.75),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
