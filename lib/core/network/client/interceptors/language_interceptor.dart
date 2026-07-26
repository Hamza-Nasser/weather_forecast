import 'package:dio/dio.dart';
import 'package:weather_app/core/services/prefs/app_preferences.dart';

/// Dio interceptor that appends the user's preferred language to every request.
///
/// Reads the stored locale from [AppPreferences] and adds it as the `lang`
/// query parameter so all API responses respect the app locale.
class LanguageInterceptor extends Interceptor {
  final AppPreferences _prefs;

  const LanguageInterceptor(this._prefs);

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    final lang = _prefs.getLocale();
    if (lang.isNotEmpty) {
      options.queryParameters['lang'] = lang;
    }
    handler.next(options);
  }
}
