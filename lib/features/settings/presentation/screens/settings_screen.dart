import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iconsax/iconsax.dart';
import 'package:weather_app/configurations/ui/dimensions/app_dimensions.dart';
import 'package:weather_app/configurations/ui/theme/theme_data.dart';
import 'package:weather_app/features/settings/presentation/bloc/settings_cubit.dart';
import 'package:weather_app/features/settings/presentation/bloc/settings_state.dart';
import 'package:weather_app/features/weather/presentation/components/weather_visuals.dart';
import 'package:weather_app/l10n/app_localizations.dart';
import 'package:weather_app/shared/ui/widgets/app_bar.dart';
import 'package:weather_app/shared/ui/widgets/glass_surface.dart';
import 'package:weather_app/shared/ui/widgets/text.dart';

/// Settings screen for the weather application.
///
/// Contains options to change application language with a glassmorphic design
/// matching the home screen's aesthetics.
class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final palette = Theme.of(context).colorPalette;
    final l10n = AppLocalizations.of(context)!;

    return BlocBuilder<SettingsCubit, SettingsState>(
      builder: (context, state) {
        final currentLocaleCode = Localizations.localeOf(context).languageCode;

        return Scaffold(
          extendBodyBehindAppBar: true,
          appBar: UiAppBar(
            transparent: true,
            glassRatio: 1.0,
            showBackButton: true,
            iconColor: palette.white,
            titleWidget: UiText.headlineBold(
              l10n.settings,
              color: palette.white,
            ),
          ),
          body: Container(
            height: double.infinity,
            decoration: const BoxDecoration(
              gradient: WeatherVisuals.defaultDarkGradient,
            ),
            child: SingleChildScrollView(
              padding: EdgeInsets.only(
                left: AppSpacing.l,
                right: AppSpacing.l,
                bottom: AppSpacing.l,
                top:
                    MediaQuery.paddingOf(context).top +
                    kToolbarHeight +
                    AppSpacing.l,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Section Header
                  Row(
                    children: [
                      Icon(
                        Iconsax.global,
                        color: palette.white.withValues(alpha: 0.8),
                        size: AppIconSize.m,
                      ),
                      const SizedBox(width: AppSpacing.s),
                      UiText.baseBold(l10n.language, color: palette.white),
                    ],
                  ),
                  const SizedBox(height: AppSpacing.m),

                  // Glass Card for Language Selection
                  GlassSurface(
                    blur: 20,
                    opacity: 0.12,
                    tintColor: palette.white,
                    borderOpacity: 0.15,
                    borderRadius: const BorderRadius.all(
                      Radius.circular(AppBorderRadius.l),
                    ),
                    padding: EdgeInsets.zero,
                    child: Material(
                      color: Colors.transparent,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          _LanguageOptionTile(
                            label: l10n.english,
                            nativeLabel: 'English',
                            isSelected: currentLocaleCode == 'en',
                            onTap: () {
                              context.read<SettingsCubit>().changeLanguage(
                                'en',
                              );
                            },
                            borderRadius: const BorderRadius.only(
                              topLeft: Radius.circular(AppBorderRadius.l),
                              topRight: Radius.circular(AppBorderRadius.l),
                            ),
                          ),
                          Divider(
                            color: palette.white.withValues(alpha: 0.1),
                            height: 1,
                            indent: AppSpacing.l,
                            endIndent: AppSpacing.l,
                          ),
                          _LanguageOptionTile(
                            label: l10n.arabic,
                            nativeLabel: 'العربية',
                            isSelected: currentLocaleCode == 'ar',
                            onTap: () {
                              context.read<SettingsCubit>().changeLanguage(
                                'ar',
                              );
                            },
                            borderRadius: const BorderRadius.only(
                              bottomLeft: Radius.circular(AppBorderRadius.l),
                              bottomRight: Radius.circular(AppBorderRadius.l),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

class _LanguageOptionTile extends StatelessWidget {
  final String label;
  final String nativeLabel;
  final bool isSelected;
  final VoidCallback onTap;
  final BorderRadius? borderRadius;

  const _LanguageOptionTile({
    required this.label,
    required this.nativeLabel,
    required this.isSelected,
    required this.onTap,
    this.borderRadius,
  });

  @override
  Widget build(BuildContext context) {
    final palette = Theme.of(context).colorPalette;

    return InkWell(
      onTap: onTap,
      borderRadius: borderRadius,
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: AppSpacing.l,
          vertical: AppSpacing.l,
        ),
        child: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  UiText.baseSemibold(nativeLabel, color: palette.white),
                  const SizedBox(height: AppSpacing.xs),
                  UiText.smallRegular(
                    label,
                    color: palette.white.withValues(alpha: 0.6),
                  ),
                ],
              ),
            ),
            if (isSelected)
              Icon(Icons.check_circle_rounded, color: palette.primary),
          ],
        ),
      ),
    );
  }
}
