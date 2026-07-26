import 'package:flutter/material.dart';
import 'package:weather_app/configurations/ui/theme/theme_data.dart';

/// Light color palette using a weather-themed sky blue primary.
///
/// Primary: Sky blue (0xFF2196F3)
/// Grey scale: Zinc-based neutral system.
final class LightColorPalette extends ColorPalette {
  LightColorPalette({
    super.bg = const Color(0xFFF8FAFC),
    super.white = const Color(0xFFFFFFFF),
    super.active = const Color(0xFF34C759),
    super.card = const Color(0xFFF1F5F9),
    super.dark = const Color(0xFF0F172A),
    super.primary = const Color(0xFF2196F3),
    super.dark07 = const Color(0xFF334155),
    super.dark06 = const Color(0xFF475569),
    super.dark05 = const Color(0xFF64748B),
    super.dark04 = const Color(0xFF94A3B8),
    super.dark03 = const Color(0xFFCBD5E1),
    super.dark02 = const Color(0xFFE2E8F0),
    super.dark01 = const Color(0xFFF1F5F9),
    super.destructive = const Color(0xFFD92D20),
    super.ring = const Color(0xFF2196F3),
    super.success = const Color(0xFF16A34A),
    super.warning = const Color(0xFFEAB308),
    super.error = const Color(0xFFDC2626),
    super.info = const Color(0xFF0EA5E9),
    super.pending = const Color(0xFFF97316),
  });
}
