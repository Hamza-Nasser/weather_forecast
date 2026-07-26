import 'dart:ui' show PlatformDispatcher;

import 'package:flutter/material.dart'
    show FlutterError, runApp, WidgetsFlutterBinding;
import 'package:flutter/services.dart';
import 'package:weather_app/app.dart';
import 'package:weather_app/configurations/di/injector.dart';
import 'package:weather_app/core/services/app_error_reporter.dart';
import 'package:weather_app/core/services/prefs/prefs.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await PreferenceUtils.init();

  if (PreferenceUtils.getString(PrefsKey.locale).isEmpty) {
    final platformLanguage = PlatformDispatcher.instance.locale.languageCode;
    final initialLanguage = {'en', 'ar'}.contains(platformLanguage)
        ? platformLanguage
        : 'en';
    await PreferenceUtils.setString(PrefsKey.locale, initialLanguage);
  }

  configureDependencies();
  final errorReporter = sl<AppErrorReporter>();
  FlutterError.onError = (details) {
    FlutterError.presentError(details);
    errorReporter.record(
      details.exception,
      details.stack ?? StackTrace.current,
      context: 'Flutter framework error',
    );
  };
  PlatformDispatcher.instance.onError = (error, stackTrace) {
    errorReporter.record(error, stackTrace, context: 'Uncaught platform error');
    return true;
  };

  await Future.wait([
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge),
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]),
  ]);

  runApp(const WeatherApp());
}
