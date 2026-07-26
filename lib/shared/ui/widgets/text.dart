import 'package:flutter/material.dart';
import 'package:weather_app/configurations/ui/theme/theme_data.dart';

/// {@template ui_text}
/// A widget that displays a string of text with a specific style.
/// {@endtemplate}
class UiText extends StatelessWidget {
  /// {@macro ui_text}
  const UiText(
    this.data, {
    this.color,
    this.style,
    this.textAlign,
    this.overflow,
    this.maxLines,
    TextStyle? Function(AppTypography)? styleBuilder,
    super.key,
  }) : _styleBuilder = styleBuilder;

  factory UiText.headlineBold(
    String? data, {
    Color? color,
    TextStyle? style,
    TextAlign? textAlign,
    TextOverflow? overflow,
    int? maxLines,
    Key? key,
  }) => UiText(
    data,
    color: color,
    style: style,
    textAlign: textAlign,
    overflow: overflow,
    maxLines: maxLines,
    styleBuilder: (t) => t.headlineBold,
    key: key,
  );

  factory UiText.headlineSemibold(
    String? data, {
    Color? color,
    TextStyle? style,
    TextAlign? textAlign,
    TextOverflow? overflow,
    int? maxLines,
    Key? key,
  }) => UiText(
    data,
    color: color,
    style: style,
    textAlign: textAlign,
    overflow: overflow,
    maxLines: maxLines,
    styleBuilder: (t) => t.headlineSemibold,
    key: key,
  );

  factory UiText.headlineMedium(
    String? data, {
    Color? color,
    TextStyle? style,
    TextAlign? textAlign,
    TextOverflow? overflow,
    int? maxLines,
    Key? key,
  }) => UiText(
    data,
    color: color,
    style: style,
    textAlign: textAlign,
    overflow: overflow,
    maxLines: maxLines,
    styleBuilder: (t) => t.headlineMedium,
    key: key,
  );

  factory UiText.headlineRegular(
    String? data, {
    Color? color,
    TextStyle? style,
    TextAlign? textAlign,
    TextOverflow? overflow,
    int? maxLines,
    Key? key,
  }) => UiText(
    data,
    color: color,
    style: style,
    textAlign: textAlign,
    overflow: overflow,
    maxLines: maxLines,
    styleBuilder: (t) => t.headlineRegular,
    key: key,
  );

  factory UiText.largeBold(
    String? data, {
    Color? color,
    TextStyle? style,
    TextAlign? textAlign,
    TextOverflow? overflow,
    int? maxLines,
    Key? key,
  }) => UiText(
    data,
    color: color,
    style: style,
    textAlign: textAlign,
    overflow: overflow,
    maxLines: maxLines,
    styleBuilder: (t) => t.largeBold,
    key: key,
  );

  factory UiText.largeSemibold(
    String? data, {
    Color? color,
    TextStyle? style,
    TextAlign? textAlign,
    TextOverflow? overflow,
    int? maxLines,
    Key? key,
  }) => UiText(
    data,
    color: color,
    style: style,
    textAlign: textAlign,
    overflow: overflow,
    maxLines: maxLines,
    styleBuilder: (t) => t.largeSemibold,
    key: key,
  );

  factory UiText.largeMedium(
    String? data, {
    Color? color,
    TextStyle? style,
    TextAlign? textAlign,
    TextOverflow? overflow,
    int? maxLines,
    Key? key,
  }) => UiText(
    data,
    color: color,
    style: style,
    textAlign: textAlign,
    overflow: overflow,
    maxLines: maxLines,
    styleBuilder: (t) => t.largeMedium,
    key: key,
  );

  factory UiText.largeRegular(
    String? data, {
    Color? color,
    TextStyle? style,
    TextAlign? textAlign,
    TextOverflow? overflow,
    int? maxLines,
    Key? key,
  }) => UiText(
    data,
    color: color,
    style: style,
    textAlign: textAlign,
    overflow: overflow,
    maxLines: maxLines,
    styleBuilder: (t) => t.largeRegular,
    key: key,
  );

