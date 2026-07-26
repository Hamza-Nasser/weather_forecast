import 'package:flutter/material.dart';
import 'package:weather_app/configurations/ui/dimensions/app_dimensions.dart';
import 'package:weather_app/configurations/ui/theme/theme_data.dart';
import 'package:weather_app/l10n/app_localizations.dart';
import 'package:weather_app/shared/ui/widgets/text.dart';

class HumidityContent extends StatelessWidget {
  final int humidity;

  const HumidityContent({super.key, required this.humidity});

  @override
  Widget build(BuildContext context) {
    final palette = Theme.of(context).colorPalette;
    final l10n = AppLocalizations.of(context)!;

    String humidityDesc;
    if (humidity < 40) {
      humidityDesc = l10n.humidityDry;
    } else if (humidity < 70) {
      humidityDesc = l10n.humidityComfortable;
    } else {
      humidityDesc = l10n.humidityFairly;
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        UiText.headlineRegular(
          '$humidity%',
          color: palette.white,
          style: const TextStyle(fontSize: 38, height: 1.1),
        ),
        const SizedBox(height: AppSpacing.s),
        UiText.captionRegular(
          humidityDesc,
          color: palette.white.withValues(alpha: 0.8),
          maxLines: 3,
          overflow: TextOverflow.ellipsis,
        ),
      ],
    );
  }
}
