import 'package:flutter/material.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:weather_app/configurations/ui/dimensions/app_dimensions.dart';
import 'package:weather_app/features/weather/domain/utils/weather_location_time.dart';
import 'package:weather_app/features/weather/presentation/bloc/weather_state.dart';
import 'package:weather_app/features/weather/presentation/components/sun_progress_calculator.dart';
import 'package:weather_app/features/weather/presentation/components/responsive_weather_layout.dart';
import 'package:weather_app/features/weather/presentation/components/weather_details_grid/weather_details_grid.dart';
import 'package:weather_app/features/weather/presentation/components/weather_freshness_label.dart';
import 'package:weather_app/features/weather/presentation/components/weather_home_card.dart';
import 'package:weather_app/features/weather/presentation/components/weather_loading_card.dart';
import 'package:weather_app/features/weather/presentation/components/weather_visuals.dart';
import 'package:weather_app/features/weather/presentation/components/weather_welcome_card.dart';
import 'package:weather_app/features/weather/presentation/components/weekly_forecast_section.dart';
import 'package:weather_app/l10n/app_localizations.dart';
import 'package:weather_app/shared/ui/widgets/error_state.dart';

class WeatherStateContent extends StatelessWidget {
  const WeatherStateContent({
    super.key,
    required this.state,
    required this.blobColors,
    required this.onRetry,
  });

  final WeatherState state;
  final List<Color> blobColors;
  final VoidCallback onRetry;

  @override
  Widget build(BuildContext context) {
    if (state.status == WeatherStatus.loading && state.cityName.isNotEmpty) {
      return Skeletonizer(
        key: const ValueKey('loading-with-data'),
        enabled: true,
        child: _WeatherSuccessContent(state: state, blobColors: blobColors),
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
            AppLocalizations.of(context)!.failedToLoadWeather,
        onRetry: onRetry,
      ),
      WeatherStatus.success => _WeatherSuccessContent(
        key: const ValueKey('success-content'),
        state: state,
        blobColors: blobColors,
      ),
    };
  }
}

class _WeatherSuccessContent extends StatelessWidget {
  const _WeatherSuccessContent({
    super.key,
    required this.state,
    required this.blobColors,
  });

  final WeatherState state;
  final List<Color> blobColors;

  @override
  Widget build(BuildContext context) {
    final locationNow = WeatherLocationTime.nowAtLocation(
      state.locationUtcOffsetMinutes,
    );
    final hourly = _WeatherForecastMapper.hourly(state, locationNow);
    final weekly = _WeatherForecastMapper.weekly(
      state,
      locationNow,
      AppLocalizations.of(context)!,
    );

    final heroCard = Column(
      children: [
        Stack(
          clipBehavior: Clip.none,
          children: [
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
                now: locationNow,
              ),
              hourlyForecast: hourly,
              iconUrl: state.iconUrl,
            ),
          ],
        ),
        if (state.lastUpdated != null) ...[
          const SizedBox(height: AppSpacing.m),
          WeatherFreshnessLabel(
            lastUpdated: state.lastUpdated!,
            isFromCache: state.isFromCache,
            isStale: state.isStale,
          ),
        ],
      ],
    );

    final secondaryContent = Column(
      children: [
        if (weekly.isNotEmpty) ...[
          WeeklyForecastSection(forecastList: weekly),
          const SizedBox(height: AppSpacing.l),
        ],
        WeatherDetailsGrid(
          temperatureCelsius: state.temperatureCelsius,
          conditionCode: state.conditionCode,
          windKph: state.windKph,
          windDirection: state.windDirection,
          windDegree: state.windDegree,
          humidity: state.humidity,
          feelsLikeCelsius: state.feelsLikeCelsius,
          visibilityKm: state.visibilityKm,
          pressureMb: state.pressureMb,
          uvIndex: state.uvIndex,
          sunrise: state.sunrise,
          sunset: state.sunset,
          moonPhase: state.moonPhase,
          moonrise: state.moonrise,
          locationNow: locationNow,
        ),
      ],
    );

    return ResponsiveWeatherLayout(
      heroCard: heroCard,
      secondaryContent: secondaryContent,
    );
  }
}

class _WeatherForecastMapper {
  const _WeatherForecastMapper._();

  static List<HourlyForecastData> hourly(
    WeatherState state,
    DateTime locationNow,
  ) {
    return state.hourlyForecast
        .where((hour) {
          if (hour.timeEpoch > 0) {
            return hour.timeEpoch >
                DateTime.now().toUtc().millisecondsSinceEpoch ~/ 1000;
          }
          final parsed = WeatherLocationTime.parseWallTime(hour.time);
          return parsed != null && !parsed.isBefore(locationNow);
        })
        .map((hour) {
          final dateTime = WeatherLocationTime.parseWallTime(hour.time);
          final time = dateTime == null
              ? hour.time
              : '${dateTime.hour.toString().padLeft(2, '0')}:00';
          final visual = WeatherVisuals.conditionIcon(
            hour.conditionCode,
            isDay: hour.isDay != 0,
          );
          return HourlyForecastData(
            time: time,
            icon: visual.icon,
            iconColor: visual.color,
            temperature: '${hour.tempC.round()}°C',
          );
        })
        .toList(growable: false);
  }

  static List<WeeklyForecastData> weekly(
    WeatherState state,
    DateTime locationNow,
    AppLocalizations l10n,
  ) {
    final daysOfWeek = [
      l10n.monday,
      l10n.tuesday,
      l10n.wednesday,
      l10n.thursday,
      l10n.friday,
      l10n.saturday,
      l10n.sunday,
    ];
    return state.dailyForecast
        .map((day) {
          final date = DateTime.tryParse(day.date);
          final isToday =
              date != null &&
              date.year == locationNow.year &&
              date.month == locationNow.month &&
              date.day == locationNow.day;
          final visual = WeatherVisuals.conditionIcon(day.conditionCode);
          return WeeklyForecastData(
            dayName: date == null
                ? day.date
                : isToday
                ? l10n.today
                : daysOfWeek[date.weekday - 1],
            condition: day.condition,
            icon: visual.icon,
            tempMax: '${day.maxTempC.round()}°',
            tempMin: '${day.minTempC.round()}°',
          );
        })
        .toList(growable: false);
  }
}
