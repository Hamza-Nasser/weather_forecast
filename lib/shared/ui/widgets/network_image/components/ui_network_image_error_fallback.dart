import 'package:flutter/material.dart';
import 'package:weather_app/configurations/ui/dimensions/app_dimensions.dart';
import 'package:weather_app/configurations/ui/theme/theme_data.dart';

class UiNetworkImageErrorFallback extends StatelessWidget {
  final double? width;
  final double? height;
  final BorderRadius borderRadius;

  const UiNetworkImageErrorFallback({
    super.key,
    required this.width,
    required this.height,
    required this.borderRadius,
  });

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorPalette;

    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        color: colors.dark01,
        borderRadius: borderRadius,
      ),
      child: Center(
        child: Icon(
          Icons.image_outlined,
          size: AppIconSize.l,
          color: colors.dark03,
        ),
      ),
    );
  }
}
