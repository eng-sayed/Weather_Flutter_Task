import 'package:animated_widgets_flutter/widgets/opacity_animated.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../core/Router/Router.dart';
import '../../../../../core/localization/localization_helper.dart';
import '../../../cubit/splash_cubit.dart';
import '../../../cubit/splash_states.dart';

///// put it in routes
///  import '../../modules/splash/presentation/splash.dart';
/// static const String splashScreen = "/splashScreen";

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with WidgetsBindingObserver {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SplashCubit(),
      child: Scaffold(
        body: BlocConsumer<SplashCubit, SplashStates>(
          listener: (context, state) {},
          builder: (context, state) {
            return Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    const Color(0xFF2196F3), // Blue
                    const Color(0xFF1976D2), // Darker Blue
                    const Color(0xFF0D47A1), // Deep Blue
                  ],
                ),
              ),
              child: Center(
                child: OpacityAnimatedWidget.tween(
                  opacityEnabled: 1,
                  opacityDisabled: 0,
                  duration: const Duration(milliseconds: 2000),
                  enabled: true,
                  animationFinished: (finished) async {
                    if (mounted) {
                      Navigator.pushReplacementNamed(
                        context,
                        Routes.weatherHome,
                      );
                    }
                  },
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      // Weather Icon
                      Container(
                        padding: const EdgeInsets.all(30),
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.2),
                          shape: BoxShape.circle,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.2),
                              blurRadius: 20,
                              spreadRadius: 5,
                            ),
                          ],
                        ),
                        child: Icon(
                          Icons.wb_sunny_rounded,
                          size: 120,
                          color: Colors.amber[300],
                          shadows: [
                            Shadow(
                              color: Colors.amber.withOpacity(0.5),
                              blurRadius: 20,
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 40),
                      // App Name
                      Text(
                        LocalizationHelper.tr.weatherApp,
                        style: const TextStyle(
                          fontSize: 36,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                          letterSpacing: 2,
                          shadows: [
                            Shadow(
                              color: Colors.black26,
                              blurRadius: 10,
                              offset: Offset(0, 4),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 12),
                      // Subtitle
                      Text(
                        LocalizationHelper.tr.weatherCompanion,
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.white.withOpacity(0.9),
                          letterSpacing: 1,
                        ),
                      ),
                      const SizedBox(height: 60),
                      // Loading indicator
                      SizedBox(
                        width: 40,
                        height: 40,
                        child: CircularProgressIndicator(
                          strokeWidth: 3,
                          valueColor: AlwaysStoppedAnimation<Color>(
                            Colors.white.withOpacity(0.8),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
