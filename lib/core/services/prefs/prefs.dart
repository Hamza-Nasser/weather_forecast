import 'dart:async' show Future;

import 'package:shared_preferences/shared_preferences.dart';

/// Keys for shared preferences storage.
///
/// Add new preference keys here as features require them.
enum PrefsKey { locale, lastCity }

/// Utility wrapper around [SharedPreferences].
///
/// Must be initialized in `main()` before use via [init].
class PreferenceUtils {
  static Future<SharedPreferences> get _instance async =>
      _prefsInstance ??= await SharedPreferences.getInstance();
  static SharedPreferences? _prefsInstance;

  /// Call this method from main() before runApp().
  static Future<SharedPreferences?> init() async {
    _prefsInstance = await SharedPreferences.getInstance();
    return _prefsInstance;
  }

  static String getString(PrefsKey key, [String? defValue]) {
    return _prefsInstance?.getString(key.name) ?? defValue ?? "";
  }

  static Future<bool> setString(PrefsKey key, String value) async {
    SharedPreferences? prefs = await _instance;
    return prefs.setString(key.name, value);
  }

  static bool getBool(PrefsKey key, [bool? defValue]) {
    return _prefsInstance?.getBool(key.name) ?? defValue ?? false;
  }

  static Future<bool> setBool(PrefsKey key, bool value) async {
    SharedPreferences? prefs = await _instance;
    return prefs.setBool(key.name, value);
  }

  static Future<bool> setInt(PrefsKey key, int value) async {
    SharedPreferences? prefs = await _instance;
    return prefs.setInt(key.name, value);
  }

  static int getInt(PrefsKey key, [int? defValue]) {
    return _prefsInstance?.getInt(key.name) ?? defValue ?? 0;
  }
}
