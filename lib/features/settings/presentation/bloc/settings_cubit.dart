import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:weather_app/core/cache/cache_client.dart';
import 'package:weather_app/core/services/app_error_reporter.dart';
import 'package:weather_app/core/services/prefs/app_preferences.dart';
import 'settings_state.dart';

/// Cubit to manage user settings (like locale/language).
@injectable
class SettingsCubit extends Cubit<SettingsState> {
  SettingsCubit(this._prefs, this._cacheClient, this._errorReporter)
    : super(SettingsState(locale: _prefs.getLocale()));

  final AppPreferences _prefs;
  final CacheClient _cacheClient;
  final AppErrorReporter _errorReporter;

  /// Changes and persists the app locale.
  ///
  /// Also clears weather cache so stale localized strings are refreshed.
  Future<void> changeLanguage(String languageCode) async {
    try {
      final success = await _prefs.setLocale(languageCode);
      if (!success) return;

      try {
        await _cacheClient.removeMatching('weather_');
      } catch (error, stackTrace) {
        _errorReporter.record(
          error,
          stackTrace,
          context: 'Clear localized weather cache',
        );
      }
      if (!isClosed) {
        emit(state.copyWith(locale: languageCode));
      }
    } catch (error, stackTrace) {
      _errorReporter.record(error, stackTrace, context: 'Persist app language');
    }
  }
}
