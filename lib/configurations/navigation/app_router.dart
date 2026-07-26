import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:weather_app/configurations/di/injector.dart';
import 'package:weather_app/configurations/navigation/route_error_screen.dart';
import 'package:weather_app/core/services/prefs/app_preferences.dart';
import 'package:weather_app/features/settings/presentation/screens/settings_screen.dart';
import 'package:weather_app/features/weather/presentation/bloc/weather_bloc.dart';
import 'package:weather_app/features/weather/presentation/bloc/weather_event.dart';
import 'package:weather_app/features/weather/domain/weather_defaults.dart';
import 'package:weather_app/features/weather/presentation/screens/weather_screen.dart';

import 'app_routes.dart';

/// Centralized router configuration for the application.
///
/// Uses [GoRouter] for declarative routing with support for:
/// - Named routes via [AppRoute] enum
/// - Custom page transitions
/// - Error page for unknown routes
class AppRouter {
  AppRouter();

  late final GoRouter router = GoRouter(
    initialLocation: AppRoute.home.path,
    debugLogDiagnostics: kDebugMode,
    routes: _routes,
    errorBuilder: _errorBuilder,
  );

  /// Defines the application's route tree.
  ///
  /// Add new routes here as features are implemented.
  List<RouteBase> get _routes => [
    GoRoute(
      name: AppRoute.home.name,
      path: AppRoute.home.path,
      builder: (context, state) {
        final lastCity = sl<AppPreferences>().getLastCity();
        final initialCity = lastCity.isEmpty ? defaultWeatherCity : lastCity;

        return BlocProvider(
          create: (_) =>
              sl<WeatherBloc>()..add(WeatherFetchRequested(initialCity)),
          child: const WeatherScreen(),
        );
      },
    ),
    GoRoute(
      name: AppRoute.settings.name,
      path: AppRoute.settings.path,
      builder: (context, state) => const SettingsScreen(),
    ),
  ];

  /// Fallback screen for unknown routes.
  Widget _errorBuilder(BuildContext context, GoRouterState state) =>
      const RouteErrorScreen();
}
