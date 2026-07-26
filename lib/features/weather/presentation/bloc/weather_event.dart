import 'package:equatable/equatable.dart';

/// Events for the Weather BLoC.
sealed class WeatherEvent extends Equatable {
  const WeatherEvent();

  @override
  List<Object?> get props => [];
}

/// Requests weather data for a specific city.
class WeatherFetchRequested extends WeatherEvent {
  const WeatherFetchRequested(this.city, {this.forceRefresh = false});

  final String city;

  /// When `true`, bypasses cache and fetches fresh data from the server.
  final bool forceRefresh;

  @override
  List<Object?> get props => [city, forceRefresh];
}

/// Refreshes the currently loaded weather data (pull-to-refresh).
///
/// Always forces a server fetch, bypassing cache.
class WeatherRefreshRequested extends WeatherEvent {
  const WeatherRefreshRequested();
}
