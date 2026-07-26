import 'package:flutter/material.dart';
import 'package:weather_app/l10n/app_localizations.dart';
import 'package:weather_app/shared/ui/widgets/text.dart';

class RouteErrorScreen extends StatelessWidget {
  const RouteErrorScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: UiText.titleMedium(
          AppLocalizations.of(context)!.pageNotFound,
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
