import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:weather_app/configurations/ui/dimensions/app_dimensions.dart';
import 'package:weather_app/features/weather/domain/utils/weather_condition_kind.dart';
import 'package:weather_app/features/weather/domain/utils/weather_wind_scale.dart';
import 'package:weather_app/features/weather/presentation/components/sun_progress_calculator.dart';
import 'package:weather_app/features/weather/presentation/components/weather_details_grid/grid_components/detail_card.dart';
import 'package:weather_app/features/weather/presentation/components/weather_details_grid/grid_components/feels_like_content.dart';
import 'package:weather_app/features/weather/presentation/components/weather_details_grid/grid_components/humidity_content.dart';
import 'package:weather_app/features/weather/presentation/components/weather_details_grid/grid_components/lifestyle_content.dart';
import 'package:weather_app/features/weather/presentation/components/weather_details_grid/grid_components/moon_phase_content.dart';
import 'package:weather_app/features/weather/presentation/components/weather_details_grid/grid_components/pressure_content.dart';
import 'package:weather_app/features/weather/presentation/components/weather_details_grid/grid_components/sunrise_sunset_content.dart';
import 'package:weather_app/features/weather/presentation/components/weather_details_grid/grid_components/uv_index_content.dart';
import 'package:weather_app/features/weather/presentation/components/weather_details_grid/grid_components/visibility_content.dart';
import 'package:weather_app/features/weather/presentation/components/weather_details_grid/grid_components/wind_content.dart';
import 'package:weather_app/features/weather/presentation/components/weather_details_grid/responsive_detail_pair.dart';
import 'package:weather_app/l10n/app_localizations.dart';

class WeatherDetailsGrid extends StatelessWidget {
  const WeatherDetailsGrid({
    super.key,
    required this.temperatureCelsius,
    required this.conditionCode,
    required this.windKph,
    required this.windDirection,
    required this.windDegree,
    required this.humidity,
    required this.feelsLikeCelsius,
    required this.visibilityKm,
    required this.pressureMb,
    required this.uvIndex,
    required this.sunrise,
    required this.sunset,
    required this.moonPhase,
    required this.moonrise,
    required this.locationNow,
  });

  final double temperatureCelsius;
  final int conditionCode;
  final double windKph;
  final String windDirection;
  final int windDegree;
  final int humidity;
  final double feelsLikeCelsius;
  final double visibilityKm;
  final double pressureMb;
  final double uvIndex;
  final String sunrise;
  final String sunset;
  final String moonPhase;
  final String moonrise;
  final DateTime locationNow;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final textScale = MediaQuery.textScalerOf(
      context,
    ).scale(1).clamp(1, 1.5).toDouble();
    final compactHeight = 190 * textScale;
    final tallHeight = 200 * textScale;
    final unsafe = WeatherConditionClassifier.isUnsafeForOutdoorActivities(
      conditionCode,
    );

    return Column(
      children: [
        ResponsiveDetailPair(
          first: DetailCard(
            height: compactHeight,
            icon: Iconsax.sun_1,
            title: l10n.uvIndex,
            child: UvIndexContent(
              uv: uvIndex.round(),
              riskText: _uvRisk(l10n, uvIndex.round()),
            ),
          ),
          second: DetailCard(
            height: compactHeight,
            icon: Icons.thermostat,
            title: l10n.feelsLike,
            child: FeelsLikeContent(
              feelsLike: feelsLikeCelsius.round(),
              actualTemp: temperatureCelsius.round(),
            ),
          ),
        ),
        const SizedBox(height: AppSpacing.l),
        ResponsiveDetailPair(
          first: DetailCard(
            height: tallHeight,
            icon: Iconsax.wind_2,
            title: l10n.wind,
            child: WindContent(
              speedKph: windKph,
              bft: WeatherWindScale.beaufort(windKph),
              direction: windDirection.isEmpty ? '--' : windDirection,
              angleDegrees: windDegree.toDouble(),
            ),
          ),
          second: DetailCard(
            height: tallHeight,
            icon: Icons.wb_sunny_outlined,
            title: l10n.sunriseLabel,
            child: SunriseSunsetContent(
              sunrise: sunrise.isEmpty ? '--' : sunrise,
              sunset: sunset.isEmpty ? '--' : sunset,
              progress: SunProgressCalculator.calculate(
                sunrise,
                sunset,
                now: locationNow,
              ),
            ),
          ),
        ),
        const SizedBox(height: AppSpacing.l),
        ResponsiveDetailPair(
          first: DetailCard(
            height: compactHeight,
            icon: Icons.water_drop_outlined,
            title: l10n.humidityLabel,
            child: HumidityContent(humidity: humidity),
          ),
          second: DetailCard(
            height: compactHeight,
            icon: Icons.visibility_outlined,
            title: l10n.visibility,
            child: VisibilityContent(visibility: visibilityKm),
          ),
        ),
        const SizedBox(height: AppSpacing.l),
        ResponsiveDetailPair(
          first: DetailCard(
            height: tallHeight,
            icon: Icons.speed_outlined,
            title: l10n.pressure,
            child: PressureContent(pressure: pressureMb.round()),
          ),
          second: DetailCard(
            height: tallHeight,
            icon: Icons.nightlight_round,
            title: l10n.moonPhaseLabel,
            child: MoonPhaseContent(
              phaseName: moonPhase.isEmpty ? l10n.newMoon : moonPhase,
              moonriseText: moonrise.isEmpty ? l10n.noMoonrise : moonrise,
              phaseProgress: _moonProgress(moonPhase),
            ),
          ),
        ),
        const SizedBox(height: AppSpacing.l),
        DetailCard(
          icon: Icons.lightbulb_outline,
          title: l10n.lifestyle,
          child: LifestyleContent(
            runningText: unsafe
                ? l10n.unsuitableForRunning
                : temperatureCelsius > 28
                ? l10n.tooHotForRunning
                : l10n.greatForRunning,
            fishingText: unsafe || windKph > 22
                ? l10n.notIdealFishing
                : l10n.idealFishing,
            hikingText: unsafe
                ? l10n.unsuitableForHiking
                : temperatureCelsius < 10
                ? l10n.coldForHiking
                : l10n.excellentForHiking,
          ),
        ),
      ],
    );
  }

  static String _uvRisk(AppLocalizations l10n, int uv) {
    if (uv <= 2) return l10n.uvAlmostNoRisk;
    if (uv <= 5) return l10n.uvLowRisk;
    return l10n.uvModerateHighRisk;
  }

  static double _moonProgress(String phase) {
    final value = phase.toLowerCase();
    if (value.contains('new')) return 0;
    if (value.contains('waxing') && value.contains('crescent')) return 0.125;
    if (value.contains('first') && value.contains('quarter')) return 0.25;
    if (value.contains('waxing') && value.contains('gibbous')) return 0.375;
    if (value.contains('full')) return 0.5;
    if (value.contains('waning') && value.contains('gibbous')) return 0.625;
    if (value.contains('last') || value.contains('third')) return 0.75;
    if (value.contains('waning') && value.contains('crescent')) return 0.875;
    return 0;
  }
}
