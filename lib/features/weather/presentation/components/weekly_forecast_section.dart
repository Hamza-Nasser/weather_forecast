import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:weather_app/configurations/ui/dimensions/app_dimensions.dart';
import 'package:weather_app/configurations/ui/theme/theme_data.dart';
import 'package:weather_app/l10n/app_localizations.dart';
import 'package:weather_app/shared/ui/widgets/glass_surface.dart';
import 'package:weather_app/shared/ui/widgets/text.dart';

/// Data model for weekly forecast.
class WeeklyForecastData {
  final String dayName;
  final String condition;
  final IconData icon;
  final String tempMax;
  final String tempMin;

  const WeeklyForecastData({
    required this.dayName,
    required this.condition,
    required this.icon,
    required this.tempMax,
    required this.tempMin,
  });
}

/// A glassmorphic 5-day weekly forecast section.
class WeeklyForecastSection extends StatelessWidget {
  final List<WeeklyForecastData> forecastList;

  const WeeklyForecastSection({
    super.key,
    required this.forecastList,
  });

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
                Iconsax.calendar_1,
                color: palette.white.withValues(alpha: 0.8),
                size: AppIconSize.m,
              ),
              const SizedBox(width: AppSpacing.s),
              UiText.baseBold(
                l10n.nDayForecast(forecastList.length),
                color: palette.white,
              ),
            ],
          ),
          const SizedBox(height: AppSpacing.l),
          ListView.separated(
            padding: EdgeInsets.zero,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: forecastList.length,
            separatorBuilder: (context, index) => Divider(
              color: palette.white.withValues(alpha: 0.1),
              height: AppSpacing.xl,
            ),
            itemBuilder: (context, index) {
              final day = forecastList[index];
              return Row(
                children: [
                  // Day Name
                  Expanded(
                    flex: 3,
                    child: UiText.baseMedium(day.dayName, color: palette.white),
                  ),
                  // Icon + Condition
                  Expanded(
                    flex: 4,
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          day.icon,
                          color: palette.white,
                          size: AppIconSize.l,
                        ),
                        const SizedBox(width: AppSpacing.s),
                        Expanded(
                          child: UiText.smallRegular(
                            day.condition,
                            color: palette.white.withValues(alpha: 0.7),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ),
                  ),
                  // Temp Min/Max
                  Expanded(
                    flex: 2,
                    child: Align(
                      alignment: Alignment.centerRight,
                      child: RichText(
                        text: TextSpan(
                          style: Theme.of(context).appTypography.baseRegular
                              .copyWith(color: palette.white),
                          children: [
                            TextSpan(
                              text: day.tempMax,
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            TextSpan(
                              text: ' / ${day.tempMin}',
                              style: TextStyle(
                                color: palette.white.withValues(alpha: 0.5),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              );
            },
          ),
        ],
      ),
    );
  }
}
