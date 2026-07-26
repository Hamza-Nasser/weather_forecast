import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:weather_app/configurations/ui/dimensions/app_dimensions.dart';
import 'package:weather_app/features/weather/presentation/bloc/weather_state.dart';
import 'package:weather_app/features/weather/presentation/components/sun_progress_calculator.dart';
import 'package:weather_app/features/weather/presentation/components/weather_details_grid/weather_details_grid.dart';
import 'package:weather_app/features/weather/presentation/components/weather_home_card.dart';
import 'package:weather_app/features/weather/presentation/components/weather_loading_card.dart';
import 'package:weather_app/features/weather/presentation/components/weather_visuals.dart';
import 'package:weather_app/features/weather/presentation/components/weather_welcome_card.dart';
import 'package:weather_app/features/weather/presentation/components/weekly_forecast_section.dart';
import 'package:weather_app/l10n/app_localizations.dart';
import 'package:weather_app/shared/ui/widgets/error_state.dart';

/// Renders the correct content based on [WeatherState.status].
///
/// Replaces the old `_buildStateContent` / `_buildSuccessContent` widget helper
/// functions in the weather screen with a proper [StatelessWidget].
class WeatherStateContent extends StatelessWidget {
  final WeatherState state;
  final List<Color> blobColors;
  final VoidCallback onRetry;

  const WeatherStateContent({
    super.key,
    required this.state,
    required this.blobColors,
    required this.onRetry,
  });

  @override
  Widget build(BuildContext context) {
    // If loading but we already have city data, show skeleton overlay
    // on the success layout to prevent layout shifts.
    if (state.status == WeatherStatus.loading && state.cityName.isNotEmpty) {
      return Skeletonizer(
        key: const ValueKey('loading-with-data'),
        enabled: true,
        child: _SuccessContent(
          key: const ValueKey('success-content'),
          state: state,
          blobColors: blobColors,
        ),
      );
    }

    return switch (state.status) {
      WeatherStatus.initial => const WeatherWelcomeCard(
        key: ValueKey('initial'),
      ),
      WeatherStatus.loading => const WeatherLoadingCard(
        key: ValueKey('loading'),
      ),
      WeatherStatus.failure => ErrorState(
        key: const ValueKey('failure'),
        message:
            state.error?.getLocalizedMessage(AppLocalizations.of(context)!) ??
            state.errorMessage ??
            AppLocalizations.of(context)!.failedToLoadWeather,
        onRetry: onRetry,
      ),
      WeatherStatus.success => _SuccessContent(
        key: const ValueKey('success-content'),
        state: state,
        blobColors: blobColors,
      ),
    };
  }
}

/// The full success layout: blobs + glass card + weekly forecast + details grid.
class _SuccessContent extends StatelessWidget {
  final WeatherState state;
  final List<Color> blobColors;

  const _SuccessContent({
    super.key,
    required this.state,
    required this.blobColors,
  });

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final hourlyForecast = _buildHourlyForecast();
    final weeklyForecast = _buildWeeklyForecast(l10n);

