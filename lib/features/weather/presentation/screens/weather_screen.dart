import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:iconsax/iconsax.dart';
import 'package:weather_app/configurations/di/injector.dart';
import 'package:weather_app/configurations/navigation/app_routes.dart';
import 'package:weather_app/configurations/ui/dimensions/app_dimensions.dart';
import 'package:weather_app/configurations/ui/theme/theme_data.dart';
import 'package:weather_app/core/services/prefs/app_preferences.dart';
import 'package:weather_app/features/settings/presentation/bloc/settings_cubit.dart';
import 'package:weather_app/features/settings/presentation/bloc/settings_state.dart';
import 'package:weather_app/features/weather/presentation/bloc/weather_bloc.dart';
import 'package:weather_app/features/weather/presentation/bloc/weather_event.dart';
import 'package:weather_app/features/weather/presentation/bloc/weather_state.dart';
import 'package:weather_app/features/weather/presentation/components/quick_city_chips.dart';
import 'package:weather_app/features/weather/presentation/components/weather_state_content.dart';
import 'package:weather_app/features/weather/presentation/components/weather_visuals.dart';
import 'package:weather_app/l10n/app_localizations.dart';
import 'package:weather_app/shared/ui/widgets/app_bar.dart';
import 'package:weather_app/shared/ui/widgets/text.dart';

/// Default city used when no last city preference is stored.
const _defaultCity = 'Cairo';

/// Weather home screen with a dark gradient background and glass weather card.
class WeatherScreen extends StatelessWidget {
  const WeatherScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final lastCity = sl<AppPreferences>().getLastCity();
    final initialCity = lastCity.isNotEmpty ? lastCity : _defaultCity;

    return BlocProvider(
      create: (context) =>
          sl<WeatherBloc>()..add(WeatherFetchRequested(initialCity)),
      child: BlocListener<SettingsCubit, SettingsState>(
        listenWhen: (previous, current) => previous.locale != current.locale,
        listener: (context, state) {
          final bloc = context.read<WeatherBloc>();
          if (bloc.state.searchQuery.isNotEmpty) {
            bloc.add(
              WeatherFetchRequested(bloc.state.searchQuery, forceRefresh: true),
            );
          }
        },
        child: const WeatherScreenContent(),
      ),
    );
  }
}

/// Stateful content managing search interaction and scroll-driven glass ratio.
class WeatherScreenContent extends StatefulWidget {
  const WeatherScreenContent({super.key});

  @override
  State<WeatherScreenContent> createState() => _WeatherScreenContentState();
}

class _WeatherScreenContentState extends State<WeatherScreenContent> {
  late final TextEditingController _searchController;
  late final ScrollController _scrollController;
  late final ValueNotifier<double> _glassRatioNotifier;
  bool _isSearching = false;

  @override
  void initState() {
    super.initState();
    _searchController = TextEditingController();
    _searchController.addListener(_onTextChanged);
    _glassRatioNotifier = ValueNotifier<double>(0.0);
    _scrollController = ScrollController()..addListener(_onScroll);
  }

  @override
  void dispose() {
    _searchController.removeListener(_onTextChanged);
    _searchController.dispose();
    _glassRatioNotifier.dispose();
    _scrollController.removeListener(_onScroll);
    _scrollController.dispose();
    super.dispose();
  }

  void _onTextChanged() {
    // Rebuild search bar to show/hide the clear button
    setState(() {});
  }

  void _onScroll() {
    final ratio = (_scrollController.offset / 100.0).clamp(0.0, 1.0);
    _glassRatioNotifier.value = ratio;
  }

  void _searchCity(String city) {
    if (city.trim().isEmpty) return;
    final trimmedCity = city.trim();
    context.read<WeatherBloc>().add(WeatherFetchRequested(trimmedCity));
    FocusScope.of(context).unfocus();
  }

