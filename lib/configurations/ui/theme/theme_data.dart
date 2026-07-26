import 'package:flutter/material.dart';

/// An extension for theme to provide a color palette in context.
///
/// Uses [ThemeExtension] to attach the app's color system to Flutter's [ThemeData].
/// Access via `Theme.of(context).colorPalette`.
class ColorPalette extends ThemeExtension<ColorPalette> {
  const ColorPalette({
    required this.bg,
    required this.white,
    required this.active,
    required this.card,
    required this.dark,
    required this.primary,
    required this.dark07,
    required this.dark06,
    required this.dark05,
    required this.dark04,
    required this.dark03,
    required this.dark02,
    required this.dark01,
    required this.destructive,
    required this.ring,
    required this.success,
    required this.warning,
    required this.error,
    required this.info,
    required this.pending,
  });

  final Color bg;
  final Color white;
  final Color active;
  final Color card;
  final Color dark;
  final Color primary;
  final Color dark07;
  final Color dark06;
  final Color dark05;
  final Color dark04;
  final Color dark03;
  final Color dark02;
  final Color dark01;
  final Color destructive;
  final Color ring;
  final Color success;
  final Color warning;
  final Color error;
  final Color info;
  final Color pending;

  @override
  ThemeExtension<ColorPalette> copyWith({
    Color? bg,
    Color? white,
    Color? active,
    Color? card,
    Color? dark,
    Color? primary,
    Color? dark07,
    Color? dark06,
    Color? dark05,
    Color? dark04,
    Color? dark03,
    Color? dark02,
    Color? dark01,
    Color? destructive,
    Color? ring,
    Color? success,
    Color? warning,
    Color? error,
    Color? info,
    Color? pending,
  }) => ColorPalette(
    bg: bg ?? this.bg,
    white: white ?? this.white,
    active: active ?? this.active,
    card: card ?? this.card,
    dark: dark ?? this.dark,
    primary: primary ?? this.primary,
    dark07: dark07 ?? this.dark07,
    dark06: dark06 ?? this.dark06,
    dark05: dark05 ?? this.dark05,
    dark04: dark04 ?? this.dark04,
    dark03: dark03 ?? this.dark03,
    dark02: dark02 ?? this.dark02,
    dark01: dark01 ?? this.dark01,
    destructive: destructive ?? this.destructive,
    ring: ring ?? this.ring,
    success: success ?? this.success,
    warning: warning ?? this.warning,
    error: error ?? this.error,
    info: info ?? this.info,
    pending: pending ?? this.pending,
  );

  @override
  ThemeExtension<ColorPalette> lerp(
    covariant ThemeExtension<ColorPalette>? other,
    double t,
  ) {
    if (other == null || other is! ColorPalette) {
      return this;
    }

    return ColorPalette(
      bg: Color.lerp(bg, other.bg, t)!,
      white: Color.lerp(white, other.white, t)!,
      active: Color.lerp(active, other.active, t)!,
      card: Color.lerp(card, other.card, t)!,
      dark: Color.lerp(dark, other.dark, t)!,
      primary: Color.lerp(primary, other.primary, t)!,
      dark07: Color.lerp(dark07, other.dark07, t)!,
      dark06: Color.lerp(dark06, other.dark06, t)!,
      dark05: Color.lerp(dark05, other.dark05, t)!,
      dark04: Color.lerp(dark04, other.dark04, t)!,
      dark03: Color.lerp(dark03, other.dark03, t)!,
      dark02: Color.lerp(dark02, other.dark02, t)!,
      dark01: Color.lerp(dark01, other.dark01, t)!,
      destructive: Color.lerp(destructive, other.destructive, t)!,
      ring: Color.lerp(ring, other.ring, t)!,
      success: Color.lerp(success, other.success, t)!,
      warning: Color.lerp(warning, other.warning, t)!,
      error: Color.lerp(error, other.error, t)!,
      info: Color.lerp(info, other.info, t)!,
      pending: Color.lerp(pending, other.pending, t)!,
    );
  }

  Map<String, Color> toMap() => {
    'Background': bg,
    'White': white,
    'Active': active,
    'Card': card,
    'Dark': dark,
    'Primary': primary,
    'Dark 07': dark07,
    'Dark 06': dark06,
    'Dark 05': dark05,
    'Dark 04': dark04,
    'Dark 03': dark03,
    'Dark 02': dark02,
    'Dark 01': dark01,
    'Destructive': destructive,
    'Ring': ring,
    'Success': success,
    'Warning': warning,
    'Error': error,
    'Info': info,
    'Pending': pending,
  };
}

