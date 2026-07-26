import 'package:flutter/material.dart';
import 'package:weather_app/configurations/ui/dimensions/app_dimensions.dart';
import 'package:weather_app/configurations/ui/theme/theme_data.dart';
import 'package:weather_app/l10n/app_localizations.dart';
import 'package:weather_app/shared/ui/widgets/glass_surface.dart';
import 'package:weather_app/shared/ui/widgets/text.dart';

/// A glassmorphic welcome card shown when the app first loads (before any search).
class WeatherWelcomeCard extends StatelessWidget {
  const WeatherWelcomeCard({super.key});

  @override
  Widget build(BuildContext context) {
    final palette = Theme.of(context).colorPalette;
    final l10n = AppLocalizations.of(context)!;

    return GlassSurface(
      blur: 20,
      opacity: 0.1,
      tintColor: palette.white,
      borderOpacity: 0.15,
      borderRadius: const BorderRadius.all(Radius.circular(AppBorderRadius.l)),
      padding: const EdgeInsets.all(AppSpacing.xxl),
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(vertical: AppSpacing.xxxl),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.wb_sunny_outlined,
              size: AppIconSize.xxxl,
              color: palette.white.withValues(alpha: 0.4),
            ),
            const SizedBox(height: AppSpacing.l),
            UiText.largeSemibold(
              l10n.welcomeTitle,
              color: palette.white,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: AppSpacing.s),
            UiText.baseRegular(
              l10n.welcomeSubtitle,
              color: palette.white.withValues(alpha: 0.6),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
