import 'package:flutter/material.dart';
import 'package:weather_app/configurations/ui/dimensions/app_dimensions.dart';
import 'package:weather_app/configurations/ui/theme/theme_data.dart';

/// Button variant types.
enum UiButtonVariant { primary, secondary, text, destructive, secondaryWhite }

/// A themed button widget that enforces the design system.
///
/// Use [UiButton] instead of raw Flutter buttons throughout the app.
class UiButton extends StatelessWidget {
  /// The button label text.
  final String label;

  /// The callback when pressed. Null disables the button.
  final VoidCallback? onPressed;

  /// The button variant.
  final UiButtonVariant variant;

  /// Optional leading icon.
  final IconData? icon;

  /// Whether to show a loading indicator instead of the label.
  final bool isLoading;

  /// Whether the button expands to fill available width.
  final bool expand;

  /// Optional custom padding.
  final EdgeInsetsGeometry? padding;

  const UiButton({
    super.key,
    required this.label,
    this.onPressed,
    this.variant = UiButtonVariant.primary,
    this.icon,
    this.isLoading = false,
    this.expand = false,
    this.padding,
  });

  const UiButton.secondary({
    super.key,
    required this.label,
    this.onPressed,
    this.icon,
    this.isLoading = false,
    this.expand = false,
    this.padding,
  }) : variant = UiButtonVariant.secondary;

  const UiButton.text({
    super.key,
    required this.label,
    this.onPressed,
    this.icon,
    this.isLoading = false,
    this.expand = false,
    this.padding,
  }) : variant = UiButtonVariant.text;

  const UiButton.destructive({
    super.key,
    required this.label,
    this.onPressed,
    this.icon,
    this.isLoading = false,
    this.expand = false,
    this.padding,
  }) : variant = UiButtonVariant.destructive;

  const UiButton.secondaryWhite({
    super.key,
    required this.label,
    this.onPressed,
    this.icon,
    this.isLoading = false,
    this.expand = false,
    this.padding,
  }) : variant = UiButtonVariant.secondaryWhite;

  @override
  Widget build(BuildContext context) {
    final palette = Theme.of(context).colorPalette;
    final typography = Theme.of(context).appTypography;

    final isDisabled = onPressed == null || isLoading;

    final (bgColor, fgColor, borderSide) = switch (variant) {
      UiButtonVariant.primary => (
        isDisabled ? palette.primary.withValues(alpha: 0.5) : palette.primary,
        Colors.white,
        BorderSide.none,
      ),
      UiButtonVariant.secondary => (
        Colors.transparent,
        isDisabled ? palette.primary.withValues(alpha: 0.5) : palette.primary,
        BorderSide(
          color: isDisabled
              ? palette.primary.withValues(alpha: 0.5)
              : palette.primary,
        ),
      ),
      UiButtonVariant.text => (
        Colors.transparent,
        isDisabled ? palette.dark05 : palette.primary,
        BorderSide.none,
      ),
      UiButtonVariant.destructive => (
        isDisabled
            ? palette.destructive.withValues(alpha: 0.5)
            : palette.destructive,
        Colors.white,
        BorderSide.none,
      ),
      UiButtonVariant.secondaryWhite => (
        isDisabled ? Colors.transparent : Colors.white.withValues(alpha: 0.08),
        isDisabled ? palette.white.withValues(alpha: 0.5) : palette.white,
        BorderSide(
          color: isDisabled
              ? palette.white.withValues(alpha: 0.3)
              : palette.white.withValues(alpha: 0.6),
          width: 1.0,
        ),
      ),
    };

    final buttonStyle = ButtonStyle(
      backgroundColor: WidgetStatePropertyAll(bgColor),
      foregroundColor: WidgetStatePropertyAll(fgColor),
      padding: WidgetStatePropertyAll(
        padding ??
            const EdgeInsets.symmetric(
              horizontal: AppSpacing.xl,
              vertical: AppSpacing.m,
            ),
      ),
      shape: WidgetStatePropertyAll(
        RoundedRectangleBorder(
          borderRadius: AppBorderRadius.circularS,
          side: borderSide,
        ),
      ),
      elevation: const WidgetStatePropertyAll(0),
      minimumSize: expand
          ? const WidgetStatePropertyAll(Size(double.infinity, 48))
          : null,
    );

    final child = isLoading
        ? SizedBox(
            width: AppIconSize.m,
            height: AppIconSize.m,
            child: CircularProgressIndicator(strokeWidth: 2, color: fgColor),
          )
        : Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              if (icon != null) ...[
                Icon(icon, size: AppIconSize.m),
                const SizedBox(width: AppSpacing.s),
              ],
              Text(label, style: typography.baseSemibold),
            ],
          );

    return ElevatedButton(
      onPressed: isDisabled ? null : onPressed,
      style: buttonStyle,
      child: child,
    );
  }
}
