import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:weather_app/configurations/ui/dimensions/app_dimensions.dart';
import 'package:weather_app/shared/ui/widgets/network_image/components/ui_network_image_error_fallback.dart';
import 'package:weather_app/shared/ui/widgets/network_image/components/ui_network_image_skeleton_placeholder.dart';

/// A reusable network image widget with caching, skeleton loading, and
/// error fallback.
class UiNetworkImage extends StatelessWidget {
  /// The URL of the image to load.
  final String? url;

  /// The desired width of the image.
  final double? width;

  /// The desired height of the image.
  final double? height;

  /// How to inscribe the image into the space.
  final BoxFit fit;

  /// Border radius applied to the image.
  final BorderRadius borderRadius;

  /// Optional custom placeholder widget (shown while loading).
  /// Defaults to a skeleton shimmer placeholder.
  final Widget? placeholder;

  /// Optional custom error widget (shown when image fails to load).
  /// Defaults to an icon placeholder.
  final Widget? errorWidget;

  const UiNetworkImage({
    super.key,
    required this.url,
    this.width,
    this.height,
    this.fit = BoxFit.cover,
    this.borderRadius = const BorderRadius.all(Radius.circular(AppBorderRadius.s)),
    this.placeholder,
    this.errorWidget,
  });

  @override
  Widget build(BuildContext context) {
    if (!_isValidUrl(url)) {
      return UiNetworkImageErrorFallback(width: width, height: height, borderRadius: borderRadius);
    }

    return ClipRRect(
      borderRadius: borderRadius,
      child: CachedNetworkImage(
        imageUrl: url!,
        cacheKey: url,
        width: width,
        height: height,
        fit: fit,
        fadeInDuration: AppDuration.fast,
        fadeOutDuration: AppDuration.fast,
        placeholderFadeInDuration: const Duration(milliseconds: 100),
        useOldImageOnUrlChange: false,
        memCacheWidth: width != null ? _calculateCacheSize(context, width) : null,
        memCacheHeight: width == null && height != null
            ? _calculateCacheSize(context, height)
            : null,
        placeholder: (context, url) =>
            placeholder ??
            UiNetworkImageSkeletonPlaceholder(
              width: width,
              height: height,
              borderRadius: borderRadius,
            ),
        errorWidget: (context, url, error) =>
            errorWidget ??
            UiNetworkImageErrorFallback(width: width, height: height, borderRadius: borderRadius),
      ),
    );
  }

  /// Calculates a pixel-density-aware cache dimension.
  int? _calculateCacheSize(BuildContext context, double? dimension) {
    if (dimension == null || dimension == double.infinity) return null;
    if (dimension <= 0) return null;
    final ratio = MediaQuery.devicePixelRatioOf(context);
    return (dimension * ratio).toInt();
  }

  static bool _isValidUrl(String? url) {
    if (url == null || url.trim().isEmpty) return false;
    if (url.startsWith('file://')) return false;
    if (!url.startsWith('http')) return false;
    return true;
  }
}
