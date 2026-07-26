import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:weather_app/core/cache/cache_client.dart';
import 'package:weather_app/core/services/prefs/app_preferences.dart';
import 'settings_state.dart';

/// Cubit to manage user settings (like locale/language).
@injectable
class SettingsCubit extends Cubit<SettingsState> {
  SettingsCubit(this._prefs, this._cacheClient)
      : super(SettingsState(locale: _prefs.getLocale()));

  final AppPreferences _prefs;
  final CacheClient _cacheClient;

  /// Changes and persists the app locale.
  ///
  /// Also clears weather cache so stale localized strings are refreshed.
  Future<void> changeLanguage(String languageCode) async {
    final success = await _prefs.setLocale(languageCode);
    if (success) {
      await _cacheClient.removeMatching('weather_');
      emit(state.copyWith(locale: languageCode));
    }
  }
}
