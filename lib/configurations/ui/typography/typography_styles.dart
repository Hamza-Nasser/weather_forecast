import 'package:flutter/material.dart';

/// Typography styles for the application.
///
/// Provides a consistent set of text styles organized by size categories:
/// - Headline (24px)
/// - Large (20px)
/// - Title (18px)
/// - Base (16px)
/// - Small (14px)
/// - Caption (12px)
///
/// Each category has four weight variants:
/// - Regular (w400)
/// - Medium (w500)
/// - Semibold (w600)
/// - Bold (w700)
final class TypographyStyles {
  TypographyStyles._();

  static const TextStyle headlineBold = TextStyle(
    fontSize: 24,
    fontWeight: FontWeight.w700,
  );

  static const TextStyle headlineSemibold = TextStyle(
    fontSize: 24,
    fontWeight: FontWeight.w600,
  );

  static const TextStyle headlineMedium = TextStyle(
    fontSize: 24,
    fontWeight: FontWeight.w500,
  );

  static const TextStyle headlineRegular = TextStyle(
    fontSize: 24,
    fontWeight: FontWeight.w400,
  );

  static const TextStyle largeBold = TextStyle(
    fontSize: 20,
    fontWeight: FontWeight.w700,
  );

  static const TextStyle largeSemibold = TextStyle(
    fontSize: 20,
    fontWeight: FontWeight.w600,
  );

  static const TextStyle largeMedium = TextStyle(
    fontSize: 20,
    fontWeight: FontWeight.w500,
  );

  static const TextStyle largeRegular = TextStyle(
    fontSize: 20,
    fontWeight: FontWeight.w400,
  );

  static const TextStyle titleBold = TextStyle(
    fontSize: 18,
    fontWeight: FontWeight.w700,
  );

  static const TextStyle titleSemibold = TextStyle(
    fontSize: 18,
    fontWeight: FontWeight.w600,
  );

  static const TextStyle titleMedium = TextStyle(
    fontSize: 18,
    fontWeight: FontWeight.w500,
  );

  static const TextStyle titleRegular = TextStyle(
    fontSize: 18,
    fontWeight: FontWeight.w400,
  );

  static const TextStyle baseBold = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w700,
  );

  static const TextStyle baseSemibold = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w600,
  );

  static const TextStyle baseMedium = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w500,
  );

  static const TextStyle baseRegular = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w400,
  );

  static const TextStyle smallBold = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w700,
  );

  static const TextStyle smallSemibold = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w600,
  );

  static const TextStyle smallMedium = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w500,
  );

  static const TextStyle smallRegular = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w400,
  );

  static const TextStyle captionBold = TextStyle(
    fontSize: 12,
    fontWeight: FontWeight.w700,
  );

  static const TextStyle captionSemibold = TextStyle(
    fontSize: 12,
    fontWeight: FontWeight.w600,
  );

  static const TextStyle captionMedium = TextStyle(
    fontSize: 12,
    fontWeight: FontWeight.w500,
  );

  static const TextStyle captionRegular = TextStyle(
    fontSize: 12,
    fontWeight: FontWeight.w400,
  );
}