  @override
  Widget build(BuildContext context) {
    final palette = Theme.of(context).colorPalette;
    final l10n = AppLocalizations.of(context)!;

    final quickCities = [
      QuickCity(query: 'Egypt', displayName: l10n.egypt),
      QuickCity(query: 'Kuwait', displayName: l10n.kuwait),
      QuickCity(query: 'KSA', displayName: l10n.ksa),
      QuickCity(query: 'Qatar', displayName: l10n.qatar),
      QuickCity(query: 'Morocco', displayName: l10n.morocco),
    ];

    return BlocBuilder<WeatherBloc, WeatherState>(
      builder: (context, state) {
        final gradient = WeatherVisuals.backgroundGradient(state.conditionCode);
        final blobs = WeatherVisuals.blobColors(state.conditionCode);

        return Scaffold(
          extendBodyBehindAppBar: true,
          appBar: PreferredSize(
            preferredSize: const Size.fromHeight(kToolbarHeight),
            child: ValueListenableBuilder<double>(
              valueListenable: _glassRatioNotifier,
              builder: (context, glassRatio, child) {
                return UiAppBar(
                  transparent: true,
                  glassRatio: glassRatio,
                  showBackButton: false,
                  centerTitle: false,
                  titleWidget: _isSearching
                      ? _SearchField(
                          controller: _searchController,
                          onSubmitted: (value) {
                            _searchCity(value);
                            setState(() => _isSearching = false);
                          },
                          onClear: () =>
                              setState(() => _searchController.clear()),
                        )
                      : _AppBarTitle(l10n: l10n),
                  actions: _isSearching
                      ? [
                          TextButton(
                            onPressed: () {
                              setState(() {
                                _isSearching = false;
                                _searchController.clear();
                              });
                            },
                            child: UiText.baseMedium(
                              l10n.cancel,
                              color: palette.white,
                            ),
                          ),
                        ]
                      : [
                          IconButton(
                            tooltip: l10n.searchAction,
                            icon: Icon(
                              Iconsax.search_normal_1,
                              color: palette.white,
                              size: AppIconSize.l,
                            ),
                            onPressed: () =>
                                setState(() => _isSearching = true),
                          ),
                          IconButton(
                            tooltip: l10n.openSettings,
                            icon: Icon(
                              Iconsax.setting_2,
                              color: palette.white,
                              size: AppIconSize.l,
                            ),
                            onPressed: () =>
                                context.push(AppRoute.settings.path),
                          ),
                        ],
                );
              },
            ),
          ),
          body: AnimatedContainer(
            duration: AppDuration.slow,
            height: double.infinity,
            decoration: BoxDecoration(gradient: gradient),
            child: RefreshIndicator(
              onRefresh: () {
                final bloc = context.read<WeatherBloc>();
                bloc.add(const WeatherRefreshRequested());
                return bloc.stream.firstWhere(
                  (next) => next.status != WeatherStatus.loading,
                );
              },
              color: palette.white,
              backgroundColor: palette.white.withValues(alpha: 0.15),
              child: SingleChildScrollView(
                controller: _scrollController,
                physics: const AlwaysScrollableScrollPhysics(),
                keyboardDismissBehavior:
                    ScrollViewKeyboardDismissBehavior.onDrag,
                padding: EdgeInsets.only(
                  left: AppSpacing.l,
                  right: AppSpacing.l,
                  bottom: AppSpacing.l,
                  top: context.paddingTop + kToolbarHeight + AppSpacing.s,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Quick-Select Chips
                    QuickCityChips(
                      cities: quickCities,
                      selectedCity: state.searchQuery,
                      onSelected: (city) {
                        _searchController.text = city;
                        _searchCity(city);
                      },
                    ),

                    const SizedBox(height: AppSpacing.xl),

                    // State Display with Cross-Fade Transition
                    AnimatedSwitcher(
                      duration: AppDuration.normal,
                      child: WeatherStateContent(
                        state: state,
                        blobColors: blobs,
                        onRetry: () {
                          final lastQuery = state.searchQuery.isNotEmpty
                              ? state.searchQuery
                              : _defaultCity;
                          _searchCity(lastQuery);
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}

/// App bar title row showing a cloud icon and the localized "Weather" text.
class _AppBarTitle extends StatelessWidget {
  final AppLocalizations l10n;

  const _AppBarTitle({required this.l10n});

  @override
  Widget build(BuildContext context) {
    final palette = Theme.of(context).colorPalette;

    return Row(
      children: [
        Icon(Icons.filter_drama, color: palette.white, size: AppIconSize.l),
        const SizedBox(width: AppSpacing.s),
        UiText.headlineBold(l10n.weather, color: palette.white),
      ],
    );
  }
}

/// Search text field shown in the app bar when searching.
class _SearchField extends StatelessWidget {
  final TextEditingController controller;
  final ValueChanged<String> onSubmitted;
  final VoidCallback onClear;

  const _SearchField({
    required this.controller,
    required this.onSubmitted,
    required this.onClear,
  });

  @override
  Widget build(BuildContext context) {
    final palette = Theme.of(context).colorPalette;
    final l10n = AppLocalizations.of(context)!;

    return TextField(
      controller: controller,
      autofocus: true,
      style: Theme.of(
        context,
      ).appTypography.baseMedium.copyWith(color: palette.white),
      textInputAction: TextInputAction.search,
      onSubmitted: onSubmitted,
      decoration: InputDecoration(
        hintText: l10n.searchCity,
        hintStyle: Theme.of(context).appTypography.baseRegular.copyWith(
          color: palette.white.withValues(alpha: 0.5),
        ),
        border: InputBorder.none,
        suffixIcon: controller.text.isNotEmpty
            ? IconButton(
                tooltip: l10n.clearSearch,
                onPressed: onClear,
                icon: Icon(
                  Icons.clear,
                  color: palette.white,
                  size: AppIconSize.m,
                ),
              )
            : null,
      ),
    );
  }
}
