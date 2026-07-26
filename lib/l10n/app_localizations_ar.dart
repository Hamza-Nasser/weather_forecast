// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Arabic (`ar`).
class AppLocalizationsAr extends AppLocalizations {
  AppLocalizationsAr([String locale = 'ar']) : super(locale);

  @override
  String get appTitle => 'تطبيق الطقس';

  @override
  String get errorSomethingWentWrong => 'حدث خطأ ما';

  @override
  String get errorNoInternetConnection => 'لا يوجد اتصال بالإنترنت';

  @override
  String get errorFetchData => 'خطأ أثناء الاتصال';

  @override
  String get errorBadRequest =>
      'طلب غير صالح، يرجى التحقق من طلبك وإعادة المحاولة';

  @override
  String get errorUnauthorized => 'غير مصرح به';

  @override
  String get errorConflict => 'حدث تعارض';

  @override
  String get errorInternalServer => 'خطأ داخلي في الخادم';

  @override
  String get errorServiceUnavailable =>
      'الخدمة غير متوفرة، يرجى المحاولة لاحقاً';

  @override
  String get errorReadFromDevice => 'تعذر القراءة من الجهاز';

  @override
  String get retry => 'إعادة المحاولة';

  @override
  String get noDataAvailable => 'لا توجد بيانات متاحة';

  @override
  String get home => 'الرئيسية';

  @override
  String get search => 'البحث';

  @override
  String get settings => 'الإعدادات';

  @override
  String get language => 'اللغة';

  @override
  String get english => 'الإنجليزية';

  @override
  String get arabic => 'العربية';

  @override
  String get weather => 'الطقس';

  @override
  String get searchCity => 'ابحث عن مدينة...';

  @override
  String get cancel => 'إلغاء';

  @override
  String get welcomeTitle => 'مرحباً بك في طقس هوما';

  @override
  String get welcomeSubtitle =>
      'ابحث عن أي مدينة لعرض تفاصيل الطقس الحالية والتوقعات بالساعة.';

  @override
  String get failedToLoadWeather => 'فشل في تحميل بيانات الطقس.';

  @override
  String get details => 'التفاصيل';

  @override
  String get realFeel => 'الإحساس الحقيقي';

  @override
  String get humidityLabel => 'الرطوبة';

  @override
  String get windForce => 'قوة الرياح';

  @override
  String get pressure => 'الضغط';

  @override
  String nDayForecast(int count) {
    return 'توقعات $count أيام';
  }

  @override
  String get today => 'اليوم';

  @override
  String get monday => 'الإثنين';

  @override
  String get tuesday => 'الثلاثاء';

  @override
  String get wednesday => 'الأربعاء';

  @override
  String get thursday => 'الخميس';

  @override
  String get friday => 'الجمعة';

  @override
  String get saturday => 'السبت';

  @override
  String get sunday => 'الأحد';

  @override
  String get uvIndex => 'مؤشر الأشعة فوق البنفسجية';

  @override
  String get feelsLike => 'الإحساس';

  @override
  String get wind => 'الرياح';

  @override
  String get sunriseLabel => 'شروق الشمس';

  @override
  String get visibility => 'الرؤية';

  @override
  String get moonPhaseLabel => 'طور القمر';

  @override
  String get lifestyle => 'نمط الحياة';

  @override
  String get low => 'منخفض';

  @override
  String get moderate => 'معتدل';

  @override
  String get high => 'مرتفع';

  @override
  String get weatherInsights => 'رؤى الطقس';

  @override
  String get uvIndexLabel => 'مؤشر الأشعة فوق البنفسجية';

  @override
  String get airQuality => 'جودة الهواء';

  @override
  String get clothing => 'الملابس';

  @override
  String get outdoorSport => 'الرياضة الخارجية';

  @override
  String get uvHighRisk => 'استخدم واقي الشمس والنظارات.';

  @override
  String get uvSafe => 'آمن للتواجد في الخارج.';

  @override
  String get airExcellent => 'هواء نقي، مناسب للمشي.';

  @override
  String get airModerate => 'خطر طفيف من غبار الرطوبة.';

  @override
  String get clothingHeavy => 'طبقات ثقيلة';

  @override
  String get clothingHeavyAdvice => 'يُنصح بمعطف دافئ وقفازات.';

  @override
  String get clothingJacket => 'جاكيت / هودي';

  @override
  String get clothingJacketAdvice => 'أكمام طويلة مريحة.';

