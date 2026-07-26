import 'package:flutter/material.dart';
import 'package:weather_app/configurations/ui/dimensions/app_dimensions.dart';
import 'package:weather_app/configurations/ui/theme/theme_data.dart';
import 'package:weather_app/shared/ui/widgets/text.dart';

/// Represents a quick-select city query and its localized display name.
class QuickCity {
  final String query;
  final String displayName;

  const QuickCity({required this.query, required this.displayName});
}

/// Horizontally scrollable quick-select city chips.
class QuickCityChips extends StatelessWidget {
  final List<QuickCity> cities;
  final String selectedCity;
  final ValueChanged<String> onSelected;

  const QuickCityChips({
    super.key,
    required this.cities,
    required this.selectedCity,
    required this.onSelected,
  });

  @override
  Widget build(BuildContext context) {
    final palette = Theme.of(context).colorPalette;

    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: cities.map((city) {
          final isSelected =
              selectedCity.toLowerCase() == city.query.toLowerCase();
          return Padding(
            padding: const EdgeInsets.only(right: AppSpacing.s),
            child: Semantics(
              button: true,
              selected: isSelected,
              label: city.displayName,
              child: Material(
                color: Colors.transparent,
                child: InkWell(
                  onTap: () => onSelected(city.query),
                  borderRadius: AppBorderRadius.circularM,
                  child: AnimatedContainer(
                    duration: AppDuration.fast,
                    constraints: const BoxConstraints(minHeight: 48),
                    padding: const EdgeInsets.symmetric(
                      horizontal: AppSpacing.l,
                      vertical: AppSpacing.s,
                    ),
                    decoration: BoxDecoration(
                      borderRadius: AppBorderRadius.circularM,
                      color: isSelected
                          ? palette.white.withValues(alpha: 0.2)
                          : palette.white.withValues(alpha: 0.05),
                      border: Border.all(
                        color: isSelected
                            ? palette.white.withValues(alpha: 0.4)
                            : palette.white.withValues(alpha: 0.1),
                        width: 1,
                      ),
                    ),
                    alignment: Alignment.center,
                    child: UiText.smallMedium(
                      city.displayName,
                      color: isSelected
                          ? palette.white
                          : palette.white.withValues(alpha: 0.6),
                    ),
                  ),
                ),
              ),
            ),
          );
        }).toList(),
      ),
    );
  }
}
