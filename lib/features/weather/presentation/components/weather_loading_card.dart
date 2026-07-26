import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:weather_app/configurations/ui/dimensions/app_dimensions.dart';
import 'package:weather_app/features/weather/presentation/components/weather_details_grid/weather_details_grid.dart';
import 'package:weather_app/features/weather/presentation/components/weather_home_card.dart';
import 'package:weather_app/features/weather/presentation/components/weekly_forecast_section.dart';

/// A skeleton loading card shown while fetching weather data for the first time.
class WeatherLoadingCard extends StatelessWidget {
  const WeatherLoadingCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Skeletonizer(
      enabled: true,
      child: Column(
        children: [
          WeatherHomeCard(
            cityName: 'Bengaluru',
            temperature: '20',
            condition: 'Clear Sky',
            feelsLike: '18°C',
            humidity: '63%',
            windForce: '12 km/h',
            pressure: '1013 hPa',
            sunrise: '06:12 AM',
            sunset: '06:34 PM',
            sunProgress: 0.5,
            hourlyForecast: const [
              HourlyForecastData(
                time: '12:00',
                icon: Icons.wb_sunny,
                iconColor: Colors.white,
                temperature: '20°C',
              ),
              HourlyForecastData(
                time: '13:00',
                icon: Icons.wb_sunny,
                iconColor: Colors.white,
                temperature: '20°C',
              ),
              HourlyForecastData(
                time: '14:00',
                icon: Icons.wb_sunny,
                iconColor: Colors.white,
                temperature: '20°C',
              ),
              HourlyForecastData(
                time: '15:00',
                icon: Icons.wb_sunny,
                iconColor: Colors.white,
                temperature: '20°C',
              ),
              HourlyForecastData(
                time: '16:00',
                icon: Icons.wb_sunny,
                iconColor: Colors.white,
                temperature: '20°C',
              ),
            ],
          ),
          const SizedBox(height: AppSpacing.l),
          const WeeklyForecastSection(
            forecastList: [
              WeeklyForecastData(
                dayName: 'Today',
                condition: 'Clear',
                icon: Iconsax.sun_1,
                tempMax: '20°',
                tempMin: '15°',
              ),
              WeeklyForecastData(
                dayName: 'Tomorrow',
                condition: 'Clear',
                icon: Iconsax.sun_1,
                tempMax: '21°',
                tempMin: '16°',
              ),
              WeeklyForecastData(
                dayName: 'Wednesday',
                condition: 'Cloudy',
                icon: Iconsax.cloud_notif,
                tempMax: '19°',
                tempMin: '14°',
              ),
              WeeklyForecastData(
                dayName: 'Thursday',
                condition: 'Rain',
                icon: Iconsax.cloud_drizzle,
                tempMax: '18°',
                tempMin: '13°',
              ),
              WeeklyForecastData(
                dayName: 'Friday',
                condition: 'Clear',
                icon: Iconsax.sun_1,
                tempMax: '20°',
                tempMin: '15°',
              ),
            ],
          ),
          const SizedBox(height: AppSpacing.l),
          const WeatherDetailsGrid(
            temperatureCelsius: 20,
            condition: 'Clear',
            windKph: 12,
            humidity: 63,
            cityName: 'Bengaluru',
            feelsLikeCelsius: 18.0,
            visibilityKm: 10.0,
            pressureMb: 1013.0,
            uvIndex: 2.0,
            sunrise: '06:12 AM',
            sunset: '06:34 PM',
            moonPhase: 'Waxing Gibbous',
            moonrise: '02:30 PM',
          ),
        ],
      ),
    );
  }
}