/// An extension for theme to provide typography in context.
///
/// Access via `Theme.of(context).appTypography`.
class AppTypography extends ThemeExtension<AppTypography> {
  const AppTypography({
    required this.headlineBold,
    required this.headlineSemibold,
    required this.headlineMedium,
    required this.headlineRegular,
    required this.largeBold,
    required this.largeSemibold,
    required this.largeMedium,
    required this.largeRegular,
    required this.titleBold,
    required this.titleSemibold,
    required this.titleMedium,
    required this.titleRegular,
    required this.baseBold,
    required this.baseSemibold,
    required this.baseMedium,
    required this.baseRegular,
    required this.smallBold,
    required this.smallSemibold,
    required this.smallMedium,
    required this.smallRegular,
    required this.captionBold,
    required this.captionSemibold,
    required this.captionMedium,
    required this.captionRegular,
  });

  final TextStyle headlineBold;
  final TextStyle headlineSemibold;
  final TextStyle headlineMedium;
  final TextStyle headlineRegular;

  final TextStyle largeBold;
  final TextStyle largeSemibold;
  final TextStyle largeMedium;
  final TextStyle largeRegular;

  final TextStyle titleBold;
  final TextStyle titleSemibold;
  final TextStyle titleMedium;
  final TextStyle titleRegular;

  final TextStyle baseBold;
  final TextStyle baseSemibold;
  final TextStyle baseMedium;
  final TextStyle baseRegular;

  final TextStyle smallBold;
  final TextStyle smallSemibold;
  final TextStyle smallMedium;
  final TextStyle smallRegular;

  final TextStyle captionBold;
  final TextStyle captionSemibold;
  final TextStyle captionMedium;
  final TextStyle captionRegular;

  @override
  ThemeExtension<AppTypography> copyWith({
    TextStyle? headlineBold,
    TextStyle? headlineSemibold,
    TextStyle? headlineMedium,
    TextStyle? headlineRegular,
    TextStyle? largeBold,
    TextStyle? largeSemibold,
    TextStyle? largeMedium,
    TextStyle? largeRegular,
    TextStyle? titleBold,
    TextStyle? titleSemibold,
    TextStyle? titleMedium,
    TextStyle? titleRegular,
    TextStyle? baseBold,
    TextStyle? baseSemibold,
    TextStyle? baseMedium,
    TextStyle? baseRegular,
    TextStyle? smallBold,
    TextStyle? smallSemibold,
    TextStyle? smallMedium,
    TextStyle? smallRegular,
    TextStyle? captionBold,
    TextStyle? captionSemibold,
    TextStyle? captionMedium,
    TextStyle? captionRegular,
  }) => AppTypography(
    headlineBold: headlineBold ?? this.headlineBold,
    headlineSemibold: headlineSemibold ?? this.headlineSemibold,
    headlineMedium: headlineMedium ?? this.headlineMedium,
    headlineRegular: headlineRegular ?? this.headlineRegular,
    largeBold: largeBold ?? this.largeBold,
    largeSemibold: largeSemibold ?? this.largeSemibold,
    largeMedium: largeMedium ?? this.largeMedium,
    largeRegular: largeRegular ?? this.largeRegular,
    titleBold: titleBold ?? this.titleBold,
    titleSemibold: titleSemibold ?? this.titleSemibold,
    titleMedium: titleMedium ?? this.titleMedium,
    titleRegular: titleRegular ?? this.titleRegular,
    baseBold: baseBold ?? this.baseBold,
    baseSemibold: baseSemibold ?? this.baseSemibold,
    baseMedium: baseMedium ?? this.baseMedium,
    baseRegular: baseRegular ?? this.baseRegular,
    smallBold: smallBold ?? this.smallBold,
    smallSemibold: smallSemibold ?? this.smallSemibold,
    smallMedium: smallMedium ?? this.smallMedium,
    smallRegular: smallRegular ?? this.smallRegular,
    captionBold: captionBold ?? this.captionBold,
    captionSemibold: captionSemibold ?? this.captionSemibold,
    captionMedium: captionMedium ?? this.captionMedium,
    captionRegular: captionRegular ?? this.captionRegular,
  );

