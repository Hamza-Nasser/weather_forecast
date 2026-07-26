import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:weather_app/configurations/ui/dimensions/app_dimensions.dart';
import 'package:weather_app/configurations/ui/theme/theme_data.dart';
import 'package:weather_app/features/weather/presentation/components/weather_colors.dart';
import 'package:weather_app/l10n/app_localizations.dart';
import 'package:weather_app/shared/ui/widgets/glass_surface.dart';
import 'package:weather_app/shared/ui/widgets/text.dart';

/// A glassmorphic card presenting weather-related life insights and recommendations.
class WeatherInsightsSection extends StatelessWidget {
  final double temperatureCelsius;
  final String condition;
  final double windKph;
  final int humidity;

  const WeatherInsightsSection({
    super.key,
    required this.temperatureCelsius,
    required this.condition,
    required this.windKph,
    required this.humidity,
  });

  String _getUvIndexValue(AppLocalizations l10n) {
    final cond = condition.toLowerCase();
    if (cond.contains('sunny') || cond.contains('clear')) {
      return l10n.uvHighValue;
    } else if (cond.contains('cloud') || cond.contains('overcast')) {
      return l10n.uvModerateValue;
    }
    return l10n.uvLowValue;
  }

  String _getUvIndexSubtitle(AppLocalizations l10n) {
    final cond = condition.toLowerCase();
    if (cond.contains('sunny') || cond.contains('clear')) {
      return l10n.uvHighRisk;
    }
    return l10n.uvSafe;
  }

  String _getAirQualityValue(AppLocalizations l10n) {
    if (windKph > 15) {
      return l10n.airExcellentValue;
    } else if (humidity > 80) {
      return l10n.airModerateValue;
    }
    return l10n.airGoodValue;
  }

  String _getAirQualitySubtitle(AppLocalizations l10n) {
    if (humidity > 80) {
      return l10n.airModerate;
    }
    return l10n.airExcellent;
  }

  String _getClothingValue(AppLocalizations l10n) {
    if (temperatureCelsius < 15) {
      return l10n.clothingHeavy;
    } else if (temperatureCelsius < 22) {
      return l10n.clothingJacket;
    }
    return l10n.clothingLight;
  }

  String _getClothingSubtitle(AppLocalizations l10n) {
    if (temperatureCelsius < 15) {
      return l10n.clothingHeavyAdvice;
    } else if (temperatureCelsius < 22) {
      return l10n.clothingJacketAdvice;
    }
    return l10n.clothingLightAdvice;
  }

  String _getSportValue(AppLocalizations l10n) {
    final cond = condition.toLowerCase();
    if (cond.contains('rain') || cond.contains('storm') || cond.contains('drizzle')) {
      return l10n.sportNotRecommended;
    } else if (temperatureCelsius > 35) {
      return l10n.sportIndoor;
    }
    return l10n.sportExcellent;
  }

  String _getSportSubtitle(AppLocalizations l10n) {
    final cond = condition.toLowerCase();
    if (cond.contains('rain') || cond.contains('storm') || cond.contains('drizzle')) {
      return l10n.sportNotRecommendedAdvice;
    } else if (temperatureCelsius > 35) {
      return l10n.sportIndoorAdvice;
    }
    return l10n.sportExcellentAdvice;
  }

  @override
  Widget build(BuildContext context) {
    final palette = Theme.of(context).colorPalette;
    final l10n = AppLocalizations.of(context)!;

    return GlassSurface(
      blur: 20,
      opacity: 0.12,
      tintColor: palette.white,
      borderOpacity: 0.15,
      borderRadius: const BorderRadius.all(Radius.circular(AppBorderRadius.l)),
      padding: const EdgeInsets.all(AppSpacing.xl),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                Iconsax.info_circle,
                color: palette.white.withValues(alpha: 0.8),
                size: AppIconSize.m,
              ),
              const SizedBox(width: AppSpacing.s),
              UiText.baseBold(l10n.weatherInsights, color: palette.white),
            ],
          ),
          const SizedBox(height: AppSpacing.xl),

          // Row 1: UV Index & Air Quality
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: _InsightCell(
                  icon: Iconsax.sun_1,
                  iconColor: WeatherColors.uvAmber,
                  title: l10n.uvIndexLabel,
                  value: _getUvIndexValue(l10n),
                  subtitle: _getUvIndexSubtitle(l10n),
                ),
              ),
              const SizedBox(width: AppSpacing.l),
              Expanded(
                child: _InsightCell(
                  icon: Iconsax.wind_2,
                  iconColor: WeatherColors.airQualityGreen,
                  title: l10n.airQuality,
                  value: _getAirQualityValue(l10n),
                  subtitle: _getAirQualitySubtitle(l10n),
                ),
              ),
            ],
          ),

          Divider(
            color: palette.white.withValues(alpha: 0.1),
            height: AppSpacing.xxl,
          ),

          // Row 2: Clothing & Activity Sport
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: _InsightCell(
                  icon: Iconsax.tag_user,
                  iconColor: WeatherColors.clothingBlue,
                  title: l10n.clothing,
                  value: _getClothingValue(l10n),
                  subtitle: _getClothingSubtitle(l10n),
                ),
              ),
              const SizedBox(width: AppSpacing.l),
              Expanded(
                child: _InsightCell(
                  icon: Iconsax.activity,
                  iconColor: WeatherColors.sportPink,
                  title: l10n.outdoorSport,
                  value: _getSportValue(l10n),
                  subtitle: _getSportSubtitle(l10n),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _InsightCell extends StatelessWidget {
  final IconData icon;
  final Color iconColor;
  final String title;
  final String value;
  final String subtitle;

  const _InsightCell({
    required this.icon,
    required this.iconColor,
    required this.title,
    required this.value,
    required this.subtitle,
  });

  @override
  Widget build(BuildContext context) {
    final palette = Theme.of(context).colorPalette;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(icon, color: iconColor, size: AppIconSize.m),
            const SizedBox(width: AppSpacing.s),
            Expanded(
              child: UiText.smallMedium(
                title,
                color: palette.white.withValues(alpha: 0.6),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
        const SizedBox(height: AppSpacing.s),
        UiText.baseBold(value, color: palette.white),
        const SizedBox(height: AppSpacing.xs),
        UiText.smallRegular(
          subtitle,
          color: palette.white.withValues(alpha: 0.6),
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
        ),
      ],
    );
  }
}
