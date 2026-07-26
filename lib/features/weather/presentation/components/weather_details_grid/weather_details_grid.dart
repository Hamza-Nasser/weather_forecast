import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:weather_app/configurations/ui/dimensions/app_dimensions.dart';
import 'package:weather_app/features/weather/presentation/components/sun_progress_calculator.dart';
import 'package:weather_app/l10n/app_localizations.dart';
import 'grid_components/detail_card.dart';
import 'grid_components/feels_like_content.dart';
import 'grid_components/humidity_content.dart';
import 'grid_components/lifestyle_content.dart';
import 'grid_components/moon_phase_content.dart';
import 'grid_components/pressure_content.dart';
import 'grid_components/sunrise_sunset_content.dart';
import 'grid_components/uv_index_content.dart';
import 'grid_components/visibility_content.dart';
import 'grid_components/wind_content.dart';

/// A 2-column grid displaying detailed weather metrics from the API.
class WeatherDetailsGrid extends StatelessWidget {
  final double temperatureCelsius;
  final String condition;
  final double windKph;
  final int humidity;
  final String cityName;

  final double feelsLikeCelsius;
  final double visibilityKm;
  final double pressureMb;
  final double uvIndex;
  final String sunrise;
  final String sunset;
  final String moonPhase;
  final String moonrise;

  const WeatherDetailsGrid({
    super.key,
    required this.temperatureCelsius,
    required this.condition,
    required this.windKph,
    required this.humidity,
    required this.cityName,
    required this.feelsLikeCelsius,
    required this.visibilityKm,
    required this.pressureMb,
    required this.uvIndex,
    required this.sunrise,
    required this.sunset,
    required this.moonPhase,
    required this.moonrise,
  });

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    final uv = uvIndex.round();
    final feelsLike = feelsLikeCelsius;
    final visibility = visibilityKm;
    final pressure = pressureMb.round();
    final moonPhaseText = moonPhase.isNotEmpty ? moonPhase : l10n.newMoon;
    final moonPhaseProgress = _getMoonPhaseProgress();
    final moonriseText = moonrise.isNotEmpty ? moonrise : l10n.noMoonrise;

    // Deterministic wind details
    final bft = (windKph / 3.6).round().clamp(1, 12);
    final directions = ['N', 'NE', 'E', 'SE', 'S', 'SW', 'W', 'NW'];
    final directionIndex = (windKph * 10).toInt() % directions.length;
    final windDirection = directions[directionIndex];
    final windAngle = directionIndex * 45.0;

    // Lifestyle Suitability
    final isRainy =
        condition.toLowerCase().contains('rain') ||
        condition.toLowerCase().contains('storm') ||
        condition.toLowerCase().contains('drizzle');
    final runningText = isRainy
        ? l10n.unsuitableForRunning
        : (temperatureCelsius > 28
              ? l10n.tooHotForRunning
              : l10n.greatForRunning);
    final fishingText = (isRainy || windKph > 22)
        ? l10n.notIdealFishing
        : l10n.idealFishing;
    final hikingText = isRainy
        ? l10n.unsuitableForHiking
        : (temperatureCelsius < 10
              ? l10n.coldForHiking
              : l10n.excellentForHiking);

    return Column(
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: DetailCard(
                height: 165,
                icon: Iconsax.sun_1,
                title: l10n.uvIndex,
                child: UvIndexContent(
                  uv: uv,
                  riskText: _getUvRiskText(l10n, uv),
                ),
              ),
            ),
            const SizedBox(width: AppSpacing.l),
            Expanded(
              child: DetailCard(
                height: 165,
                icon: Icons.thermostat,
                title: l10n.feelsLike,
                child: FeelsLikeContent(
                  feelsLike: feelsLike.round(),
                  actualTemp: temperatureCelsius.round(),
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: AppSpacing.l),

        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: DetailCard(
                height: 175,
                icon: Iconsax.wind_2,
                title: l10n.wind,
                child: WindContent(
                  speedKph: windKph,
                  bft: bft,
                  direction: windDirection,
                  angleDegrees: windAngle,
                ),
              ),
            ),
            const SizedBox(width: AppSpacing.l),
            Expanded(
              child: DetailCard(
                height: 175,
                icon: Icons.wb_sunny_outlined,
                title: l10n.sunriseLabel,
                child: SunriseSunsetContent(
                  sunrise: sunrise.isNotEmpty ? sunrise : '--',
                  sunset: sunset.isNotEmpty ? sunset : '--',
                  progress: SunProgressCalculator.calculate(
                    sunrise,
                    sunset,
                  ),
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: AppSpacing.l),

        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: DetailCard(
                height: 165,
                icon: Icons.water_drop_outlined,
                title: l10n.humidityLabel,
                child: HumidityContent(humidity: humidity),
              ),
            ),
            const SizedBox(width: AppSpacing.l),
            Expanded(
              child: DetailCard(
                height: 165,
                icon: Icons.visibility_outlined,
                title: l10n.visibility,
                child: VisibilityContent(
                  visibility: visibility,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: AppSpacing.l),

        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: DetailCard(
                height: 175,
                icon: Icons.speed_outlined,
                title: l10n.pressure,
                child: PressureContent(pressure: pressure),
              ),
            ),
            const SizedBox(width: AppSpacing.l),
            Expanded(
              child: DetailCard(
                height: 175,
                icon: Icons.nightlight_round,
                title: l10n.moonPhaseLabel,
                child: MoonPhaseContent(
                  phaseName: moonPhaseText,
                  moonriseText: moonriseText,
                  phaseProgress: moonPhaseProgress,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: AppSpacing.l),

        // Full width Lifestyle card
        DetailCard(
          icon: Icons.lightbulb_outline,
          title: l10n.lifestyle,
          child: LifestyleContent(
            runningText: runningText,
            fishingText: fishingText,
            hikingText: hikingText,
          ),
        ),
      ],
    );
  }

  String _getUvRiskText(AppLocalizations l10n, int uv) {
    if (uv <= 2) return l10n.uvAlmostNoRisk;
    if (uv <= 5) return l10n.uvLowRisk;
    return l10n.uvModerateHighRisk;
  }

  double _getMoonPhaseProgress() {
    final name = moonPhase.toLowerCase();
    if (name.contains('new')) return 0.0;
    if (name.contains('waxing') && name.contains('crescent')) return 0.2;
    if (name.contains('first') && name.contains('quarter')) return 0.25;
    if (name.contains('waxing') && name.contains('gibbous')) return 0.7;
    if (name.contains('full')) return 0.5;
    if (name.contains('waning') && name.contains('gibbous')) return 0.8;
    if (name.contains('last') || name.contains('third') || name.contains('quarter')) return 0.75;
    if (name.contains('waning') && name.contains('crescent')) return 0.9;
    return 0.7;
  }
}
