import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:weather_app/configurations/ui/dimensions/app_dimensions.dart';
import 'package:weather_app/configurations/ui/theme/theme_data.dart';

/// Custom app bar using theme tokens.
///
/// Use instead of raw [AppBar] throughout the app.
class UiAppBar extends StatelessWidget implements PreferredSizeWidget {
  /// The title text to display.
  final String? title;

  /// Optional title widget (takes precedence over [title]).
  final Widget? titleWidget;

  /// Whether to show the back button.
  final bool showBackButton;

  /// Actions on the right side.
  final List<Widget>? actions;

  /// Background color override.
  final Color? backgroundColor;

  /// Whether the app bar should be transparent.
  final bool transparent;

  /// Whether to center the title (defaults to true).
  final bool? centerTitle;

  /// Optional color override for the icon theme.
  final Color? iconColor;

  /// The ratio of glassmorphism effect (0.0 to 1.0).
  final double glassRatio;

  const UiAppBar({
    super.key,
    this.title,
    this.titleWidget,
    this.showBackButton = true,
    this.actions,
    this.backgroundColor,
    this.transparent = false,
    this.centerTitle,
    this.iconColor,
    this.glassRatio = 0.0,
  });

  @override
  Widget build(BuildContext context) {
    final palette = Theme.of(context).colorPalette;
    final typography = Theme.of(context).appTypography;
    final double scale = 1.0 - (0.1 * glassRatio);

    return AppBar(
      leading: showBackButton
          ? Transform.scale(
              scale: scale,
              alignment: Alignment.centerLeft,
              child: const BackButton(),
            )
          : null,
      automaticallyImplyLeading: false,
      title: titleWidget != null || title != null
          ? Transform.scale(
              scale: scale,
              alignment: (centerTitle ?? true)
                  ? Alignment.center
                  : Alignment.centerLeft,
              child:
                  titleWidget ?? Text(title!, style: typography.titleSemibold),
            )
          : null,
      centerTitle: centerTitle ?? true,
      backgroundColor: transparent
          ? Colors.transparent
          : (backgroundColor ?? palette.white),
      elevation: transparent ? 0 : null,
      scrolledUnderElevation: 0,
      iconTheme: IconThemeData(
        color: iconColor ?? palette.dark,
        size: AppIconSize.l,
      ),
      actions: actions
          ?.map(
            (action) => Transform.scale(
              scale: scale,
              alignment: Alignment.centerRight,
              child: action,
            ),
          )
          .toList(),
      flexibleSpace: glassRatio > 0.0
          ? ClipRect(
              child: BackdropFilter(
                filter: ImageFilter.blur(
                  sigmaX: 15 * glassRatio,
                  sigmaY: 15 * glassRatio,
                ),
                child: Container(
                  color: palette.white.withValues(alpha: 0.08 * glassRatio),
                ),
              ),
            )
          : null,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
