import 'package:flutter/material.dart';
import 'package:weather_app/configurations/ui/dimensions/app_dimensions.dart';
import 'package:weather_app/configurations/ui/theme/theme_data.dart';
import 'package:weather_app/shared/ui/widgets/text.dart';

/// A placeholder widget shown when there's no data to display.
class EmptyState extends StatelessWidget {
  /// The message to display.
  final String message;

  /// Optional icon to show above the message.
  final IconData icon;

  /// Optional action button below the message.
  final Widget? action;

  const EmptyState({
    super.key,
    required this.message,
    this.icon = Icons.cloud_off_outlined,
    this.action,
  });

  @override
  Widget build(BuildContext context) {
    final palette = Theme.of(context).colorPalette;

    return Center(
      child: Padding(
        padding: const EdgeInsets.all(AppSpacing.xxxl),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, size: AppIconSize.xxxl, color: palette.dark04),
            const SizedBox(height: AppSpacing.l),
            UiText.baseMedium(
              message,
              color: palette.dark05,
              textAlign: TextAlign.center,
            ),
            if (action != null) ...[
              const SizedBox(height: AppSpacing.xl),
              action!,
            ],
          ],
        ),
      ),
    );
  }
}