  @override
  ThemeExtension<AppTypography> lerp(
    covariant ThemeExtension<AppTypography>? other,
    double t,
  ) {
    if (other == null || other is! AppTypography) {
      return this;
    }

    return AppTypography(
      headlineBold: TextStyle.lerp(headlineBold, other.headlineBold, t)!,
      headlineSemibold: TextStyle.lerp(
        headlineSemibold,
        other.headlineSemibold,
        t,
      )!,
      headlineMedium: TextStyle.lerp(headlineMedium, other.headlineMedium, t)!,
      headlineRegular: TextStyle.lerp(
        headlineRegular,
        other.headlineRegular,
        t,
      )!,
      largeBold: TextStyle.lerp(largeBold, other.largeBold, t)!,
      largeSemibold: TextStyle.lerp(largeSemibold, other.largeSemibold, t)!,
      largeMedium: TextStyle.lerp(largeMedium, other.largeMedium, t)!,
      largeRegular: TextStyle.lerp(largeRegular, other.largeRegular, t)!,
      titleBold: TextStyle.lerp(titleBold, other.titleBold, t)!,
      titleSemibold: TextStyle.lerp(titleSemibold, other.titleSemibold, t)!,
      titleMedium: TextStyle.lerp(titleMedium, other.titleMedium, t)!,
      titleRegular: TextStyle.lerp(titleRegular, other.titleRegular, t)!,
      baseBold: TextStyle.lerp(baseBold, other.baseBold, t)!,
      baseSemibold: TextStyle.lerp(baseSemibold, other.baseSemibold, t)!,
      baseMedium: TextStyle.lerp(baseMedium, other.baseMedium, t)!,
      baseRegular: TextStyle.lerp(baseRegular, other.baseRegular, t)!,
      smallBold: TextStyle.lerp(smallBold, other.smallBold, t)!,
      smallSemibold: TextStyle.lerp(smallSemibold, other.smallSemibold, t)!,
      smallMedium: TextStyle.lerp(smallMedium, other.smallMedium, t)!,
      smallRegular: TextStyle.lerp(smallRegular, other.smallRegular, t)!,
      captionBold: TextStyle.lerp(captionBold, other.captionBold, t)!,
      captionSemibold: TextStyle.lerp(
        captionSemibold,
        other.captionSemibold,
        t,
      )!,
      captionMedium: TextStyle.lerp(captionMedium, other.captionMedium, t)!,
      captionRegular: TextStyle.lerp(captionRegular, other.captionRegular, t)!,
    );
  }

  /// Returns a new [AppTypography] with the specified [fontFamily] applied to all styles.
  AppTypography applyFontFamily(String fontFamily) {
    return AppTypography(
      headlineBold: headlineBold.copyWith(fontFamily: fontFamily),
      headlineSemibold: headlineSemibold.copyWith(fontFamily: fontFamily),
      headlineMedium: headlineMedium.copyWith(fontFamily: fontFamily),
      headlineRegular: headlineRegular.copyWith(fontFamily: fontFamily),
      largeBold: largeBold.copyWith(fontFamily: fontFamily),
      largeSemibold: largeSemibold.copyWith(fontFamily: fontFamily),
      largeMedium: largeMedium.copyWith(fontFamily: fontFamily),
      largeRegular: largeRegular.copyWith(fontFamily: fontFamily),
      titleBold: titleBold.copyWith(fontFamily: fontFamily),
      titleSemibold: titleSemibold.copyWith(fontFamily: fontFamily),
      titleMedium: titleMedium.copyWith(fontFamily: fontFamily),
      titleRegular: titleRegular.copyWith(fontFamily: fontFamily),
      baseBold: baseBold.copyWith(fontFamily: fontFamily),
      baseSemibold: baseSemibold.copyWith(fontFamily: fontFamily),
      baseMedium: baseMedium.copyWith(fontFamily: fontFamily),
      baseRegular: baseRegular.copyWith(fontFamily: fontFamily),
      smallBold: smallBold.copyWith(fontFamily: fontFamily),
      smallSemibold: smallSemibold.copyWith(fontFamily: fontFamily),
      smallMedium: smallMedium.copyWith(fontFamily: fontFamily),
      smallRegular: smallRegular.copyWith(fontFamily: fontFamily),
      captionBold: captionBold.copyWith(fontFamily: fontFamily),
      captionSemibold: captionSemibold.copyWith(fontFamily: fontFamily),
      captionMedium: captionMedium.copyWith(fontFamily: fontFamily),
      captionRegular: captionRegular.copyWith(fontFamily: fontFamily),
    );
  }
}

/// Convenience extensions on [ThemeData] to access color palette and typography.
extension ThemeDataExtensions on ThemeData {
  /// The color palette set for the app.
  ColorPalette get colorPalette =>
      extension<ColorPalette>() ??
      (throw StateError('ColorPalette is missing from ThemeData.extensions'));

  /// The typography set for the app.
  AppTypography get appTypography =>
      extension<AppTypography>() ??
      (throw StateError('AppTypography is missing from ThemeData.extensions'));
}
