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
/// import 'generated/app_localizations.dart';
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

  static AppLocalizations of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations)!;
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

  /// No description provided for @unexpectedError.
  ///
  /// In ar, this message translates to:
  /// **'حدث خطأ غير متوقع.'**
  String get unexpectedError;

  /// No description provided for @unknownError.
  ///
  /// In ar, this message translates to:
  /// **'حدث خطأ غير معروف، يرجى التحقق من اتصالك بالإنترنت.'**
  String get unknownError;

  /// No description provided for @connectionTimeout.
  ///
  /// In ar, this message translates to:
  /// **'انتهت مهلة الاتصال. حاول مرة أخرى.'**
  String get connectionTimeout;

  /// No description provided for @badCertificate.
  ///
  /// In ar, this message translates to:
  /// **'شهادة الأمان غير صالحة.'**
  String get badCertificate;

  /// No description provided for @requestCanceled.
  ///
  /// In ar, this message translates to:
  /// **'تم إلغاء الطلب.'**
  String get requestCanceled;

  /// No description provided for @serverError.
  ///
  /// In ar, this message translates to:
  /// **'خطأ في الخادم.'**
  String get serverError;

  /// No description provided for @noNetwork.
  ///
  /// In ar, this message translates to:
  /// **'لا يوجد اتصال. يرجى التحقق من الشبكة.'**
  String get noNetwork;

  /// No description provided for @pickLocation.
  ///
  /// In ar, this message translates to:
  /// **'اختر الموقع'**
  String get pickLocation;

  /// No description provided for @requiredField.
  ///
  /// In ar, this message translates to:
  /// **'هذا الحقل مطلوب'**
  String get requiredField;

  /// No description provided for @requiredPhone.
  ///
  /// In ar, this message translates to:
  /// **'الهاتف مطلوب'**
  String get requiredPhone;

  /// No description provided for @phoneDoseNotMatch.
  ///
  /// In ar, this message translates to:
  /// **'الهاتف غير متطابق'**
  String get phoneDoseNotMatch;

  /// No description provided for @requiredEmail.
  ///
  /// In ar, this message translates to:
  /// **'البريد الالكتروني مطلوب'**
  String get requiredEmail;

  /// No description provided for @wrongEmailValidation.
  ///
  /// In ar, this message translates to:
  /// **'البريد الالكتروني غير صحيح'**
  String get wrongEmailValidation;

  /// No description provided for @requiredPassword.
  ///
  /// In ar, this message translates to:
  /// **'كلمة المرور مطلوبة'**
  String get requiredPassword;

  /// No description provided for @smallPassword.
  ///
  /// In ar, this message translates to:
  /// **'كلمة المرور قصيرة جدا'**
  String get smallPassword;

  /// No description provided for @confirmPassword.
  ///
  /// In ar, this message translates to:
  /// **'تأكيد كلمة المرور'**
  String get confirmPassword;

  /// No description provided for @passwordNotMatch.
  ///
  /// In ar, this message translates to:
  /// **'كلمة المرور غير متطابقة'**
  String get passwordNotMatch;

  /// No description provided for @camera.
  ///
  /// In ar, this message translates to:
  /// **'الكاميرا'**
  String get camera;

  /// No description provided for @gallery.
  ///
  /// In ar, this message translates to:
  /// **'المعرض'**
  String get gallery;

  /// No description provided for @noImageSelected.
  ///
  /// In ar, this message translates to:
  /// **'لم يتم اختيار صورة.'**
  String get noImageSelected;

  /// No description provided for @mediaPickError.
  ///
  /// In ar, this message translates to:
  /// **'حدث خطأ أثناء اختيار الصورة.'**
  String get mediaPickError;

  /// No description provided for @permissionRequired.
  ///
  /// In ar, this message translates to:
  /// **'مطلوب إذن'**
  String get permissionRequired;

  /// No description provided for @enablePermissions.
  ///
  /// In ar, this message translates to:
  /// **'يرجى تمكين الأذونات المطلوبة من إعدادات التطبيق.'**
  String get enablePermissions;

  /// No description provided for @cancel.
  ///
  /// In ar, this message translates to:
  /// **'إلغاء'**
  String get cancel;

  /// No description provided for @settings.
  ///
  /// In ar, this message translates to:
  /// **'الإعدادات'**
  String get settings;

  /// No description provided for @parsingError.
  ///
  /// In ar, this message translates to:
  /// **'حدث خطأ أثناء معالجة البيانات'**
  String get parsingError;

  /// No description provided for @weather.
  ///
  /// In ar, this message translates to:
  /// **'الطقس'**
  String get weather;

  /// No description provided for @weatherForecast.
  ///
  /// In ar, this message translates to:
  /// **'توقعات الطقس'**
  String get weatherForecast;

  /// No description provided for @searchCity.
  ///
  /// In ar, this message translates to:
  /// **'ابحث عن مدينة'**
  String get searchCity;

  /// No description provided for @searchCityPlaceholder.
  ///
  /// In ar, this message translates to:
  /// **'أدخل اسم المدينة...'**
  String get searchCityPlaceholder;

  /// No description provided for @searchCityHint.
  ///
  /// In ar, this message translates to:
  /// **'ابحث عن مدينة...'**
  String get searchCityHint;

  /// No description provided for @favorites.
  ///
  /// In ar, this message translates to:
  /// **'المفضلة'**
  String get favorites;

  /// No description provided for @favoriteCities.
  ///
  /// In ar, this message translates to:
  /// **'المدن المفضلة'**
  String get favoriteCities;

  /// No description provided for @temperature.
  ///
  /// In ar, this message translates to:
  /// **'درجة الحرارة'**
  String get temperature;

  /// No description provided for @humidity.
  ///
  /// In ar, this message translates to:
  /// **'الرطوبة'**
  String get humidity;

  /// No description provided for @windSpeed.
  ///
  /// In ar, this message translates to:
  /// **'سرعة الرياح'**
  String get windSpeed;

  /// No description provided for @wind.
  ///
  /// In ar, this message translates to:
  /// **'الرياح'**
  String get wind;

  /// No description provided for @feelsLike.
  ///
  /// In ar, this message translates to:
  /// **'تشعر كأنها'**
  String get feelsLike;

  /// No description provided for @pressure.
  ///
  /// In ar, this message translates to:
  /// **'الضغط الجوي'**
  String get pressure;

  /// No description provided for @visibility.
  ///
  /// In ar, this message translates to:
  /// **'الرؤية'**
  String get visibility;

  /// No description provided for @forecast.
  ///
  /// In ar, this message translates to:
  /// **'توقعات 5 أيام'**
  String get forecast;

  /// No description provided for @addToFavorites.
  ///
  /// In ar, this message translates to:
  /// **'أضف للمفضلة'**
  String get addToFavorites;

  /// No description provided for @removeFromFavorites.
  ///
  /// In ar, this message translates to:
  /// **'إزالة من المفضلة'**
  String get removeFromFavorites;

  /// No description provided for @maxFavoritesReached.
  ///
  /// In ar, this message translates to:
  /// **'الحد الأقصى 5 مدن'**
  String get maxFavoritesReached;

  /// No description provided for @cityAlreadyInFavorites.
  ///
  /// In ar, this message translates to:
  /// **'المدينة موجودة في المفضلة'**
  String get cityAlreadyInFavorites;

  /// No description provided for @addedToFavorites.
  ///
  /// In ar, this message translates to:
  /// **'تمت الإضافة للمفضلة'**
  String get addedToFavorites;

  /// No description provided for @removedFromFavorites.
  ///
  /// In ar, this message translates to:
  /// **'تمت الإزالة من المفضلة'**
  String get removedFromFavorites;

  /// No description provided for @failedToAddFavorite.
  ///
  /// In ar, this message translates to:
  /// **'فشل في الإضافة للمفضلة'**
  String get failedToAddFavorite;

  /// No description provided for @failedToRemoveFavorite.
  ///
  /// In ar, this message translates to:
  /// **'فشل في الإزالة من المفضلة'**
  String get failedToRemoveFavorite;

  /// No description provided for @noFavoritesYet.
  ///
  /// In ar, this message translates to:
  /// **'لا توجد مدن مفضلة بعد'**
  String get noFavoritesYet;

  /// No description provided for @noFavoritesDescription.
  ///
  /// In ar, this message translates to:
  /// **'أضف مدنًا لمفضلتك لرؤيتها هنا'**
  String get noFavoritesDescription;

  /// No description provided for @noWeatherData.
  ///
  /// In ar, this message translates to:
  /// **'لا توجد بيانات طقس'**
  String get noWeatherData;

  /// No description provided for @noWeatherDataDescription.
  ///
  /// In ar, this message translates to:
  /// **'ابحث عن مدينة لرؤية معلومات الطقس'**
  String get noWeatherDataDescription;

  /// No description provided for @cityNotFound.
  ///
  /// In ar, this message translates to:
  /// **'المدينة غير موجودة'**
  String get cityNotFound;

  /// No description provided for @cityNotFoundDescription.
  ///
  /// In ar, this message translates to:
  /// **'يرجى التحقق من اسم المدينة'**
  String get cityNotFoundDescription;

  /// No description provided for @searchForCity.
  ///
  /// In ar, this message translates to:
  /// **'ابحث عن مدينة'**
  String get searchForCity;

  /// No description provided for @searchForCityDescription.
  ///
  /// In ar, this message translates to:
  /// **'أدخل اسم مدينة لرؤية الطقس'**
  String get searchForCityDescription;

  /// No description provided for @noResultsFound.
  ///
  /// In ar, this message translates to:
  /// **'لم يتم العثور على نتائج'**
  String get noResultsFound;

  /// No description provided for @noResultsFoundDescription.
  ///
  /// In ar, this message translates to:
  /// **'جرب البحث عن مدينة أخرى'**
  String get noResultsFoundDescription;

  /// No description provided for @additionalDetails.
  ///
  /// In ar, this message translates to:
  /// **'تفاصيل إضافية'**
  String get additionalDetails;

  /// No description provided for @seeAll.
  ///
  /// In ar, this message translates to:
  /// **'عرض الكل'**
  String get seeAll;

  /// No description provided for @retry.
  ///
  /// In ar, this message translates to:
  /// **'إعادة المحاولة'**
  String get retry;

  /// No description provided for @goBack.
  ///
  /// In ar, this message translates to:
  /// **'رجوع'**
  String get goBack;

  /// No description provided for @dataError.
  ///
  /// In ar, this message translates to:
  /// **'يوجد مشكلة في البيانات'**
  String get dataError;

  /// No description provided for @weatherApp.
  ///
  /// In ar, this message translates to:
  /// **'تطبيق الطقس'**
  String get weatherApp;

  /// No description provided for @weatherCompanion.
  ///
  /// In ar, this message translates to:
  /// **'رفيقك اليومي للطقس'**
  String get weatherCompanion;

  /// No description provided for @loading.
  ///
  /// In ar, this message translates to:
  /// **'جاري التحميل...'**
  String get loading;

  /// No description provided for @failedToFetchWeather.
  ///
  /// In ar, this message translates to:
  /// **'فشل في جلب بيانات الطقس'**
  String get failedToFetchWeather;

  /// No description provided for @failedToFetchForecast.
  ///
  /// In ar, this message translates to:
  /// **'فشل في جلب بيانات التوقعات'**
  String get failedToFetchForecast;

  /// No description provided for @added.
  ///
  /// In ar, this message translates to:
  /// **'تمت الإضافة'**
  String get added;

  /// No description provided for @today.
  ///
  /// In ar, this message translates to:
  /// **'اليوم'**
  String get today;

  /// No description provided for @yesterday.
  ///
  /// In ar, this message translates to:
  /// **'أمس'**
  String get yesterday;

  /// No description provided for @daysAgo.
  ///
  /// In ar, this message translates to:
  /// **'أيام مضت'**
  String get daysAgo;

  /// No description provided for @darkMode.
  ///
  /// In ar, this message translates to:
  /// **'الوضع الداكن'**
  String get darkMode;

  /// No description provided for @lightMode.
  ///
  /// In ar, this message translates to:
  /// **'الوضع الفاتح'**
  String get lightMode;

  /// No description provided for @changeAppearance.
  ///
  /// In ar, this message translates to:
  /// **'تغيير المظهر'**
  String get changeAppearance;

  /// No description provided for @cities.
  ///
  /// In ar, this message translates to:
  /// **'مدن'**
  String get cities;

  /// No description provided for @noFavorites.
  ///
  /// In ar, this message translates to:
  /// **'لا توجد مدن مفضلة'**
  String get noFavorites;

  /// No description provided for @language.
  ///
  /// In ar, this message translates to:
  /// **'اللغة'**
  String get language;

  /// No description provided for @appSettings.
  ///
  /// In ar, this message translates to:
  /// **'إعدادات التطبيق'**
  String get appSettings;

  /// No description provided for @comingSoon.
  ///
  /// In ar, this message translates to:
  /// **'قريباً...'**
  String get comingSoon;

  /// No description provided for @selectLanguage.
  ///
  /// In ar, this message translates to:
  /// **'اختر اللغة'**
  String get selectLanguage;

  /// No description provided for @arabic.
  ///
  /// In ar, this message translates to:
  /// **'العربية'**
  String get arabic;

  /// No description provided for @english.
  ///
  /// In ar, this message translates to:
  /// **'English'**
  String get english;

  /// No description provided for @temperatureUnit.
  ///
  /// In ar, this message translates to:
  /// **'وحدة الحرارة'**
  String get temperatureUnit;

  /// No description provided for @celsius.
  ///
  /// In ar, this message translates to:
  /// **'مئوية'**
  String get celsius;

  /// No description provided for @fahrenheit.
  ///
  /// In ar, this message translates to:
  /// **'فهرنهايت'**
  String get fahrenheit;

  /// No description provided for @changeUnit.
  ///
  /// In ar, this message translates to:
  /// **'تغيير الوحدة'**
  String get changeUnit;
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
