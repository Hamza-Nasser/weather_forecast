import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:weather_app/core/cache/cache_client.dart';
import 'package:weather_app/core/services/prefs/app_preferences.dart';
import 'package:weather_app/core/services/app_error_reporter.dart';
import 'package:weather_app/features/settings/presentation/bloc/settings_cubit.dart';
import 'package:weather_app/features/settings/presentation/bloc/settings_state.dart';

class MockAppPreferences extends Mock implements AppPreferences {}

class MockCacheClient extends Mock implements CacheClient {}

class MockAppErrorReporter extends Mock implements AppErrorReporter {}

void main() {
  group('SettingsCubit', () {
    late AppPreferences mockPrefs;
    late CacheClient mockCacheClient;
    late AppErrorReporter mockErrorReporter;

    setUp(() {
      mockPrefs = MockAppPreferences();
      mockCacheClient = MockCacheClient();
      mockErrorReporter = MockAppErrorReporter();
    });

    test('initial state loads the locale from AppPreferences', () {
      when(() => mockPrefs.getLocale()).thenReturn('en');

      final cubit = SettingsCubit(
        mockPrefs,
        mockCacheClient,
        mockErrorReporter,
      );

      expect(cubit.state, const SettingsState(locale: 'en'));
      verify(() => mockPrefs.getLocale()).called(1);
    });

    blocTest<SettingsCubit, SettingsState>(
      'changeLanguage emits state with new locale, persists it, and clears weather cache',
      setUp: () {
        when(() => mockPrefs.getLocale()).thenReturn('en');
        when(() => mockPrefs.setLocale('ar')).thenAnswer((_) async => true);
        when(
          () => mockCacheClient.removeMatching('weather_'),
        ).thenAnswer((_) async {});
      },
      build: () => SettingsCubit(mockPrefs, mockCacheClient, mockErrorReporter),
      act: (cubit) => cubit.changeLanguage('ar'),
      expect: () => [const SettingsState(locale: 'ar')],
      verify: (_) {
        verify(() => mockPrefs.setLocale('ar')).called(1);
        verify(() => mockCacheClient.removeMatching('weather_')).called(1);
      },
    );

    blocTest<SettingsCubit, SettingsState>(
      'changeLanguage does not emit state or clear cache if persisting fails',
      setUp: () {
        when(() => mockPrefs.getLocale()).thenReturn('en');
        when(() => mockPrefs.setLocale('ar')).thenAnswer((_) async => false);
      },
      build: () => SettingsCubit(mockPrefs, mockCacheClient, mockErrorReporter),
      act: (cubit) => cubit.changeLanguage('ar'),
      expect: () => <SettingsState>[],
      verify: (_) {
        verify(() => mockPrefs.setLocale('ar')).called(1);
        verifyNever(() => mockCacheClient.removeMatching(any()));
      },
    );
  });
}