  factory UiText.titleBold(
    String? data, {
    Color? color,
    TextStyle? style,
    TextAlign? textAlign,
    TextOverflow? overflow,
    int? maxLines,
    Key? key,
  }) => UiText(
    data,
    color: color,
    style: style,
    textAlign: textAlign,
    overflow: overflow,
    maxLines: maxLines,
    styleBuilder: (t) => t.titleBold,
    key: key,
  );

  factory UiText.titleSemibold(
    String? data, {
    Color? color,
    TextStyle? style,
    TextAlign? textAlign,
    TextOverflow? overflow,
    int? maxLines,
    Key? key,
  }) => UiText(
    data,
    color: color,
    style: style,
    textAlign: textAlign,
    overflow: overflow,
    maxLines: maxLines,
    styleBuilder: (t) => t.titleSemibold,
    key: key,
  );

  factory UiText.titleMedium(
    String? data, {
    Color? color,
    TextStyle? style,
    TextAlign? textAlign,
    TextOverflow? overflow,
    int? maxLines,
    Key? key,
  }) => UiText(
    data,
    color: color,
    style: style,
    textAlign: textAlign,
    overflow: overflow,
    maxLines: maxLines,
    styleBuilder: (t) => t.titleMedium,
    key: key,
  );

  factory UiText.titleRegular(
    String? data, {
    Color? color,
    TextStyle? style,
    TextAlign? textAlign,
    TextOverflow? overflow,
    int? maxLines,
    Key? key,
  }) => UiText(
    data,
    color: color,
    style: style,
    textAlign: textAlign,
    overflow: overflow,
    maxLines: maxLines,
    styleBuilder: (t) => t.titleRegular,
    key: key,
  );

  factory UiText.baseBold(
    String? data, {
    Color? color,
    TextStyle? style,
    TextAlign? textAlign,
    TextOverflow? overflow,
    int? maxLines,
    Key? key,
  }) => UiText(
    data,
    color: color,
    style: style,
    textAlign: textAlign,
    overflow: overflow,
    maxLines: maxLines,
    styleBuilder: (t) => t.baseBold,
    key: key,
  );

  factory UiText.baseSemibold(
    String? data, {
    Color? color,
    TextStyle? style,
    TextAlign? textAlign,
    TextOverflow? overflow,
    int? maxLines,
    Key? key,
  }) => UiText(
    data,
    color: color,
    style: style,
    textAlign: textAlign,
    overflow: overflow,
    maxLines: maxLines,
    styleBuilder: (t) => t.baseSemibold,
    key: key,
  );

  factory UiText.baseMedium(
    String? data, {
    Color? color,
    TextStyle? style,
    TextAlign? textAlign,
    TextOverflow? overflow,
    int? maxLines,
    Key? key,
  }) => UiText(
    data,
    color: color,
    style: style,
    textAlign: textAlign,
    overflow: overflow,
    maxLines: maxLines,
    styleBuilder: (t) => t.baseMedium,
    key: key,
  );

  factory UiText.baseRegular(
    String? data, {
    Color? color,
    TextStyle? style,
    TextAlign? textAlign,
    TextOverflow? overflow,
    int? maxLines,
    Key? key,
  }) => UiText(
    data,
    color: color,
    style: style,
    textAlign: textAlign,
    overflow: overflow,
    maxLines: maxLines,
    styleBuilder: (t) => t.baseRegular,
    key: key,
  );

  factory UiText.smallBold(
    String? data, {
    Color? color,
    TextStyle? style,
    TextAlign? textAlign,
    TextOverflow? overflow,
    int? maxLines,
    Key? key,
  }) => UiText(
    data,
    color: color,
    style: style,
    textAlign: textAlign,
    overflow: overflow,
    maxLines: maxLines,
    styleBuilder: (t) => t.smallBold,
    key: key,
  );

