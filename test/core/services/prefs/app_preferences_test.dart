import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:weather_app/core/services/prefs/app_preferences.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  group('AppPreferencesImpl', () {
    late AppPreferences preferences;

    setUp(() async {
      SharedPreferences.setMockInitialValues({});
      preferences = AppPreferencesImpl(await SharedPreferences.getInstance());
    });

    test('returns empty values when preferences have not been set', () {
      expect(preferences.getLocale(), isEmpty);
      expect(preferences.getLastCity(), isEmpty);
    });

    test('persists locale and last city', () async {
      expect(await preferences.setLocale('ar'), isTrue);
      expect(await preferences.setLastCity('Alexandria'), isTrue);

      expect(preferences.getLocale(), 'ar');
      expect(preferences.getLastCity(), 'Alexandria');
    });
  });
}
