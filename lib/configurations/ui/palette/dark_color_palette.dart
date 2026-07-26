import 'package:flutter/material.dart';
import 'package:weather_app/configurations/ui/theme/theme_data.dart';

/// Dark color palette for the weather app.
///
/// Inverts the light palette while maintaining weather brand identity.
final class DarkColorPalette extends ColorPalette {
  DarkColorPalette({
    super.bg = const Color(0xFF0F172A),
    super.white = const Color(0xFFFFFFFF),
    super.active = const Color(0xFF34C759),
    super.card = const Color(0xFF1E293B),
    super.dark = const Color(0xFFF8FAFC),
    super.primary = const Color(0xFF42A5F5),
    super.dark07 = const Color(0xFFCBD5E1),
    super.dark06 = const Color(0xFF94A3B8),
    super.dark05 = const Color(0xFF64748B),
    super.dark04 = const Color(0xFF475569),
    super.dark03 = const Color(0xFF334155),
    super.dark02 = const Color(0xFF1E293B),
    super.dark01 = const Color(0xFF0F172A),
    super.destructive = const Color(0xFFFF6B6B),
    super.ring = const Color(0xFF42A5F5),
    super.success = const Color(0xFF22C55E),
    super.warning = const Color(0xFFFACC15),
    super.error = const Color(0xFFEF4444),
    super.info = const Color(0xFF38BDF8),
    super.pending = const Color(0xFFFB923C),
  });
}