  factory UiText.smallSemibold(
    String? data, {
    Color? color,
    TextStyle? style,
    TextAlign? textAlign,
    TextOverflow? overflow,
    int? maxLines,
    Key? key,
  }) => UiText(
    data,
    color: color,
    style: style,
    textAlign: textAlign,
    overflow: overflow,
    maxLines: maxLines,
    styleBuilder: (t) => t.smallSemibold,
    key: key,
  );

  factory UiText.smallMedium(
    String? data, {
    Color? color,
    TextStyle? style,
    TextAlign? textAlign,
    TextOverflow? overflow,
    int? maxLines,
    Key? key,
  }) => UiText(
    data,
    color: color,
    style: style,
    textAlign: textAlign,
    overflow: overflow,
    maxLines: maxLines,
    styleBuilder: (t) => t.smallMedium,
    key: key,
  );

  factory UiText.smallRegular(
    String? data, {
    Color? color,
    TextStyle? style,
    TextAlign? textAlign,
    TextOverflow? overflow,
    int? maxLines,
    Key? key,
  }) => UiText(
    data,
    color: color,
    style: style,
    textAlign: textAlign,
    overflow: overflow,
    maxLines: maxLines,
    styleBuilder: (t) => t.smallRegular,
    key: key,
  );

  factory UiText.captionBold(
    String? data, {
    Color? color,
    TextStyle? style,
    TextAlign? textAlign,
    TextOverflow? overflow,
    int? maxLines,
    Key? key,
  }) => UiText(
    data,
    color: color,
    style: style,
    textAlign: textAlign,
    overflow: overflow,
    maxLines: maxLines,
    styleBuilder: (t) => t.captionBold,
    key: key,
  );

  factory UiText.captionSemibold(
    String? data, {
    Color? color,
    TextStyle? style,
    TextAlign? textAlign,
    TextOverflow? overflow,
    int? maxLines,
    Key? key,
  }) => UiText(
    data,
    color: color,
    style: style,
    textAlign: textAlign,
    overflow: overflow,
    maxLines: maxLines,
    styleBuilder: (t) => t.captionSemibold,
    key: key,
  );

  factory UiText.captionMedium(
    String? data, {
    Color? color,
    TextStyle? style,
    TextAlign? textAlign,
    TextOverflow? overflow,
    int? maxLines,
    Key? key,
  }) => UiText(
    data,
    color: color,
    style: style,
    textAlign: textAlign,
    overflow: overflow,
    maxLines: maxLines,
    styleBuilder: (t) => t.captionMedium,
    key: key,
  );

  factory UiText.captionRegular(
    String? data, {
    Color? color,
    TextStyle? style,
    TextAlign? textAlign,
    TextOverflow? overflow,
    int? maxLines,
    Key? key,
  }) => UiText(
    data,
    color: color,
    style: style,
    textAlign: textAlign,
    overflow: overflow,
    maxLines: maxLines,
    styleBuilder: (t) => t.captionRegular,
    key: key,
  );

  /// The text to display.
  final String? data;

  /// The style to apply to the text.
  final TextStyle? style;

  /// The alignment of the text.
  final TextAlign? textAlign;

  /// The overflow behavior of the text.
  final TextOverflow? overflow;

  /// The maximum number of lines to display.
  final int? maxLines;

  /// The color of the text.
  final Color? color;

  /// A function that builds the text style based on the typography.
  final TextStyle? Function(AppTypography)? _styleBuilder;

  @override
  Widget build(BuildContext context) {
    if (data == null) return const SizedBox.shrink();

    final typography = Theme.of(context).appTypography;

    final baseStyle = _styleBuilder?.call(typography) ?? typography.baseMedium;
    final mergedStyle = baseStyle.merge(style).copyWith(color: color);

    return Text(
      data!,
      textAlign: textAlign,
      overflow: overflow,
      maxLines: maxLines,
      style: mergedStyle,
    );
  }
}
