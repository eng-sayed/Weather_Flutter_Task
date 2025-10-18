import 'dart:async';
import 'dart:developer';

import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'core/Router/logging_route_observer.dart';
import 'core/Router/navigation_helper.dart';
import 'core/data_source/hive_service.dart';
import 'core/general/general_cubit.dart';
import 'core/localization/generated/app_localizations.dart';
import 'core/localization/localization_helper.dart';
import 'core/Router/Router.dart';
import 'core/utils/Locator.dart';
import 'core/utils/general_constants.dart';
import 'core/utils/responsive_framework_widget.dart';
import 'core/utils/utils.dart';
import 'features/weather/domain/model/favorite_city_model.dart';

Future<void> main() async {
  runZonedGuarded(() async {
    WidgetsFlutterBinding.ensureInitialized();

    // أولاً: ابدأ HiveService ومرر اسم البوكس المطلوب
    await HiveService.init([GeneralConstants.appBoxName]);

    // Register Hive adapter for weather favorites
    Hive.registerAdapter(FavoriteCityModelAdapter());

    // Open the weather favorites box
    await Hive.openBox<FavoriteCityModel>('weather_favorites');

    // بعد كده سجل بقية الخدمات
    await setupLocator();

    // bloc observer
    Bloc.observer = MyBlocObserver();

    // بعد التأكد إن البوكس مفتوح
    await Utils.initTheme();

    runApp(const MyApp());
  }, (error, stackTrace) => log(error.toString(), stackTrace: stackTrace));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: BlocProvider(
        create: (context) => locator<GeneralCubit>(),
        child: BlocConsumer<GeneralCubit, GeneralState>(
          listener: (context, state) {
            // Listen to theme changes
            if (state is GeneralChangeAppTheme) {
              debugPrint('Theme changed to: ${state.themeName}');
            }
          },
          buildWhen: (previous, current) {
            // Rebuild when theme or locale changes
            return current is GeneralChangeAppTheme ||
                current is GeneralChangeLocale;
          },
          builder: (context, state) {
            final cubit = GeneralCubit.get(context);
            return MaterialApp(
              title: 'Weather Forecast',
              navigatorObservers: [LoggingRouteObserver()],
              themeAnimationDuration: const Duration(milliseconds: 700),
              themeAnimationCurve: Curves.easeInOutCubic,
              debugShowCheckedModeBanner: false,
              localizationsDelegates: [
                ...AppLocalizations.localizationsDelegates,
                LocalizationHelper.delegate,
              ],
              locale: LocalizationHelper.currentLocale,
              localeResolutionCallback: (locale, supportedLocales) {
                for (var supportedLocale in supportedLocales) {
                  if (supportedLocale.languageCode == locale?.languageCode &&
                      supportedLocale.countryCode == locale?.countryCode) {
                    return supportedLocale;
                  }
                }
                return supportedLocales.first;
              },
              navigatorKey: NavigationService.navigatorKey,

              supportedLocales: AppLocalizations.supportedLocales,
              builder: (_, child) {
                final botToastBuilder = BotToastInit();
                final smartDialog = FlutterSmartDialog.init();
                child = smartDialog(context, child);
                child = botToastBuilder(context, child);
                SystemChrome.setSystemUIOverlayStyle(
                  cubit.isLightMode
                      ? SystemUiOverlayStyle.dark
                      : SystemUiOverlayStyle.light,
                );
                return AppResponsiveWrapper(child: child);
              },
              onGenerateRoute: RouteGenerator.getRoute,
              // Use current theme from AppThemes
              theme: cubit.currentTheme.appTheme,
              initialRoute: Routes.splashScreen,
            );
          },
        ),
      ),
    );
  }
}

class MyBlocObserver extends BlocObserver {
  static final _logger = debugPrint;

  @override
  void onCreate(BlocBase bloc) {
    super.onCreate(bloc);
    if (kDebugMode) _logger('onCreate -- ${bloc.runtimeType}');
  }

  @override
  void onChange(BlocBase bloc, Change change) {
    super.onChange(bloc, change);
    if (kDebugMode) _logger('onChange -- ${bloc.runtimeType} -- $change');
  }

  @override
  void onError(BlocBase bloc, Object error, StackTrace stackTrace) {
    _logger('onError -- ${bloc.runtimeType} -- $error');
    super.onError(bloc, error, stackTrace);
  }

  @override
  void onClose(BlocBase bloc) {
    if (kDebugMode) _logger('onClose -- ${bloc.runtimeType}');
    super.onClose(bloc);
  }
}
