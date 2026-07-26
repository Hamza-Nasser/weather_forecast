import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:weather_app/shared/ui/widgets/app_bar.dart';
import 'package:weather_app/shared/ui/widgets/button.dart';
import 'package:weather_app/shared/ui/widgets/circular_loading.dart';
import 'package:weather_app/shared/ui/widgets/empty_state.dart';
import 'package:weather_app/shared/ui/widgets/error_state.dart';
import 'package:weather_app/shared/ui/widgets/glass_surface.dart';
import 'package:weather_app/shared/ui/widgets/network_image/components/ui_network_image_error_fallback.dart';
import 'package:weather_app/shared/ui/widgets/network_image/components/ui_network_image_skeleton_placeholder.dart';
import 'package:weather_app/shared/ui/widgets/network_image/network_image.dart';
import 'package:weather_app/shared/ui/widgets/surface.dart';
import 'package:weather_app/shared/ui/widgets/text.dart';

import '../../../widget_test_helper.dart';

void main() {
  group('shared UI widgets', () {
    testWidgets('UiText renders design-system text', (tester) async {
      await tester.pumpWidget(
        WidgetTestApp(child: Scaffold(body: UiText.titleBold('Forecast'))),
      );

      expect(find.text('Forecast'), findsOneWidget);
      expect(
        tester.widget<Text>(find.text('Forecast')).style?.fontWeight,
        FontWeight.w700,
      );
    });

    testWidgets('UiButton renders, invokes callback, and shows loading state', (
      tester,
    ) async {
      var taps = 0;
      await tester.pumpWidget(
        WidgetTestApp(
          child: Scaffold(
            body: Column(
              children: [
                UiButton(
                  label: 'Load',
                  icon: Icons.cloud,
                  onPressed: () => taps++,
                ),
                const UiButton(label: 'Loading', isLoading: true),
              ],
            ),
          ),
        ),
      );

      await tester.tap(find.text('Load'));
      await tester.pump();

      expect(taps, 1);
      expect(find.byType(CircularProgressIndicator), findsOneWidget);
      expect(
        tester
            .widgetList<ElevatedButton>(find.byType(ElevatedButton))
            .last
            .onPressed,
        isNull,
      );
    });

    testWidgets('UiAppBar renders title, action, and back affordance', (
      tester,
    ) async {
      await tester.pumpWidget(
        WidgetTestApp(
          child: Scaffold(
            appBar: UiAppBar(
              title: 'Weather',
              actions: [
                IconButton(onPressed: () {}, icon: const Icon(Icons.settings)),
              ],
            ),
          ),
        ),
      );

      expect(find.text('Weather'), findsOneWidget);
      expect(find.byType(BackButton), findsOneWidget);
      expect(find.byIcon(Icons.settings), findsOneWidget);
    });

    testWidgets('GlassSurface renders and handles taps', (tester) async {
      var tapped = false;
      await tester.pumpWidget(
        WidgetTestApp(
          child: Scaffold(
            body: GlassSurface(
              onTap: () => tapped = true,
              child: const UiText('Glass'),
            ),
          ),
        ),
      );

      await tester.tap(find.text('Glass'));
      expect(tapped, isTrue);
      expect(find.byType(BackdropFilter), findsOneWidget);
    });

    testWidgets('UiSurface filled and bordered variants handle content', (
      tester,
    ) async {
      var taps = 0;
      await tester.pumpWidget(
        WidgetTestApp(
          child: Scaffold(
            body: Column(
              children: [
                UiSurface(onTap: () => taps++, child: const UiText('Filled')),
                const UiSurface.bordered(child: UiText('Bordered')),
              ],
            ),
          ),
        ),
      );

      await tester.tap(find.text('Filled'));
      expect(taps, 1);
      expect(find.text('Bordered'), findsOneWidget);
    });

    testWidgets('CircularLoading honors its configured size', (tester) async {
      await tester.pumpWidget(
        WidgetTestApp(
          child: const Scaffold(
            body: CircularLoading(size: 32, strokeWidth: 2),
          ),
        ),
      );

      expect(find.byType(CircularProgressIndicator), findsOneWidget);
      expect(tester.getSize(find.byType(CircularLoading)), const Size(32, 32));
    });

    testWidgets('EmptyState renders message and action', (tester) async {
      await tester.pumpWidget(
        WidgetTestApp(
          child: const Scaffold(
            body: EmptyState(
              message: 'Nothing here',
              action: UiButton(label: 'Refresh'),
            ),
          ),
        ),
      );

      expect(find.text('Nothing here'), findsOneWidget);
      expect(find.text('Refresh'), findsOneWidget);
      expect(find.byIcon(Icons.cloud_off_outlined), findsOneWidget);
    });

    testWidgets('ErrorState localizes and invokes retry', (tester) async {
      var retries = 0;
      await tester.pumpWidget(
        WidgetTestApp(
          child: Scaffold(
            body: ErrorState(message: 'Offline', onRetry: () => retries++),
          ),
        ),
      );

      expect(find.text('Something went wrong'), findsOneWidget);
      expect(find.text('Offline'), findsOneWidget);
      await tester.tap(find.text('Retry'));
      expect(retries, 1);
    });

    testWidgets('UiNetworkImage uses fallback for an invalid URL', (
      tester,
    ) async {
      await tester.pumpWidget(
        WidgetTestApp(
          child: const Scaffold(
            body: UiNetworkImage(url: null, width: 48, height: 48),
          ),
        ),
      );

      expect(find.byType(UiNetworkImageErrorFallback), findsOneWidget);
      expect(find.byIcon(Icons.image_outlined), findsOneWidget);
    });

    testWidgets('network image placeholder and fallback render directly', (
      tester,
    ) async {
      await tester.pumpWidget(
        WidgetTestApp(
          child: const Scaffold(
            body: Row(
              children: [
                UiNetworkImageSkeletonPlaceholder(
                  width: 40,
                  height: 40,
                  borderRadius: BorderRadius.zero,
                ),
                UiNetworkImageErrorFallback(
                  width: 40,
                  height: 40,
                  borderRadius: BorderRadius.zero,
                ),
              ],
            ),
          ),
        ),
      );

      expect(find.byType(UiNetworkImageSkeletonPlaceholder), findsOneWidget);
      expect(find.byType(UiNetworkImageErrorFallback), findsOneWidget);
    });
  });
}
