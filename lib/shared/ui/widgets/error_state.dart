import 'package:flutter/material.dart';
import 'package:weather_app/configurations/ui/dimensions/app_dimensions.dart';
import 'package:weather_app/configurations/ui/theme/theme_data.dart';
import 'package:weather_app/l10n/app_localizations.dart';
import 'package:weather_app/shared/ui/widgets/button.dart';
import 'package:weather_app/shared/ui/widgets/glass_surface.dart';
import 'package:weather_app/shared/ui/widgets/text.dart';

/// A widget shown when an error occurs, with a retry option.
class ErrorState extends StatelessWidget {
  /// The error message to display.
  final String message;

  /// Callback when the retry button is pressed.
  final VoidCallback? onRetry;

  /// Optional icon to show above the message.
  final IconData icon;

  /// Optional override for the retry button label.
  /// Falls back to localized "Retry" when null.
  final String? retryLabel;

  const ErrorState({
    super.key,
    required this.message,
    this.onRetry,
    this.icon = Icons.error_outline_rounded,
    this.retryLabel,
  });

  @override
  Widget build(BuildContext context) {
    final palette = Theme.of(context).colorPalette;
    final l10n = AppLocalizations.of(context)!;

    return GlassSurface(
      blur: 20,
      opacity: 0.1,
      tintColor: palette.white,
      borderOpacity: 0.15,
      borderRadius: const BorderRadius.all(Radius.circular(AppBorderRadius.l)),
      padding: const EdgeInsets.all(AppSpacing.xxl),
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(vertical: AppSpacing.l),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Styled container for the error icon
            Container(
              padding: const EdgeInsets.all(AppSpacing.l),
              decoration: BoxDecoration(
                color: palette.error.withValues(alpha: 0.12),
                shape: BoxShape.circle,
                border: Border.all(
                  color: palette.error.withValues(alpha: 0.25),
                  width: 2,
                ),
              ),
              child: Icon(icon, size: AppIconSize.xxxl, color: palette.error),
            ),
            const SizedBox(height: AppSpacing.xl),
            // Title
            UiText.largeSemibold(
              l10n.errorSomethingWentWrong,
              color: palette.white,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: AppSpacing.s),
            // Error detailed message
            UiText.baseRegular(
              message,
              color: palette.white.withValues(alpha: 0.7),
              textAlign: TextAlign.center,
            ),
            if (onRetry != null) ...[
              const SizedBox(height: AppSpacing.xxl),
              UiButton.secondaryWhite(
                label: retryLabel ?? l10n.retry,
                onPressed: onRetry,
                icon: Icons.refresh_rounded,
              ),
            ],
          ],
        ),
      ),
    );
  }
}
