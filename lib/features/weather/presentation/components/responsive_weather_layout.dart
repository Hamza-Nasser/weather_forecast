import 'package:flutter/material.dart';
import 'package:weather_app/configurations/ui/dimensions/app_breakpoints.dart';
import 'package:weather_app/configurations/ui/dimensions/app_dimensions.dart';

/// Responsive layout wrapper that renders weather content in a single column
/// on mobile screens and a two-column layout on tablets.
///
/// Uses [LayoutBuilder] to decide which layout to apply based on the
/// available width and [AppBreakpoints.tablet].
class ResponsiveWeatherLayout extends StatelessWidget {
  const ResponsiveWeatherLayout({
    super.key,
    required this.heroCard,
    required this.secondaryContent,
  });

  /// The main weather card (city, temperature, hourly, sun arc, stats).
  final Widget heroCard;

  /// The secondary content (weekly forecast, details grid, etc.).
  final Widget secondaryContent;

  /// Maximum content width on large tablets to prevent over-stretching.
  static const double _maxContentWidth = 900;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final isTablet = constraints.maxWidth >= AppBreakpoints.tablet;

        if (!isTablet) {
          return _MobileLayout(
            heroCard: heroCard,
            secondaryContent: secondaryContent,
          );
        }

        return _TabletLayout(
          heroCard: heroCard,
          secondaryContent: secondaryContent,
          maxWidth: _maxContentWidth,
        );
      },
    );
  }
}

/// Single-column mobile layout — preserves the existing stacked arrangement.
class _MobileLayout extends StatelessWidget {
  const _MobileLayout({
    required this.heroCard,
    required this.secondaryContent,
  });

  final Widget heroCard;
  final Widget secondaryContent;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        heroCard,
        const SizedBox(height: AppSpacing.l),
        secondaryContent,
      ],
    );
  }
}

/// Two-column tablet layout with a 55/45 split.
///
/// Content is centered and capped at [maxWidth] so it doesn't stretch
/// edge-to-edge on large iPads in landscape.
class _TabletLayout extends StatelessWidget {
  const _TabletLayout({
    required this.heroCard,
    required this.secondaryContent,
    required this.maxWidth,
  });

  final Widget heroCard;
  final Widget secondaryContent;
  final double maxWidth;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ConstrainedBox(
        constraints: BoxConstraints(maxWidth: maxWidth),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Hero card — 55% of available width
            Expanded(
              flex: 55,
              child: heroCard,
            ),
            const SizedBox(width: AppSpacing.l),
            // Secondary content — 45% of available width
            Expanded(
              flex: 45,
              child: secondaryContent,
            ),
          ],
        ),
      ),
    );
  }
}
