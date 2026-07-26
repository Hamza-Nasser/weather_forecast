import 'package:injectable/injectable.dart';
import 'package:weather_app/core/services/prefs/prefs.dart';

/// Service abstraction for persistent key-value preferences.
///
/// Use this interface throughout the codebase instead of direct static
/// calls to [PreferenceUtils] to ensure clean testing and injection.
abstract class AppPreferences {
  /// Gets the currently saved locale language code (e.g., 'en', 'ar').
  String getLocale();

  /// Saves the locale language code.
  Future<bool> setLocale(String locale);

  /// Gets the preferred temperature unit (e.g., 'celsius', 'fahrenheit').
  String getTemperatureUnit();

  /// Saves the preferred temperature unit.
  Future<bool> setTemperatureUnit(String unit);

  /// Gets the last searched city.
  String getLastCity();

  /// Saves the last searched city.
  Future<bool> setLastCity(String city);
}

@LazySingleton(as: AppPreferences)
class AppPreferencesImpl implements AppPreferences {
  const AppPreferencesImpl();

  @override
  String getLocale() {
    return PreferenceUtils.getString(PrefsKey.locale);
  }

  @override
  Future<bool> setLocale(String locale) {
    return PreferenceUtils.setString(PrefsKey.locale, locale);
  }

  @override
  String getTemperatureUnit() {
    return PreferenceUtils.getString(PrefsKey.temperatureUnit, 'celsius');
  }

  @override
  Future<bool> setTemperatureUnit(String unit) {
    return PreferenceUtils.setString(PrefsKey.temperatureUnit, unit);
  }

  @override
  String getLastCity() {
    return PreferenceUtils.getString(PrefsKey.lastCity);
  }

  @override
  Future<bool> setLastCity(String city) {
    return PreferenceUtils.setString(PrefsKey.lastCity, city);
  }
}