    return Column(
      children: [
        Stack(
          clipBehavior: Clip.none,
          children: [
            // Top-right decorative blob
            Positioned(
              top: -40,
              right: -30,
              child: AnimatedContainer(
                duration: AppDuration.slow,
                width: 130,
                height: 130,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: RadialGradient(
                    colors: [blobColors[0], Colors.transparent],
                  ),
                ),
              ),
            ),
            // Bottom-left decorative blob
            Positioned(
              bottom: -20,
              left: -20,
              child: AnimatedContainer(
                duration: AppDuration.slow,
                width: 150,
                height: 150,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: RadialGradient(
                    colors: [blobColors[1], Colors.transparent],
                  ),
                ),
              ),
            ),
            // The Glass Card
            WeatherHomeCard(
              cityName: state.cityName,
              region: state.region,
              country: state.country,
              temperature: state.temperatureCelsius.round().toString(),
              condition: state.condition,
              feelsLike: '${state.feelsLikeCelsius.round()}°C',
              humidity: '${state.humidity}%',
              windForce: '${state.windKph.round()} km/h',
              pressure: '${state.pressureMb.round()} hPa',
              sunrise: state.sunrise.isNotEmpty ? state.sunrise : '--',
              sunset: state.sunset.isNotEmpty ? state.sunset : '--',
              sunProgress: SunProgressCalculator.calculate(
                state.sunrise,
                state.sunset,
              ),
              hourlyForecast: hourlyForecast,
              iconUrl: state.iconUrl,
            ),
          ],
        ),
        const SizedBox(height: AppSpacing.l),
        WeeklyForecastSection(forecastList: weeklyForecast),
        const SizedBox(height: AppSpacing.l),
        WeatherDetailsGrid(
          temperatureCelsius: state.temperatureCelsius,
          condition: state.condition,
          windKph: state.windKph,
          humidity: state.humidity,
          cityName: state.cityName,
          feelsLikeCelsius: state.feelsLikeCelsius,
          visibilityKm: state.visibilityKm,
          pressureMb: state.pressureMb,
          uvIndex: state.uvIndex,
          sunrise: state.sunrise,
          sunset: state.sunset,
          moonPhase: state.moonPhase,
          moonrise: state.moonrise,
        ),
      ],
    );
  }

  List<HourlyForecastData> _buildHourlyForecast() {
    if (state.hourlyForecast.isEmpty) {
      return WeatherVisuals.generateForecast(
        state.temperatureCelsius,
        state.condition,
      );
    }

    final now = DateTime.now();
    final currentHour = now.hour;

    final futureHours = state.hourlyForecast.where((h) {
      final hourDateTime = DateTime.tryParse(h.time);
      if (hourDateTime == null) return false;
      return hourDateTime.hour >= currentHour || hourDateTime.isAfter(now);
    }).toList();

    final selectedHours = futureHours.isNotEmpty
        ? futureHours
        : state.hourlyForecast;

    return selectedHours.map((h) {
      final dateTime = DateTime.tryParse(h.time);
      final hourStr = dateTime != null
          ? '${dateTime.hour.toString().padLeft(2, '0')}:00'
          : h.time;

      final result = WeatherVisuals.conditionIcon(
        h.condition,
        isDay: h.isDay != 0,
      );

      return HourlyForecastData(
        time: hourStr,
        icon: result.icon,
        iconColor: result.color,
        temperature: '${h.tempC.round()}°C',
      );
    }).toList();
  }

  List<WeeklyForecastData> _buildWeeklyForecast(AppLocalizations l10n) {
    return state.dailyForecast.map((d) {
      final dateTime = DateTime.tryParse(d.date);
      final String dayName;
      if (dateTime != null) {
        final now = DateTime.now();
        if (dateTime.year == now.year &&
            dateTime.month == now.month &&
            dateTime.day == now.day) {
          dayName = l10n.today;
        } else {
          final daysOfWeek = [
            l10n.monday,
            l10n.tuesday,
            l10n.wednesday,
            l10n.thursday,
            l10n.friday,
            l10n.saturday,
            l10n.sunday,
          ];
          dayName = daysOfWeek[dateTime.weekday - 1];
        }
      } else {
        dayName = d.date;
      }

      final cond = d.condition.toLowerCase();
      IconData icon;
      if (cond.contains('sunny') || cond.contains('clear')) {
        icon = Iconsax.sun_1;
      } else if (cond.contains('rain') ||
          cond.contains('drizzle') ||
          cond.contains('shower') ||
          cond.contains('storm')) {
        icon = Iconsax.cloud_drizzle;
      } else if (cond.contains('cloud') || cond.contains('overcast')) {
        icon = Iconsax.cloud_notif;
      } else {
        icon = Iconsax.cloud;
      }

      return WeeklyForecastData(
        dayName: dayName,
        condition: d.condition,
        icon: icon,
        tempMax: '${d.maxTempC.round()}°',
        tempMin: '${d.minTempC.round()}°',
      );
    }).toList();
  }
}
