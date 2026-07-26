import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_ar.dart';
import 'app_localizations_en.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale)
    : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
        delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('ar'),
    Locale('en'),
  ];

  /// The title of the application
  ///
  /// In en, this message translates to:
  /// **'Weather App'**
  String get appTitle;

  /// Generic error message
  ///
  /// In en, this message translates to:
  /// **'Something went wrong'**
  String get errorSomethingWentWrong;

  /// Error message when there is no internet
  ///
  /// In en, this message translates to:
  /// **'No internet connection'**
  String get errorNoInternetConnection;

  /// Error message when data fetch fails due to communication issues
  ///
  /// In en, this message translates to:
  /// **'Error during communication'**
  String get errorFetchData;

  /// Error message for bad requests
  ///
  /// In en, this message translates to:
  /// **'Bad request, please check your request and try again'**
  String get errorBadRequest;

  /// Error message for unauthorized access
  ///
  /// In en, this message translates to:
  /// **'Unauthorized'**
  String get errorUnauthorized;

  /// Error message when a request conflict occurs
  ///
  /// In en, this message translates to:
  /// **'Conflict occurred'**
  String get errorConflict;

  /// Error message for internal server issues
  ///
  /// In en, this message translates to:
  /// **'Internal server error'**
  String get errorInternalServer;

  /// Error message when the service is down
  ///
  /// In en, this message translates to:
  /// **'Service unavailable, try again later'**
  String get errorServiceUnavailable;

  /// Error message when reading from device storage fails
  ///
  /// In en, this message translates to:
  /// **'Can\'t read from device'**
  String get errorReadFromDevice;

  /// Retry button label
  ///
  /// In en, this message translates to:
  /// **'Retry'**
  String get retry;

  /// Empty state message
  ///
  /// In en, this message translates to:
  /// **'No data available'**
  String get noDataAvailable;

  /// Home tab label
  ///
  /// In en, this message translates to:
  /// **'Home'**
  String get home;

  /// Search tab label
  ///
  /// In en, this message translates to:
  /// **'Search'**
  String get search;

  /// Settings tab label
  ///
  /// In en, this message translates to:
  /// **'Settings'**
  String get settings;

  /// Label for language settings option
  ///
  /// In en, this message translates to:
  /// **'Language'**
  String get language;

  /// English language name
  ///
  /// In en, this message translates to:
  /// **'English'**
  String get english;

  /// Arabic language name
  ///
  /// In en, this message translates to:
  /// **'Arabic'**
  String get arabic;

  /// Weather app bar title
  ///
  /// In en, this message translates to:
  /// **'Weather'**
  String get weather;

  /// Search field hint text
  ///
  /// In en, this message translates to:
  /// **'Search city...'**
  String get searchCity;

  /// Cancel button label
  ///
  /// In en, this message translates to:
  /// **'Cancel'**
  String get cancel;

  /// Welcome card title
  ///
  /// In en, this message translates to:
  /// **'Welcome to Homa Weather'**
  String get welcomeTitle;

  /// Welcome card subtitle
  ///
  /// In en, this message translates to:
  /// **'Search for any city to view real-time weather details and hourly forecasts.'**
  String get welcomeSubtitle;

  /// Error message when weather data fails to load
  ///
  /// In en, this message translates to:
  /// **'Failed to load weather data.'**
  String get failedToLoadWeather;

  /// Details section header
  ///
  /// In en, this message translates to:
  /// **'Details'**
  String get details;

  /// Real feel temperature label
  ///
  /// In en, this message translates to:
  /// **'RealFeel'**
  String get realFeel;

  /// Humidity stat label
  ///
  /// In en, this message translates to:
  /// **'Humidity'**
  String get humidityLabel;

  /// Wind force stat label
  ///
  /// In en, this message translates to:
  /// **'W. force'**
  String get windForce;

  /// Pressure stat label
  ///
  /// In en, this message translates to:
  /// **'Pressure'**
  String get pressure;

  /// N-day forecast section header
  ///
  /// In en, this message translates to:
  /// **'{count}-Day Forecast'**
  String nDayForecast(int count);

  /// Today label for daily forecast
  ///
  /// In en, this message translates to:
  /// **'Today'**
  String get today;

  /// No description provided for @monday.
  ///
  /// In en, this message translates to:
  /// **'Monday'**
  String get monday;

  /// No description provided for @tuesday.
  ///
  /// In en, this message translates to:
  /// **'Tuesday'**
  String get tuesday;

  /// No description provided for @wednesday.
  ///
  /// In en, this message translates to:
  /// **'Wednesday'**
  String get wednesday;

  /// No description provided for @thursday.
  ///
  /// In en, this message translates to:
  /// **'Thursday'**
  String get thursday;

  /// No description provided for @friday.
  ///
  /// In en, this message translates to:
  /// **'Friday'**
  String get friday;

  /// No description provided for @saturday.
  ///
  /// In en, this message translates to:
  /// **'Saturday'**
  String get saturday;

  /// No description provided for @sunday.
  ///
  /// In en, this message translates to:
  /// **'Sunday'**
  String get sunday;

  /// UV index card title
  ///
  /// In en, this message translates to:
  /// **'UV index'**
  String get uvIndex;

  /// Feels like card title
  ///
  /// In en, this message translates to:
  /// **'Feels like'**
  String get feelsLike;

  /// Wind card title
  ///
  /// In en, this message translates to:
  /// **'Wind'**
  String get wind;

  /// Sunrise card title
  ///
  /// In en, this message translates to:
  /// **'Sunrise'**
  String get sunriseLabel;

  /// Visibility card title
  ///
  /// In en, this message translates to:
  /// **'Visibility'**
  String get visibility;

  /// Moon phase card title
  ///
  /// In en, this message translates to:
  /// **'Moon phase'**
  String get moonPhaseLabel;

  /// Lifestyle card title
  ///
  /// In en, this message translates to:
  /// **'Lifestyle'**
  String get lifestyle;

  /// Low level label
  ///
  /// In en, this message translates to:
  /// **'Low'**
  String get low;

  /// Moderate level label
  ///
  /// In en, this message translates to:
  /// **'Moderate'**
  String get moderate;

  /// High level label
  ///
  /// In en, this message translates to:
  /// **'High'**
  String get high;

  /// Weather insights section title
  ///
  /// In en, this message translates to:
  /// **'Weather Insights'**
  String get weatherInsights;

  /// UV Index insight label
  ///
  /// In en, this message translates to:
  /// **'UV Index'**
  String get uvIndexLabel;

  /// Air quality insight label
  ///
  /// In en, this message translates to:
  /// **'Air Quality'**
  String get airQuality;

  /// Clothing insight label
  ///
  /// In en, this message translates to:
  /// **'Clothing'**
  String get clothing;

  /// Outdoor sport insight label
  ///
  /// In en, this message translates to:
  /// **'Outdoor Sport'**
  String get outdoorSport;

  /// UV advice for sunny/clear conditions
  ///
  /// In en, this message translates to:
  /// **'Wear sunscreen & shades.'**
  String get uvHighRisk;

  /// UV advice for non-sunny conditions
  ///
  /// In en, this message translates to:
  /// **'Safe to be outdoors.'**
  String get uvSafe;

  /// Air quality advice when excellent
  ///
  /// In en, this message translates to:
  /// **'Fresh air, great for walks.'**
  String get airExcellent;

  /// Air quality advice when moderate
  ///
  /// In en, this message translates to:
  /// **'Slight humidity dust risk.'**
  String get airModerate;

  /// No description provided for @clothingHeavy.
  ///
  /// In en, this message translates to:
  /// **'Heavy Layers'**
  String get clothingHeavy;

  /// No description provided for @clothingHeavyAdvice.
  ///
  /// In en, this message translates to:
  /// **'Warm coat and gloves recommended.'**
  String get clothingHeavyAdvice;

  /// No description provided for @clothingJacket.
  ///
  /// In en, this message translates to:
  /// **'Jacket / Hoodie'**
  String get clothingJacket;

  /// No description provided for @clothingJacketAdvice.
  ///
  /// In en, this message translates to:
  /// **'Comfortable long sleeves.'**
  String get clothingJacketAdvice;

  /// No description provided for @clothingLight.
  ///
  /// In en, this message translates to:
  /// **'Light T-Shirt'**
  String get clothingLight;

  /// No description provided for @clothingLightAdvice.
  ///
  /// In en, this message translates to:
  /// **'Perfect for shorts and breathable fabric.'**
  String get clothingLightAdvice;

  /// No description provided for @sportNotRecommended.
  ///
  /// In en, this message translates to:
  /// **'Not Recommended'**
  String get sportNotRecommended;

  /// No description provided for @sportNotRecommendedAdvice.
  ///
  /// In en, this message translates to:
  /// **'Wet ground & poor visibility.'**
  String get sportNotRecommendedAdvice;

  /// No description provided for @sportIndoor.
  ///
  /// In en, this message translates to:
  /// **'Indoor Only'**
  String get sportIndoor;

  /// No description provided for @sportIndoorAdvice.
  ///
  /// In en, this message translates to:
  /// **'Excessive heat warning.'**
  String get sportIndoorAdvice;

  /// No description provided for @sportExcellent.
  ///
  /// In en, this message translates to:
  /// **'Excellent'**
  String get sportExcellent;

  /// No description provided for @sportExcellentAdvice.
  ///
  /// In en, this message translates to:
  /// **'Perfect for outdoor jogging/cycling.'**
  String get sportExcellentAdvice;

  /// No description provided for @uvAlmostNoRisk.
  ///
  /// In en, this message translates to:
  /// **'Almost no risk of sunburn'**
  String get uvAlmostNoRisk;

  /// No description provided for @uvLowRisk.
  ///
  /// In en, this message translates to:
  /// **'Low risk of UV harm'**
  String get uvLowRisk;

  /// No description provided for @uvModerateHighRisk.
  ///
  /// In en, this message translates to:
  /// **'Moderate to high risk of sunburn'**
  String get uvModerateHighRisk;

  /// No description provided for @excellentVisibility.
  ///
  /// In en, this message translates to:
  /// **'Excellent visibility'**
  String get excellentVisibility;

  /// No description provided for @goodVisibility.
  ///
  /// In en, this message translates to:
  /// **'Good visibility'**
  String get goodVisibility;

  /// No description provided for @moderateVisibility.
  ///
  /// In en, this message translates to:
  /// **'Moderate visibility'**
  String get moderateVisibility;

  /// No description provided for @pressureStuffy.
  ///
  /// In en, this message translates to:
  /// **'May feel stuffy for sensitive individuals'**
  String get pressureStuffy;

  /// No description provided for @pressureStable.
  ///
  /// In en, this message translates to:
  /// **'Stable atmospheric conditions'**
  String get pressureStable;

  /// No description provided for @pressureNormal.
  ///
  /// In en, this message translates to:
  /// **'Normal barometric pressure'**
  String get pressureNormal;

  /// No description provided for @newMoon.
  ///
  /// In en, this message translates to:
  /// **'New moon'**
  String get newMoon;

  /// No description provided for @noMoonrise.
  ///
  /// In en, this message translates to:
  /// **'No moonrise'**
  String get noMoonrise;

  /// No description provided for @feelsWarmer.
  ///
  /// In en, this message translates to:
  /// **'Feels warmer than actual temperature'**
  String get feelsWarmer;

  /// No description provided for @feelsCooler.
  ///
  /// In en, this message translates to:
  /// **'Feels cooler than actual temperature'**
  String get feelsCooler;

  /// No description provided for @feelsSimilar.
  ///
  /// In en, this message translates to:
  /// **'Feels similar to actual temperature'**
  String get feelsSimilar;

  /// Actual temperature comparison label
  ///
  /// In en, this message translates to:
  /// **'Actual temperature: {temp}°'**
  String actualTemperature(int temp);

  /// No description provided for @humidityDry.
  ///
  /// In en, this message translates to:
  /// **'Dry air, skin might feel dry'**
  String get humidityDry;

  /// No description provided for @humidityComfortable.
  ///
  /// In en, this message translates to:
  /// **'Comfortable, normal humidity levels'**
  String get humidityComfortable;

  /// No description provided for @humidityFairly.
  ///
  /// In en, this message translates to:
  /// **'Fairly humid, drying will take longer'**
  String get humidityFairly;

  /// Sunset time label
  ///
  /// In en, this message translates to:
  /// **'Sunset: {time}'**
  String sunsetTime(String time);

  /// Wind direction label
  ///
  /// In en, this message translates to:
  /// **'{direction} wind'**
  String windDirection(String direction);

  /// No description provided for @windLightAir.
  ///
  /// In en, this message translates to:
  /// **'light air on the face'**
  String get windLightAir;

  /// No description provided for @windGentleBreeze.
  ///
  /// In en, this message translates to:
  /// **'gentle breeze on the face'**
  String get windGentleBreeze;

  /// No description provided for @windModerateBreeze.
  ///
  /// In en, this message translates to:
  /// **'moderate breeze on the face'**
  String get windModerateBreeze;

  /// No description provided for @windStrongBreeze.
  ///
  /// In en, this message translates to:
  /// **'strong breeze on the face'**
  String get windStrongBreeze;

  /// No description provided for @greatForRunning.
  ///
  /// In en, this message translates to:
  /// **'Great for running'**
  String get greatForRunning;

  /// No description provided for @tooHotForRunning.
  ///
  /// In en, this message translates to:
  /// **'Too hot for running'**
  String get tooHotForRunning;

  /// No description provided for @unsuitableForRunning.
  ///
  /// In en, this message translates to:
  /// **'Unsuitable for running'**
  String get unsuitableForRunning;

  /// No description provided for @idealFishing.
  ///
  /// In en, this message translates to:
  /// **'Ideal fishing conditions'**
  String get idealFishing;

  /// No description provided for @notIdealFishing.
  ///
  /// In en, this message translates to:
  /// **'Not ideal fishing'**
  String get notIdealFishing;

  /// No description provided for @excellentForHiking.
  ///
  /// In en, this message translates to:
  /// **'Excellent for hiking'**
  String get excellentForHiking;

  /// No description provided for @coldForHiking.
  ///
  /// In en, this message translates to:
  /// **'Cold for hiking'**
  String get coldForHiking;

  /// No description provided for @unsuitableForHiking.
  ///
  /// In en, this message translates to:
  /// **'Unsuitable for hiking'**
  String get unsuitableForHiking;

  /// No description provided for @airExcellentValue.
  ///
  /// In en, this message translates to:
  /// **'35 (Excellent)'**
  String get airExcellentValue;

  /// No description provided for @airGoodValue.
  ///
  /// In en, this message translates to:
  /// **'42 (Good)'**
  String get airGoodValue;

  /// No description provided for @airModerateValue.
  ///
  /// In en, this message translates to:
  /// **'68 (Moderate)'**
  String get airModerateValue;

  /// No description provided for @uvHighValue.
  ///
  /// In en, this message translates to:
  /// **'7 (High)'**
  String get uvHighValue;

  /// No description provided for @uvModerateValue.
  ///
  /// In en, this message translates to:
  /// **'3 (Moderate)'**
  String get uvModerateValue;

  /// No description provided for @uvLowValue.
  ///
  /// In en, this message translates to:
  /// **'1 (Low)'**
  String get uvLowValue;

  /// No description provided for @egypt.
  ///
  /// In en, this message translates to:
  /// **'Egypt'**
  String get egypt;

  /// No description provided for @kuwait.
  ///
  /// In en, this message translates to:
  /// **'Kuwait'**
  String get kuwait;

  /// No description provided for @ksa.
  ///
  /// In en, this message translates to:
  /// **'KSA'**
  String get ksa;

  /// No description provided for @qatar.
  ///
  /// In en, this message translates to:
  /// **'Qatar'**
  String get qatar;

  /// No description provided for @morocco.
  ///
  /// In en, this message translates to:
  /// **'Morocco'**
  String get morocco;

  /// Shows when cached data was last fetched
  ///
  /// In en, this message translates to:
  /// **'Last updated {time}'**
  String lastUpdated(String time);

  /// Time indicator for very recent updates
  ///
  /// In en, this message translates to:
  /// **'just now'**
  String get justNow;

  /// Time indicator for minutes ago
  ///
  /// In en, this message translates to:
  /// **'{count} min ago'**
  String minutesAgo(int count);

  /// Time indicator for hours ago
  ///
  /// In en, this message translates to:
  /// **'{count} hr ago'**
  String hoursAgo(int count);

  /// No description provided for @pageNotFound.
  ///
  /// In en, this message translates to:
  /// **'Page not found'**
  String get pageNotFound;

  /// No description provided for @searchAction.
  ///
  /// In en, this message translates to:
  /// **'Search'**
  String get searchAction;

  /// No description provided for @clearSearch.
  ///
  /// In en, this message translates to:
  /// **'Clear search'**
  String get clearSearch;

  /// No description provided for @openSettings.
  ///
  /// In en, this message translates to:
  /// **'Open settings'**
  String get openSettings;

  /// No description provided for @cachedWeather.
  ///
  /// In en, this message translates to:
  /// **'Showing saved weather'**
  String get cachedWeather;

  /// No description provided for @staleWeather.
  ///
  /// In en, this message translates to:
  /// **'Offline — showing older saved weather'**
  String get staleWeather;

  /// No description provided for @weatherDataAttribution.
  ///
  /// In en, this message translates to:
  /// **'Weather data provided by WeatherAPI.com'**
  String get weatherDataAttribution;

  /// No description provided for @weatherDataDisclaimer.
  ///
  /// In en, this message translates to:
  /// **'Forecasts are informational and may differ from actual conditions.'**
  String get weatherDataDisclaimer;

  /// No description provided for @errorMissingApiKey.
  ///
  /// In en, this message translates to:
  /// **'Weather service is not configured. Add WEATHER_API_KEY to the bundled build settings.'**
  String get errorMissingApiKey;
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) =>
      <String>['ar', 'en'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'ar':
      return AppLocalizationsAr();
    case 'en':
      return AppLocalizationsEn();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.',
  );
}
