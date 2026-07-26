import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:weather_app/configurations/navigation/route_error_screen.dart';
import 'package:weather_app/features/settings/presentation/bloc/settings_cubit.dart';
import 'package:weather_app/features/settings/presentation/bloc/settings_state.dart';
import 'package:weather_app/features/settings/presentation/screens/settings_screen.dart';
import 'package:weather_app/features/weather/presentation/bloc/weather_bloc.dart';
import 'package:weather_app/features/weather/presentation/bloc/weather_event.dart';
import 'package:weather_app/features/weather/presentation/bloc/weather_state.dart';
import 'package:weather_app/features/weather/presentation/screens/weather_screen.dart';

import '../../widget_test_helper.dart';

class MockSettingsCubit extends MockCubit<SettingsState>
    implements SettingsCubit {}

class MockWeatherBloc extends MockBloc<WeatherEvent, WeatherState>
    implements WeatherBloc {}

void main() {
  late MockSettingsCubit settingsCubit;
  late MockWeatherBloc weatherBloc;

  setUpAll(() {
    registerFallbackValue(const WeatherFetchRequested('fallback'));
  });

  setUp(() {
    settingsCubit = MockSettingsCubit();
    weatherBloc = MockWeatherBloc();
    when(
      () => settingsCubit.state,
    ).thenReturn(const SettingsState(locale: 'en'));
    when(() => weatherBloc.state).thenReturn(const WeatherState());
  });

  testWidgets('RouteErrorScreen renders localized fallback in English', (
    tester,
  ) async {
    await tester.pumpWidget(WidgetTestApp(child: const RouteErrorScreen()));

    expect(find.text('Page not found'), findsOneWidget);
  });

  testWidgets('RouteErrorScreen renders right-to-left Arabic copy', (
    tester,
  ) async {
    await tester.pumpWidget(
      WidgetTestApp(
        locale: const Locale('ar'),
        child: const RouteErrorScreen(),
      ),
    );

    expect(find.text('الصفحة غير موجودة'), findsOneWidget);
    expect(
      tester
          .widget<Directionality>(find.byType(Directionality).last)
          .textDirection,
      TextDirection.rtl,
    );
  });

  testWidgets('SettingsScreen renders attribution and changes language', (
    tester,
  ) async {
    when(() => settingsCubit.changeLanguage('ar')).thenAnswer((_) async {});
    await tester.pumpWidget(
      WidgetTestApp(
        child: BlocProvider<SettingsCubit>.value(
          value: settingsCubit,
          child: const SettingsScreen(),
        ),
      ),
    );

    expect(find.text('Settings'), findsOneWidget);
    expect(
      find.text('Weather data provided by WeatherAPI.com'),
      findsOneWidget,
    );
    expect(
      find.text(
        'Forecasts are informational and may differ from actual conditions.',
      ),
      findsOneWidget,
    );

    await tester.tap(find.text('العربية'));
    await tester.pump();
    verify(() => settingsCubit.changeLanguage('ar')).called(1);
  });

  testWidgets('WeatherScreenContent opens search and submits a city', (
    tester,
  ) async {
    await tester.pumpWidget(
      WidgetTestApp(
        child: MultiBlocProvider(
          providers: [
            BlocProvider<SettingsCubit>.value(value: settingsCubit),
            BlocProvider<WeatherBloc>.value(value: weatherBloc),
          ],
          child: const WeatherScreenContent(),
        ),
      ),
    );

    expect(find.text('Weather'), findsOneWidget);
    expect(find.text('Egypt'), findsOneWidget);

    await tester.tap(find.byTooltip('Search'));
    await tester.pump();
    expect(find.byType(TextField), findsOneWidget);

    await tester.enterText(find.byType(TextField), '  London  ');
    await tester.testTextInput.receiveAction(TextInputAction.search);
    await tester.pump();

    verify(
      () => weatherBloc.add(const WeatherFetchRequested('London')),
    ).called(1);
  });

  testWidgets('WeatherScreen renders with its route-scoped providers', (
    tester,
  ) async {
    await tester.pumpWidget(
      WidgetTestApp(
        child: MultiBlocProvider(
          providers: [
            BlocProvider<SettingsCubit>.value(value: settingsCubit),
            BlocProvider<WeatherBloc>.value(value: weatherBloc),
          ],
          child: const WeatherScreen(),
        ),
      ),
    );

    expect(find.byType(WeatherScreenContent), findsOneWidget);
  });
}
