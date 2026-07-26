import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:weather_app/configurations/ui/theme/theme_helpers.dart';
import 'package:weather_app/l10n/app_localizations.dart';

class WidgetTestApp extends StatelessWidget {
  const WidgetTestApp({
    required this.child,
    this.locale = const Locale('en'),
    this.themeMode = ThemeMode.dark,
    this.size = const Size(800, 1200),
    this.textScaler = TextScaler.noScaling,
    super.key,
  });

  final Widget child;
  final Locale locale;
  final ThemeMode themeMode;
  final Size size;
  final TextScaler textScaler;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      locale: locale,
      supportedLocales: AppLocalizations.supportedLocales,
      localizationsDelegates: const [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      theme: createThemeData(
        palette: lightColorPalette,
        typography: defaultTypography,
        brightness: Brightness.light,
      ),
      darkTheme: createThemeData(
        palette: darkColorPalette,
        typography: defaultTypography,
        brightness: Brightness.dark,
      ),
      themeMode: themeMode,
      home: MediaQuery(
        data: MediaQueryData(size: size, textScaler: textScaler),
        child: child,
      ),
    );
  }
}
