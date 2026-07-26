import 'package:flutter/material.dart';
import 'package:weather_app/configurations/ui/dimensions/app_dimensions.dart';
import 'package:weather_app/configurations/ui/theme/theme_data.dart';

enum SurfaceVariant { filled, bordered }

class UiSurface extends StatelessWidget {
  final Widget? child;
  final EdgeInsetsGeometry? padding;
  final EdgeInsetsGeometry? margin;
  final Color? color;
  final BorderRadiusGeometry borderRadius;
  final double? width;
  final BoxBorder? border;
  final VoidCallback? onTap;
  final SurfaceVariant variant;

  const UiSurface({
    super.key,
    this.child,
    this.padding,
    this.margin,
    this.color,
    this.borderRadius = const BorderRadius.all(
      Radius.circular(AppBorderRadius.s),
    ),
    this.width,
    this.border,
    this.onTap,
  }) : variant = SurfaceVariant.filled;

  const UiSurface.bordered({
    super.key,
    this.child,
    this.padding,
    this.margin,
    this.color,
    this.borderRadius = const BorderRadius.all(
      Radius.circular(AppBorderRadius.s),
    ),
    this.width,
    this.border,
    this.onTap,
  }) : variant = SurfaceVariant.bordered;

  @override
  Widget build(BuildContext context) {
    final palette = Theme.of(context).colorPalette;
    final resolvedColor = color ?? palette.card;
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding:
            padding ?? const EdgeInsets.symmetric(horizontal: 14, vertical: 18),
        margin: margin,
        width: width,
        decoration: BoxDecoration(
          color: resolvedColor,
          borderRadius: borderRadius,
          border: variant == SurfaceVariant.bordered
              ? Border.fromBorderSide(
                  BorderSide(color: palette.dark02, width: 0.5),
                )
              : border,
        ),
        child: child,
      ),
    );
  }
}
