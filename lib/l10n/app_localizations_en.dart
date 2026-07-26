// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get appTitle => 'Weather App';

  @override
  String get errorSomethingWentWrong => 'Something went wrong';

  @override
  String get errorNoInternetConnection => 'No internet connection';

  @override
  String get errorFetchData => 'Error during communication';

  @override
  String get errorBadRequest =>
      'Bad request, please check your request and try again';

  @override
  String get errorUnauthorized => 'Unauthorized';

  @override
  String get errorConflict => 'Conflict occurred';

  @override
  String get errorInternalServer => 'Internal server error';

  @override
  String get errorServiceUnavailable => 'Service unavailable, try again later';

  @override
  String get errorReadFromDevice => 'Can\'t read from device';

  @override
  String get retry => 'Retry';

  @override
  String get noDataAvailable => 'No data available';

  @override
  String get home => 'Home';

  @override
  String get search => 'Search';

  @override
  String get settings => 'Settings';

  @override
  String get language => 'Language';

  @override
  String get english => 'English';

  @override
  String get arabic => 'Arabic';

  @override
  String get weather => 'Weather';

  @override
  String get searchCity => 'Search city...';

  @override
  String get cancel => 'Cancel';

  @override
  String get welcomeTitle => 'Welcome to Homa Weather';

  @override
  String get welcomeSubtitle =>
      'Search for any city to view real-time weather details and hourly forecasts.';

  @override
  String get failedToLoadWeather => 'Failed to load weather data.';

  @override
  String get details => 'Details';

  @override
  String get realFeel => 'RealFeel';

  @override
  String get humidityLabel => 'Humidity';

  @override
  String get windForce => 'W. force';

  @override
  String get pressure => 'Pressure';

  @override
  String nDayForecast(int count) {
    return '$count-Day Forecast';
  }

  @override
  String get today => 'Today';

  @override
  String get monday => 'Monday';

  @override
  String get tuesday => 'Tuesday';

  @override
  String get wednesday => 'Wednesday';

  @override
  String get thursday => 'Thursday';

  @override
  String get friday => 'Friday';

  @override
  String get saturday => 'Saturday';

  @override
  String get sunday => 'Sunday';

  @override
  String get uvIndex => 'UV index';

  @override
  String get feelsLike => 'Feels like';

  @override
  String get wind => 'Wind';

  @override
  String get sunriseLabel => 'Sunrise';

  @override
  String get visibility => 'Visibility';

  @override
  String get moonPhaseLabel => 'Moon phase';

  @override
  String get lifestyle => 'Lifestyle';

  @override
  String get low => 'Low';

  @override
  String get moderate => 'Moderate';

  @override
  String get high => 'High';

  @override
  String get weatherInsights => 'Weather Insights';

  @override
  String get uvIndexLabel => 'UV Index';

  @override
  String get airQuality => 'Air Quality';

  @override
  String get clothing => 'Clothing';

  @override
  String get outdoorSport => 'Outdoor Sport';

  @override
  String get uvHighRisk => 'Wear sunscreen & shades.';

  @override
  String get uvSafe => 'Safe to be outdoors.';

  @override
  String get airExcellent => 'Fresh air, great for walks.';

  @override
  String get airModerate => 'Slight humidity dust risk.';

  @override
  String get clothingHeavy => 'Heavy Layers';

  @override
  String get clothingHeavyAdvice => 'Warm coat and gloves recommended.';

  @override
  String get clothingJacket => 'Jacket / Hoodie';

  @override
  String get clothingJacketAdvice => 'Comfortable long sleeves.';

  @override
  String get clothingLight => 'Light T-Shirt';

  @override
  String get clothingLightAdvice => 'Perfect for shorts and breathable fabric.';

  @override
  String get sportNotRecommended => 'Not Recommended';

  @override
  String get sportNotRecommendedAdvice => 'Wet ground & poor visibility.';

  @override
  String get sportIndoor => 'Indoor Only';

  @override
  String get sportIndoorAdvice => 'Excessive heat warning.';

  @override
  String get sportExcellent => 'Excellent';

  @override
  String get sportExcellentAdvice => 'Perfect for outdoor jogging/cycling.';

  @override
  String get uvAlmostNoRisk => 'Almost no risk of sunburn';

  @override
  String get uvLowRisk => 'Low risk of UV harm';

  @override
  String get uvModerateHighRisk => 'Moderate to high risk of sunburn';

  @override
  String get excellentVisibility => 'Excellent visibility';

  @override
  String get goodVisibility => 'Good visibility';

  @override
  String get moderateVisibility => 'Moderate visibility';

  @override
  String get pressureStuffy => 'May feel stuffy for sensitive individuals';

  @override
  String get pressureStable => 'Stable atmospheric conditions';

  @override
  String get pressureNormal => 'Normal barometric pressure';

  @override
  String get newMoon => 'New moon';

  @override
  String get noMoonrise => 'No moonrise';

  @override
  String get feelsWarmer => 'Feels warmer than actual temperature';

  @override
  String get feelsCooler => 'Feels cooler than actual temperature';

  @override
  String get feelsSimilar => 'Feels similar to actual temperature';

  @override
  String actualTemperature(int temp) {
    return 'Actual temperature: $temp°';
  }

  @override
  String get humidityDry => 'Dry air, skin might feel dry';

  @override
  String get humidityComfortable => 'Comfortable, normal humidity levels';

  @override
  String get humidityFairly => 'Fairly humid, drying will take longer';

  @override
  String sunsetTime(String time) {
    return 'Sunset: $time';
  }

  @override
  String windDirection(String direction) {
    return '$direction wind';
  }

  @override
  String get windLightAir => 'light air on the face';

  @override
  String get windGentleBreeze => 'gentle breeze on the face';

  @override
  String get windModerateBreeze => 'moderate breeze on the face';

  @override
  String get windStrongBreeze => 'strong breeze on the face';

  @override
  String get greatForRunning => 'Great for running';

  @override
  String get tooHotForRunning => 'Too hot for running';

  @override
  String get unsuitableForRunning => 'Unsuitable for running';

  @override
  String get idealFishing => 'Ideal fishing conditions';

  @override
  String get notIdealFishing => 'Not ideal fishing';

  @override
  String get excellentForHiking => 'Excellent for hiking';

  @override
  String get coldForHiking => 'Cold for hiking';

  @override
  String get unsuitableForHiking => 'Unsuitable for hiking';

  @override
  String get airExcellentValue => '35 (Excellent)';

  @override
  String get airGoodValue => '42 (Good)';

  @override
  String get airModerateValue => '68 (Moderate)';

  @override
  String get uvHighValue => '7 (High)';

  @override
  String get uvModerateValue => '3 (Moderate)';

  @override
  String get uvLowValue => '1 (Low)';

  @override
  String get egypt => 'Egypt';

  @override
  String get kuwait => 'Kuwait';

  @override
  String get ksa => 'KSA';

  @override
  String get qatar => 'Qatar';

  @override
  String get morocco => 'Morocco';

  @override
  String lastUpdated(String time) {
    return 'Last updated $time';
  }

  @override
  String get justNow => 'just now';

  @override
  String minutesAgo(int count) {
    return '$count min ago';
  }

  @override
  String hoursAgo(int count) {
    return '$count hr ago';
  }

  @override
  String get pageNotFound => 'Page not found';

  @override
  String get searchAction => 'Search';

  @override
  String get clearSearch => 'Clear search';

  @override
  String get openSettings => 'Open settings';

  @override
  String get cachedWeather => 'Showing saved weather';

  @override
  String get staleWeather => 'Offline — showing older saved weather';

  @override
  String get weatherDataAttribution =>
      'Weather data provided by WeatherAPI.com';

  @override
  String get weatherDataDisclaimer =>
      'Forecasts are informational and may differ from actual conditions.';

  @override
  String get errorMissingApiKey =>
      'Weather service is not configured. Add WEATHER_API_KEY to the bundled build settings.';
}
