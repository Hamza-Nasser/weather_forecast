/// Centralized API endpoint paths.
///
/// Add new endpoint constants here as features are implemented.
class Endpoints {
  static const String baseUrl = 'https://api.weatherapi.com/v1';

  // Weather
  static const String currentWeather = '/current.json';
  static const String forecast = '/forecast.json';
  static const String search = '/search.json';
}
