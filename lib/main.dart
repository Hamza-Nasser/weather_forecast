import 'package:flutter/material.dart' show runApp, WidgetsFlutterBinding;
import 'package:flutter/services.dart';
import 'package:weather_app/app.dart';
import 'package:weather_app/configurations/di/injector.dart';
import 'package:weather_app/core/services/prefs/prefs.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  configureDependencies();
  await Future.wait([
    PreferenceUtils.init(),
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge),
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]),
  ]);

  runApp(const WeatherApp());
}
