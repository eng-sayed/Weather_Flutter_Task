import 'package:flutter/material.dart';

import '../base_theme.dart';
import 'dark_theme.dart';

class DarkTheme implements BaseTheme {
  @override
  ThemeData get appTheme => darkApplicationTheme;
  @override
  String get name => "dark";

  @override
  Color get primary => const Color(0xFF7CB342); // Green accent for dark mode
  @override
  Color get btmNavSelectedIconColor => const Color(0xFF7CB342);
  @override
  Color get primaryLight => const Color(0xFF9CCC65);
  @override
  Color get primaryDark => const Color(0xFF558B2F);

  @override
  Color get secondary => const Color(0xFF8C9EFF);
  @override
  Color get secondaryLight => const Color(0xFFB0BEC5);
  @override
  Color get secondaryDark => const Color(0xFF5C6BC0);
  @override
  Color get textHint => const Color(0xFFB0B0B0);
  @override
  Color get background => const Color(0xFF1A1A1A); // Softer dark background

  @override
  Color get error => const Color(0xFFEF5350);

  @override
  Color get success => const Color(0xFF66BB6A);

  @override
  Color get white => const Color(0xFF2D2D2D); // Dark cards background
  @override
  Color get transparent => Colors.transparent;

  @override
  Color get grey => const Color(0xFF9E9E9E);

  @override
  Color get greyDark => const Color(0xFF424242);
  @override
  Color get greySemiLight => const Color(0xFF2D2D2D);
  @override
  Color get greyExtraDark => const Color(0xFF1A1A1A);

  @override
  Color get greyExtraDarkWithOpacity => const Color(0xD51A1A1A);

  @override
  Color get greyExtraLight => const Color(0xFF424242);

  @override
  Color get greyLight => const Color(0xFF616161);

  @override
  Color get blue => const Color(0xFF42A5F5);

  @override
  Color get blueExtraLight => const Color(0xFF1E3A5F);

  @override
  Color get blueLight => const Color(0xFF64B5F6);

  @override
  Color get orangeExtraLight => const Color(0xFF4E342E);

  @override
  Color get orangeLight => const Color(0xFFFF9800);
  @override
  Color get orangeDark => const Color(0xFFE65100);

  @override
  Color get containerShadow => const Color(0x66000000); // 40%

  @override
  Color get defaultButtonShadow => const Color(0x40000000); // Stronger shadow for dark mode

  @override
  Color get defaultContainerShadow => const Color(0x50000000); // 31%

  @override
  Color get defaultStatesBarShadow => const Color(0x40000000); // 25%

  @override
  Color get progressBackColor => const Color(0xFF37474F);

  @override
  Color get black => const Color(0xFFE0E0E0); // Text color (light gray for readability)
  @override
  Color get lightBlack => const Color(0xFFB0B0B0);

  @override
  Color get blackWithOpacity => const Color(0x33E0E0E0);

  @override
  Color get green => const Color(0xFF4CAF50);

  @override
  Color get greenDark => const Color(0xFF2E7D32);

  @override
  Color get greenFaded => const Color(0xFF81C784);

  @override
  Color get greenLight => const Color(0xFF66BB6A);

  @override
  Color cyan = const Color(0xFF00BCD4);

  @override
  Color heavyBlueColor = const Color(0xFFE0E0E0);

  @override
  Color red = const Color(0xFFEF5350);

  @override
  Color darkBlue = const Color(0xFF1976D2);

  @override
  Color darkRed = const Color(0xFFD32F2F);

  @override
  Color darkYellow = const Color(0xFFFFA726);

  @override
  Color orange = const Color(0xFFFF7043);

  @override
  Color orangeFaded = const Color(0xFFFFAB91);

  @override
  Color pink = const Color(0xFFEC407A);

  @override
  Color purple = const Color(0xFF7E57C2);

  @override
  Color redFaded = const Color(0xFFE57373);

  @override
  Color yellow = const Color(0xFFFFEB3B);
}
