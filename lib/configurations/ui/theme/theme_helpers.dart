import 'package:flutter/material.dart';
import 'package:weather_app/configurations/ui/palette/dark_color_palette.dart';
import 'package:weather_app/configurations/ui/palette/light_color_palette.dart';
import 'package:weather_app/configurations/ui/theme/theme_data.dart';
import 'package:weather_app/configurations/ui/typography/typography_styles.dart';

final lightColorPalette = generatePaletteForBrightness(Brightness.light);
final darkColorPalette = generatePaletteForBrightness(Brightness.dark);

final AppTypography defaultTypography = AppTypography(
  headlineBold: TypographyStyles.headlineBold,
  headlineSemibold: TypographyStyles.headlineSemibold,
  headlineMedium: TypographyStyles.headlineMedium,
  headlineRegular: TypographyStyles.headlineRegular,
  largeBold: TypographyStyles.largeBold,
  largeSemibold: TypographyStyles.largeSemibold,
  largeMedium: TypographyStyles.largeMedium,
  largeRegular: TypographyStyles.largeRegular,
  titleBold: TypographyStyles.titleBold,
  titleSemibold: TypographyStyles.titleSemibold,
  titleMedium: TypographyStyles.titleMedium,
  titleRegular: TypographyStyles.titleRegular,
  baseBold: TypographyStyles.baseBold,
  baseSemibold: TypographyStyles.baseSemibold,
  baseMedium: TypographyStyles.baseMedium,
  baseRegular: TypographyStyles.baseRegular,
  smallBold: TypographyStyles.smallBold,
  smallSemibold: TypographyStyles.smallSemibold,
  smallMedium: TypographyStyles.smallMedium,
  smallRegular: TypographyStyles.smallRegular,
  captionBold: TypographyStyles.captionBold,
  captionSemibold: TypographyStyles.captionSemibold,
  captionMedium: TypographyStyles.captionMedium,
  captionRegular: TypographyStyles.captionRegular,
);

/// The font family used for the application.
const String appFontFamily = 'cairo';

/// Creates a [ThemeData] object based on the provided [ColorPalette] and [AppTypography].
///
/// The [brightness] parameter is used to determine the brightness of the theme.
ThemeData createThemeData({
  required ColorPalette palette,
  required AppTypography typography,
  required Brightness brightness,
  String fontFamily = appFontFamily,
}) => ThemeData(
  brightness: brightness,
  fontFamily: fontFamily,
  scaffoldBackgroundColor: palette.bg,
  colorScheme: ColorScheme.fromSeed(
    seedColor: palette.primary,
    brightness: brightness,
    surface: palette.bg,
    primary: palette.primary,
    onPrimary: palette.white,
    secondary: palette.active,
    onSecondary: palette.white,
    onSurface: palette.dark,
    error: palette.destructive,
    onError: palette.white,
  ),
  extensions: {palette, typography.applyFontFamily(fontFamily)},
);

ColorPalette generatePaletteForBrightness(Brightness brightness) {
  return switch (brightness) {
    Brightness.light => LightColorPalette(),
    Brightness.dark => DarkColorPalette(),
  };
}
