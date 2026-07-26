import 'package:flutter/material.dart';
import 'package:weather_app/configurations/ui/theme/theme_data.dart';
import 'package:skeletonizer/skeletonizer.dart';

class UiNetworkImageSkeletonPlaceholder extends StatelessWidget {
  final double? width;
  final double? height;
  final BorderRadius borderRadius;

  const UiNetworkImageSkeletonPlaceholder({
    super.key,
    required this.width,
    required this.height,
    required this.borderRadius,
  });

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorPalette;

    return Skeletonizer(
      enabled: true,
      child: Container(
        width: width,
        height: height,
        decoration: BoxDecoration(
          color: colors.dark01,
          borderRadius: borderRadius,
        ),
      ),
    );
  }
}
