import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:weather_app/configurations/ui/dimensions/app_dimensions.dart';

/// A glassmorphism surface widget with frosted-glass effect.
///
/// Uses [BackdropFilter] with [ImageFilter.blur] to achieve the glass look.
/// Designed for weather app overlays, cards, and panels.
class GlassSurface extends StatelessWidget {
  /// The child widget to display inside the glass surface.
  final Widget? child;

  /// Padding inside the glass container.
  final EdgeInsetsGeometry? padding;

  /// Margin outside the glass container.
  final EdgeInsetsGeometry? margin;

  /// The blur intensity for the frosted effect. Defaults to 10.
  final double blur;

  /// The opacity of the glass background tint. Defaults to 0.15.
  final double opacity;

  /// The tint color applied to the glass. Defaults to white.
  final Color? tintColor;

  /// Border radius for the glass container.
  final BorderRadiusGeometry borderRadius;

  /// Optional border to draw around the glass surface.
  final double borderOpacity;

  /// Optional width constraint.
  final double? width;

  /// Optional height constraint.
  final double? height;

  /// Callback when the surface is tapped.
  final VoidCallback? onTap;

  const GlassSurface({
    super.key,
    this.child,
    this.padding,
    this.margin,
    this.blur = 10.0,
    this.opacity = 0.15,
    this.tintColor,
    this.borderRadius =
        const BorderRadius.all(Radius.circular(AppBorderRadius.m)),
    this.borderOpacity = 0.2,
    this.width,
    this.height,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final resolvedTint = tintColor ?? Colors.white;

    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: margin,
        width: width,
        height: height,
        child: ClipRRect(
          borderRadius: borderRadius.resolve(Directionality.of(context)),
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: blur, sigmaY: blur),
            child: Container(
              padding: padding ??
                  const EdgeInsets.symmetric(
                    horizontal: AppSpacing.l,
                    vertical: AppSpacing.l,
                  ),
              decoration: BoxDecoration(
                color: resolvedTint.withValues(alpha: opacity),
                borderRadius: borderRadius,
                border: Border.all(
                  color: resolvedTint.withValues(alpha: borderOpacity),
                  width: 1.0,
                ),
              ),
              child: child,
            ),
          ),
        ),
      ),
    );
  }
}
