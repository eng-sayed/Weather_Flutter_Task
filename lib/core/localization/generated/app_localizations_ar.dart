// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Arabic (`ar`).
class AppLocalizationsAr extends AppLocalizations {
  AppLocalizationsAr([String locale = 'ar']) : super(locale);

  @override
  String get unexpectedError => 'حدث خطأ غير متوقع.';

  @override
  String get unknownError =>
      'حدث خطأ غير معروف، يرجى التحقق من اتصالك بالإنترنت.';

  @override
  String get connectionTimeout => 'انتهت مهلة الاتصال. حاول مرة أخرى.';

  @override
  String get badCertificate => 'شهادة الأمان غير صالحة.';

  @override
  String get requestCanceled => 'تم إلغاء الطلب.';

  @override
  String get serverError => 'خطأ في الخادم.';

  @override
  String get noNetwork => 'لا يوجد اتصال. يرجى التحقق من الشبكة.';

  @override
  String get pickLocation => 'اختر الموقع';

  @override
  String get requiredField => 'هذا الحقل مطلوب';

  @override
  String get requiredPhone => 'الهاتف مطلوب';

  @override
  String get phoneDoseNotMatch => 'الهاتف غير متطابق';

  @override
  String get requiredEmail => 'البريد الالكتروني مطلوب';

  @override
  String get wrongEmailValidation => 'البريد الالكتروني غير صحيح';

  @override
  String get requiredPassword => 'كلمة المرور مطلوبة';

  @override
  String get smallPassword => 'كلمة المرور قصيرة جدا';

  @override
  String get confirmPassword => 'تأكيد كلمة المرور';

  @override
  String get passwordNotMatch => 'كلمة المرور غير متطابقة';

  @override
  String get camera => 'الكاميرا';

  @override
  String get gallery => 'المعرض';

  @override
  String get noImageSelected => 'لم يتم اختيار صورة.';

  @override
  String get mediaPickError => 'حدث خطأ أثناء اختيار الصورة.';

  @override
  String get permissionRequired => 'مطلوب إذن';

  @override
  String get enablePermissions =>
      'يرجى تمكين الأذونات المطلوبة من إعدادات التطبيق.';

  @override
  String get cancel => 'إلغاء';

  @override
  String get settings => 'الإعدادات';

  @override
  String get parsingError => 'حدث خطأ أثناء معالجة البيانات';

  @override
  String get weather => 'الطقس';

  @override
  String get weatherForecast => 'توقعات الطقس';

  @override
  String get searchCity => 'ابحث عن مدينة';

  @override
  String get searchCityPlaceholder => 'أدخل اسم المدينة...';

  @override
  String get searchCityHint => 'ابحث عن مدينة...';

  @override
  String get favorites => 'المفضلة';

  @override
  String get favoriteCities => 'المدن المفضلة';

  @override
  String get temperature => 'درجة الحرارة';

  @override
  String get humidity => 'الرطوبة';

  @override
  String get windSpeed => 'سرعة الرياح';

  @override
  String get wind => 'الرياح';

  @override
  String get feelsLike => 'تشعر كأنها';

  @override
  String get pressure => 'الضغط الجوي';

  @override
  String get visibility => 'الرؤية';

  @override
  String get forecast => 'توقعات 5 أيام';

  @override
  String get addToFavorites => 'أضف للمفضلة';

  @override
  String get removeFromFavorites => 'إزالة من المفضلة';

  @override
  String get maxFavoritesReached => 'الحد الأقصى 5 مدن';

  @override
  String get cityAlreadyInFavorites => 'المدينة موجودة في المفضلة';

  @override
  String get addedToFavorites => 'تمت الإضافة للمفضلة';

  @override
  String get removedFromFavorites => 'تمت الإزالة من المفضلة';

  @override
  String get failedToAddFavorite => 'فشل في الإضافة للمفضلة';

  @override
  String get failedToRemoveFavorite => 'فشل في الإزالة من المفضلة';

  @override
  String get noFavoritesYet => 'لا توجد مدن مفضلة بعد';

  @override
  String get noFavoritesDescription => 'أضف مدنًا لمفضلتك لرؤيتها هنا';

  @override
  String get noWeatherData => 'لا توجد بيانات طقس';

  @override
  String get noWeatherDataDescription => 'ابحث عن مدينة لرؤية معلومات الطقس';

  @override
  String get cityNotFound => 'المدينة غير موجودة';

  @override
  String get cityNotFoundDescription => 'يرجى التحقق من اسم المدينة';

  @override
  String get searchForCity => 'ابحث عن مدينة';

  @override
  String get searchForCityDescription => 'أدخل اسم مدينة لرؤية الطقس';

  @override
  String get noResultsFound => 'لم يتم العثور على نتائج';

  @override
  String get noResultsFoundDescription => 'جرب البحث عن مدينة أخرى';

  @override
  String get additionalDetails => 'تفاصيل إضافية';

  @override
  String get seeAll => 'عرض الكل';

  @override
  String get retry => 'إعادة المحاولة';

  @override
  String get goBack => 'رجوع';

  @override
  String get dataError => 'يوجد مشكلة في البيانات';

  @override
  String get weatherApp => 'تطبيق الطقس';

  @override
  String get weatherCompanion => 'رفيقك اليومي للطقس';

  @override
  String get loading => 'جاري التحميل...';

  @override
  String get failedToFetchWeather => 'فشل في جلب بيانات الطقس';

  @override
  String get failedToFetchForecast => 'فشل في جلب بيانات التوقعات';

  @override
  String get added => 'تمت الإضافة';

  @override
  String get today => 'اليوم';

  @override
  String get yesterday => 'أمس';

  @override
  String get daysAgo => 'أيام مضت';

  @override
  String get darkMode => 'الوضع الداكن';

  @override
  String get lightMode => 'الوضع الفاتح';

  @override
  String get changeAppearance => 'تغيير المظهر';

  @override
  String get cities => 'مدن';

  @override
  String get noFavorites => 'لا توجد مدن مفضلة';

  @override
  String get language => 'اللغة';

  @override
  String get appSettings => 'إعدادات التطبيق';

  @override
  String get comingSoon => 'قريباً...';

  @override
  String get selectLanguage => 'اختر اللغة';

  @override
  String get arabic => 'العربية';

  @override
  String get english => 'English';

  @override
  String get temperatureUnit => 'وحدة الحرارة';

  @override
  String get celsius => 'مئوية';

  @override
  String get fahrenheit => 'فهرنهايت';

  @override
  String get changeUnit => 'تغيير الوحدة';
}
