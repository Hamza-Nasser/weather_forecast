import 'package:flutter/material.dart';
import 'package:weather_app/configurations/ui/dimensions/app_dimensions.dart';
import 'package:weather_app/configurations/ui/theme/theme_data.dart';
import 'package:weather_app/features/weather/presentation/components/hourly_forecast_item.dart';
import 'package:weather_app/features/weather/presentation/components/weather_details_section.dart';
import 'package:weather_app/shared/ui/widgets/glass_surface.dart';
import 'package:weather_app/shared/ui/widgets/network_image/network_image.dart';
import 'package:weather_app/shared/ui/widgets/text.dart';

/// The main glassmorphism weather card matching the design reference.
///
/// Displays:
/// - City name
/// - Large temperature
/// - Condition text
/// - Horizontal hourly forecast
/// - Details section (sun arc + stats)
class WeatherHomeCard extends StatelessWidget {
  final String cityName;
  final String region;
  final String country;
  final String temperature;
  final String condition;
  final String feelsLike;
  final String humidity;
  final String windForce;
  final String pressure;
  final String sunrise;
  final String sunset;
  final double sunProgress;
  final List<HourlyForecastData> hourlyForecast;
  final String? iconUrl;

  const WeatherHomeCard({
    super.key,
    required this.cityName,
    this.region = '',
    this.country = '',
    required this.temperature,
    required this.condition,
    required this.feelsLike,
    required this.humidity,
    required this.windForce,
    required this.pressure,
    required this.sunrise,
    required this.sunset,
    required this.sunProgress,
    required this.hourlyForecast,
    this.iconUrl,
  });

  @override
  Widget build(BuildContext context) {
    final palette = Theme.of(context).colorPalette;

    return GlassSurface(
      blur: 20,
      opacity: 0.12,
      tintColor: palette.white,
      borderOpacity: 0.15,
      borderRadius: const BorderRadius.all(Radius.circular(AppBorderRadius.l)),
      padding: const EdgeInsets.all(AppSpacing.xl),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // City name
          UiText.titleSemibold(cityName, color: palette.white),
          if (region.isNotEmpty || country.isNotEmpty) ...[
            const SizedBox(height: AppSpacing.xs),
            UiText.smallRegular(
              '${region.isNotEmpty ? '$region, ' : ''}$country',
              color: palette.white.withValues(alpha: 0.6),
              textAlign: TextAlign.center,
            ),
          ],
          const SizedBox(height: AppSpacing.xl),

          // Large temperature
          _TemperatureDisplay(temperature: temperature, iconUrl: iconUrl),
          const SizedBox(height: AppSpacing.xs),

          // Condition
          UiText.baseMedium(
            condition,
            color: palette.white.withValues(alpha: 0.6),
          ),
          const SizedBox(height: AppSpacing.xxl),

          // Hourly forecast row
          _HourlyForecastRow(items: hourlyForecast),
          const SizedBox(height: AppSpacing.l),

          // Divider
          Divider(color: palette.dark03, height: 1),
          const SizedBox(height: AppSpacing.l),

          // Details section
          WeatherDetailsSection(
            sunrise: sunrise,
            sunset: sunset,
            sunProgress: sunProgress,
            feelsLike: feelsLike,
            humidity: humidity,
            windForce: windForce,
            pressure: pressure,
          ),
        ],
      ),
    );
  }
}

/// Large temperature display with degree symbol.
class _TemperatureDisplay extends StatelessWidget {
  final String temperature;
  final String? iconUrl;

  const _TemperatureDisplay({required this.temperature, this.iconUrl});

  @override
  Widget build(BuildContext context) {
    final palette = Theme.of(context).colorPalette;

    return Row(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        if (iconUrl != null) ...[
          UiNetworkImage(
            url: iconUrl!.startsWith('http') ? iconUrl! : 'https:$iconUrl',
            width: 64,
            height: 64,
            fit: BoxFit.contain,
            borderRadius: BorderRadius.zero,
            errorWidget: const SizedBox.shrink(),
          ),
          const SizedBox(width: AppSpacing.s),
        ],
        UiText.headlineRegular(
          temperature,
          color: palette.white,
          style: const TextStyle(fontSize: 72, height: 1.0),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 8),
          child: UiText.headlineRegular('°C', color: palette.white),
        ),
      ],
    );
  }
}

/// Horizontal scrollable hourly forecast row.
class _HourlyForecastRow extends StatelessWidget {
  final List<HourlyForecastData> items;

  const _HourlyForecastRow({required this.items});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      physics: const BouncingScrollPhysics(),
      child: Row(
        children: items
            .map(
              (item) => Padding(
                padding: const EdgeInsets.symmetric(horizontal: AppSpacing.m),
                child: HourlyForecastItem(
                  time: item.time,
                  icon: item.icon,
                  iconColor: item.iconColor,
                  temperature: item.temperature,
                ),
              ),
            )
            .toList(),
      ),
    );
  }
}

/// Data model for an hourly forecast item.
class HourlyForecastData {
  final String time;
  final IconData icon;
  final Color iconColor;
  final String temperature;

  const HourlyForecastData({
    required this.time,
    required this.icon,
    required this.iconColor,
    required this.temperature,
  });
}
