import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task_flutter/core/utils/Locator.dart';

// import '../../features/auth/presentation/screens/forget_password/forget_password_screen.dart';
// import '../../features/auth/presentation/screens/login/login_screen.dart';
// import '../../features/auth/presentation/screens/otp/otp_screen.dart';
// import '../../features/auth/presentation/screens/reset_password/reset_password_screen.dart';
// import '../../features/auth/presentation/screens/sign_up/sign_up_screen.dart';
import '../../features/splash/presentation/screens/splash/splash.dart';
import '../../features/weather/cubit/weather_cubit.dart';
import '../../features/weather/presentation/screens/home_screen.dart';
import '../../features/weather/presentation/screens/search_screen.dart';
import '../../features/weather/presentation/screens/favorites_screen.dart';

class Routes {
  static const String splashScreen = "/splashScreen";
  static const String onboardingScreen = "/onboardingScreen";
  static const String loginScreen = "loginScreen";
  static const String registerScreen = "registerScreen";
  static const String forgetPassScreen = "/forgetPassScreen";
  static const String otpScreen = "/OtpScreen";
  static const String layoutScreen = "/LayoutScreen";
  static const String resetPasswordScreen = "/ResetPasswordScreen";

  static const String homeScreen = "homeScreen";

  // Weather Routes
  static const String weatherHome = "/weatherHome";
  static const String weatherSearch = "/weatherSearch";
  static const String weatherFavorites = "/weatherFavorites";
}

class RouteGenerator {
  static String currentRoute = "";

  static Route<dynamic> getRoute(RouteSettings routeSettings) {
    currentRoute = routeSettings.name.toString();
    switch (routeSettings.name) {
      case Routes.splashScreen:
        return CupertinoPageRoute(
          settings: routeSettings,
          builder: (_) {
            return const SplashScreen();
          },
        );

      // case Routes.loginScreen:
      //   return CupertinoPageRoute(
      //     settings: routeSettings,
      //     builder: (_) {
      //       return const LoginScreen();
      //     },
      //   );
      // case Routes.resetPasswordScreen:
      //   return CupertinoPageRoute(
      //     settings: routeSettings,
      //     builder: (_) {
      //       return ResetPasswordScreen(
      //         code: (routeSettings.arguments as NewPasswordArgs).code,
      //         email: (routeSettings.arguments as NewPasswordArgs).email,
      //       );
      //     },
      //   );
      // case Routes.otpScreen:
      //   return CupertinoPageRoute(
      //     settings: routeSettings,
      //     builder: (_) {
      //       return OtpScreen(
      //         onReSend: (routeSettings.arguments as OtpArguments).onReSend,
      //         onSubmit: (routeSettings.arguments as OtpArguments).onSubmit,
      //         sendTo: (routeSettings.arguments as OtpArguments).sendTo,
      //         init: (routeSettings.arguments as OtpArguments).init,
      //       );
      //     },
      //   );
      // case Routes.forgetPassScreen:
      //   return CupertinoPageRoute(
      //     settings: routeSettings,
      //     builder: (_) {
      //       return const ForgetPasswordScreen();
      //     },
      //   );
      // case Routes.registerScreen:
      //   return CupertinoPageRoute(
      //     settings: routeSettings,
      //     builder: (_) {
      //       return const SignUpScreen();
      //     },
      //   );
      // case Routes.SplashScreen:
      //   return CupertinoPageRoute(
      //       settings: routeSettings,
      //       builder: (_) {
      //         return const SplashScreen();
      //       });

      // Weather Routes
      case Routes.weatherHome:
        return CupertinoPageRoute(
          settings: routeSettings,
          builder: (_) {
            return BlocProvider(
              create: (_) => locator<WeatherCubit>(),
              child: const WeatherHomeScreen(),
            );
          },
        );
      case Routes.weatherSearch:
        return CupertinoPageRoute(
          settings: routeSettings,
          builder: (_) {
            return const SearchScreen();
          },
        );
      case Routes.weatherFavorites:
        return CupertinoPageRoute(
          settings: routeSettings,
          builder: (_) {
            return const FavoritesScreen();
          },
        );

      default:
        return unDefinedRoute();
    }
  }

  static Route<dynamic> getNestedRoute(RouteSettings routeSettings) {
    currentRoute = routeSettings.name.toString();
    switch (routeSettings.name) {
      default:
        return unDefinedRoute();
    }
  }

  static Route<dynamic> unDefinedRoute() {
    return CupertinoPageRoute(
      builder:
          (_) => Scaffold(
            appBar: AppBar(title: const Text("مسار غير موجود")),
            body: const Center(child: Text("مسار غير موجود")),
          ),
    );
  }
}

class OtpArguments {
  final String sendTo;
  final bool? init;
  final dynamic Function(String) onSubmit;
  final void Function() onReSend;

  OtpArguments({
    required this.sendTo,
    required this.onSubmit,
    required this.onReSend,
    this.init,
  });
}

class NewPasswordArgs {
  final String code;
  final String email;
  const NewPasswordArgs({required this.code, required this.email});
}
