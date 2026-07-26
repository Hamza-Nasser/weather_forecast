import 'package:equatable/equatable.dart';

/// State of the settings feature.
class SettingsState extends Equatable {
  const SettingsState({required this.locale});

  /// The active locale code (e.g., 'en', 'ar' or empty for system default).
  final String locale;

  SettingsState copyWith({String? locale}) {
    return SettingsState(
      locale: locale ?? this.locale,
    );
  }

  @override
  List<Object?> get props => [locale];
}
