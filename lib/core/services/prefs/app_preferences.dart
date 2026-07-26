import 'package:injectable/injectable.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// Service abstraction for persistent key-value preferences.
///
/// Use this interface throughout the codebase to keep storage injectable and
/// testable.
abstract class AppPreferences {
  /// Gets the currently saved locale language code (e.g., 'en', 'ar').
  String getLocale();

  /// Saves the locale language code.
  Future<bool> setLocale(String locale);

  /// Gets the last searched city.
  String getLastCity();

  /// Saves the last searched city.
  Future<bool> setLastCity(String city);
}

@LazySingleton(as: AppPreferences)
class AppPreferencesImpl implements AppPreferences {
  const AppPreferencesImpl(this._preferences);

  static const String _localeKey = 'locale';
  static const String _lastCityKey = 'lastCity';

  final SharedPreferences _preferences;

  @override
  String getLocale() {
    return _preferences.getString(_localeKey) ?? '';
  }

  @override
  Future<bool> setLocale(String locale) {
    return _preferences.setString(_localeKey, locale);
  }

  @override
  String getLastCity() {
    return _preferences.getString(_lastCityKey) ?? '';
  }

  @override
  Future<bool> setLastCity(String city) {
    return _preferences.setString(_lastCityKey, city);
  }
}

@module
abstract class PreferencesModule {
  @preResolve
  Future<SharedPreferences> createPreferences() =>
      SharedPreferences.getInstance();
}
