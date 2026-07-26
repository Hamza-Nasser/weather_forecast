import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:weather_app/configurations/di/injector.dart';
import 'package:weather_app/configurations/navigation/app_router.dart';
import 'package:weather_app/configurations/ui/theme/theme_helpers.dart';
import 'package:weather_app/features/settings/presentation/bloc/settings_cubit.dart';
import 'package:weather_app/features/settings/presentation/bloc/settings_state.dart';
import 'package:weather_app/l10n/app_localizations.dart';

class WeatherApp extends StatefulWidget {
  const WeatherApp({super.key});

  @override
  State<WeatherApp> createState() => _WeatherAppState();
}

class _WeatherAppState extends State<WeatherApp> {
  late final AppRouter _appRouter;

  @override
  void initState() {
    super.initState();
    _appRouter = AppRouter();
  }

  ThemeData get _lightTheme => createThemeData(
    palette: lightColorPalette,
    typography: defaultTypography,
    brightness: Brightness.light,
  );

  ThemeData get _darkTheme => createThemeData(
    palette: darkColorPalette,
    typography: defaultTypography,
    brightness: Brightness.dark,
  );

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => sl<SettingsCubit>(),
      child: BlocBuilder<SettingsCubit, SettingsState>(
        builder: (context, state) {
          return MaterialApp.router(
            routerConfig: _appRouter.router,
            theme: _lightTheme,
            darkTheme: _darkTheme,
            themeMode: ThemeMode.system,
            title: 'Weather App',
            locale: state.locale.isEmpty ? null : Locale(state.locale),
            localizationsDelegates: const [
              AppLocalizations.delegate,
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
              GlobalCupertinoLocalizations.delegate,
            ],
            supportedLocales: AppLocalizations.supportedLocales,
            debugShowCheckedModeBanner: false,
          );
        },
      ),
    );
  }
}
