import 'package:flutter/material.dart';

/// Centralized weather-specific color constants.
///
/// These are decorative / weather-condition-specific colors that don't belong in
/// the general [ColorPalette] but should still be defined in one place rather
/// than scattered as raw hex literals across components.
///
/// For semantic app-level colors (text, background, card, error, etc.) always
/// use `Theme.of(context).colorPalette`.
class WeatherColors {
  const WeatherColors._();

  // ── Background Gradient Stops ──────────────────────────────────────────

  /// Dark slate used as gradient anchor in multiple weather conditions.
  static const Color slateDark = Color(0xFF0F172A);

  /// Deep blue for sunny/clear gradient.
  static const Color deepBlue = Color(0xFF1E3A8A);

  /// Sunset rust tone for sunny gradient.
  static const Color sunsetRust = Color(0xFF7C2D12);

  /// Very dark indigo-black for rainy gradient.
  static const Color stormBlack = Color(0xFF080C14);

  /// Deep indigo for rainy/storm gradient.
  static const Color deepIndigo = Color(0xFF1E1B4B);

  /// Midnight blue for rainy/storm gradient.
  static const Color midnightBlue = Color(0xFF172554);

  /// Slate grey for cloudy gradient.
  static const Color slateGrey = Color(0xFF334155);

  /// Blue-slate midtone for cloudy/default gradient.
  static const Color blueSlateMid = Color(0xFF1E293B);

  // ── Blob / Decorative Glow Colors ──────────────────────────────────────

  /// Reddish-pink warm blob for sunny conditions.
  static const Color sunnyBlobPink = Color(0xFFFF6B6B);

  /// Golden-orange blob for sunny conditions.
  static const Color sunnyBlobGold = Color(0xFFFF9F43);

  /// Deep rain blue blob.
  static const Color rainBlobBlue = Color(0xFF3B82F6);

  /// Storm indigo blob.
  static const Color rainBlobIndigo = Color(0xFF6366F1);

  /// Slate grey blob for cloudy conditions.
  static const Color cloudBlobGrey = Color(0xFF94A3B8);

  /// Soft white blob for cloudy conditions.
  static const Color cloudBlobWhite = Color(0xFFE2E8F0);

  // ── Weather Condition Icon Colors ──────────────────────────────────────

  /// Golden yellow for sunny weather icons.
  static const Color sunnyGold = Color(0xFFFFD700);

  /// Light blue for rainy weather icons.
  static const Color rainBlue = Color(0xFF60A5FA);

  /// Grey for cloudy weather icons.
  static const Color cloudGrey = Color(0xFF94A3B8);

  /// Soft white for night/moon weather icons.
  static const Color nightMoon = Color(0xFFE2E8F0);

  // ── Sun Arc Painter Colors ─────────────────────────────────────────────

  /// Sun orange used in the sun arc progress painter.
  static const Color sunOrange = Color(0xFFFF9F43);

  /// Sun gold used in arc progress highlight.
  static const Color sunGold = Color(0xFFFFD700);

  /// Warm amber for the sun dot mid-halo.
  static const Color sunDotAmber = Color(0xFFFFB74D);

  /// Orange for the sun dot halo glow.
  static const Color sunDotOrange = Color(0xFFFF9800);

  /// Yellow outline for the sun dot.
  static const Color sunDotYellow = Color(0xFFFFD54F);

  /// Warm cream tint for the daylight fill.
  static const Color daylightCream = Color(0xFFFFE082);

  // ── Insight Section Colors ─────────────────────────────────────────────

  /// UV icon amber color.
  static const Color uvAmber = Color(0xFFFFB300);

  /// Air quality green.
  static const Color airQualityGreen = Color(0xFF4CAF50);

  /// Clothing blue.
  static const Color clothingBlue = Color(0xFF64B5F6);

  /// Outdoor sport pink.
  static const Color sportPink = Color(0xFFE91E63);

  // ── Moon Phase Painter Colors ──────────────────────────────────────────

  /// Moon surface highlight used in the gradient sphere.
  static const Color moonHighlight = Color(0xFFE2E8F0);

  /// Moon surface mid-tone.
  static const Color moonMidTone = Color(0xFF94A3B8);

  /// Moon shadow (matches the slateDark background).
  static const Color moonShadow = Color(0xFF0F172A);
}
