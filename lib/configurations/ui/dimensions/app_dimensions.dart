import 'package:flutter/material.dart';

/// Centralized layout spacing tokens.
class AppSpacing {
  const AppSpacing._();

  static const double xs = 4.0;
  static const double s = 8.0;
  static const double m = 12.0;
  static const double l = 16.0;
  static const double xl = 20.0;
  static const double xxl = 24.0;
  static const double xxxl = 32.0;
}

/// Centralized border radius tokens.
class AppBorderRadius {
  const AppBorderRadius._();

  static const double xxs = 4.0;
  static const double xs = 6.0;
  static const double s = 8.0;
  static const double m = 12.0;
  static const double l = 20.0;
  static const double xl = 100.0;

  static BorderRadius get circularXxs => BorderRadius.circular(xxs);
  static BorderRadius get circularXs => BorderRadius.circular(xs);
  static BorderRadius get circularS => BorderRadius.circular(s);
  static BorderRadius get circularM => BorderRadius.circular(m);
  static BorderRadius get circularL => BorderRadius.circular(l);
  static BorderRadius get circularXl => BorderRadius.circular(xl);
}

/// Centralized icon size tokens.
class AppIconSize {
  const AppIconSize._();

  static const double s = 16.0;
  static const double m = 20.0;
  static const double l = 24.0;
  static const double xl = 30.0;
  static const double xxl = 48.0;
  static const double xxxl = 64.0;
}

/// Centralized animation durations.
class AppDuration {
  const AppDuration._();

  static const Duration fast = Duration(milliseconds: 200);
  static const Duration normal = Duration(milliseconds: 250);
  static const Duration slow = Duration(milliseconds: 300);
}

/// Extensions on [BuildContext] to retrieve responsive screen dimensions
/// and keyboard status, preventing hardcoded viewport percentages in UI.
extension ResponsiveContext on BuildContext {
  /// The height of the screen.
  double get screenHeight => MediaQuery.sizeOf(this).height;

  /// The width of the screen.
  double get screenWidth => MediaQuery.sizeOf(this).width;

  /// Whether the keyboard is currently visible/open.
  bool get isKeyboardOpen => MediaQuery.viewInsetsOf(this).bottom > 0;

  /// Returns the height scaled by the given percentage [ratio] (0.0 to 1.0).
  double percentHeight(double ratio) => screenHeight * ratio;

  /// Returns the width scaled by the given percentage [ratio] (0.0 to 1.0).
  double percentWidth(double ratio) => screenWidth * ratio;

  /// The top padding (e.g. status bar height).
  double get paddingTop => MediaQuery.paddingOf(this).top;
}