  @override
  String get clothingLight => 'تي شيرت خفيف';

  @override
  String get clothingLightAdvice => 'مثالي للشورت والأقمشة المسامية.';

  @override
  String get sportNotRecommended => 'غير مستحسن';

  @override
  String get sportNotRecommendedAdvice => 'أرض مبللة ورؤية ضعيفة.';

  @override
  String get sportIndoor => 'داخلي فقط';

  @override
  String get sportIndoorAdvice => 'تحذير من الحرارة المفرطة.';

  @override
  String get sportExcellent => 'ممتاز';

  @override
  String get sportExcellentAdvice => 'مثالي للجري وركوب الدراجات في الخارج.';

  @override
  String get uvAlmostNoRisk => 'لا يوجد تقريباً خطر حروق الشمس';

  @override
  String get uvLowRisk => 'خطر منخفض من الأشعة فوق البنفسجية';

  @override
  String get uvModerateHighRisk => 'خطر متوسط إلى مرتفع من حروق الشمس';

  @override
  String get excellentVisibility => 'رؤية ممتازة';

  @override
  String get goodVisibility => 'رؤية جيدة';

  @override
  String get moderateVisibility => 'رؤية معتدلة';

  @override
  String get pressureStuffy => 'قد يشعر بالخنقة للأشخاص الحساسين';

  @override
  String get pressureStable => 'ظروف جوية مستقرة';

  @override
  String get pressureNormal => 'ضغط جوي طبيعي';

  @override
  String get newMoon => 'قمر جديد';

  @override
  String get noMoonrise => 'لا يوجد شروق قمر';

  @override
  String get feelsWarmer => 'يبدو أدفأ من الحرارة الفعلية';

  @override
  String get feelsCooler => 'يبدو أبرد من الحرارة الفعلية';

  @override
  String get feelsSimilar => 'يبدو مشابهاً للحرارة الفعلية';

  @override
  String actualTemperature(int temp) {
    return 'الحرارة الفعلية: $temp°';
  }

  @override
  String get humidityDry => 'هواء جاف، قد تشعر ببشرة جافة';

  @override
  String get humidityComfortable => 'مريح، مستويات رطوبة طبيعية';

  @override
  String get humidityFairly => 'رطوبة عالية نسبياً، التجفيف سيستغرق وقتاً أطول';

  @override
  String sunsetTime(String time) {
    return 'الغروب: $time';
  }

  @override
  String windDirection(String direction) {
    return 'رياح $direction';
  }

  @override
  String get windLightAir => 'نسيم خفيف على الوجه';

  @override
  String get windGentleBreeze => 'نسيم لطيف على الوجه';

  @override
  String get windModerateBreeze => 'نسيم معتدل على الوجه';

  @override
  String get windStrongBreeze => 'نسيم قوي على الوجه';

  @override
  String get greatForRunning => 'رائع للجري';

  @override
  String get tooHotForRunning => 'حار جداً للجري';

  @override
  String get unsuitableForRunning => 'غير مناسب للجري';

  @override
  String get idealFishing => 'ظروف صيد مثالية';

  @override
  String get notIdealFishing => 'غير مثالي للصيد';

  @override
  String get excellentForHiking => 'ممتاز للمشي لمسافات طويلة';

  @override
  String get coldForHiking => 'بارد للمشي لمسافات طويلة';

  @override
  String get unsuitableForHiking => 'غير مناسب للمشي لمسافات طويلة';

  @override
  String get airExcellentValue => '35 (ممتاز)';

  @override
  String get airGoodValue => '42 (جيد)';

  @override
  String get airModerateValue => '68 (معتدل)';

  @override
  String get uvHighValue => '7 (مرتفع)';

  @override
  String get uvModerateValue => '3 (معتدل)';

  @override
  String get uvLowValue => '1 (منخفض)';

  @override
  String get egypt => 'مصر';

  @override
  String get kuwait => 'الكويت';

  @override
  String get ksa => 'السعودية';

  @override
  String get qatar => 'قطر';

  @override
  String get morocco => 'المغرب';

  @override
  String lastUpdated(String time) {
    return 'آخر تحديث $time';
  }

  @override
  String get justNow => 'الآن';

  @override
  String minutesAgo(int count) {
    return 'منذ $count دقيقة';
  }

  @override
  String hoursAgo(int count) {
    return 'منذ $count ساعة';
  }
}
