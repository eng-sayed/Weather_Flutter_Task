import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:hive/hive.dart';

import '../localization/localization_helper.dart';
import '../style/app_theme.dart';
import '../style/base_theme.dart';
import '../style/light_mode/light_theme_colors.dart';
import '../style/dark_mode/dark_theme_colors.dart';

part 'general_state.dart';

class GeneralCubit extends Cubit<GeneralState> {
  GeneralCubit() : super(GeneralInitial()) {
    _loadTemperatureUnit();
  }
  static GeneralCubit get(context) => BlocProvider.of(context);

  String _temperatureUnit = 'celsius';
  String get temperatureUnit => _temperatureUnit;
  bool get isCelsius => _temperatureUnit == 'celsius';
  bool get isFahrenheit => _temperatureUnit == 'fahrenheit';

  BaseTheme get currentTheme => AppThemes().theme;
  bool get isLightMode => AppThemes().theme.name == 'light';
  bool get isDarkMode => AppThemes().theme.name == 'dark';

  Future<void> toggleTheme() async {
    final newTheme = isLightMode ? DarkTheme() : LightTheme();
    await changeAppTheme(newTheme);
  }

  Future<void> changeAppTheme(BaseTheme theme) async {
    await AppThemes().setTheme(theme);
    emit(GeneralChangeAppTheme(themeName: theme.name));
  }

  Future<void> setThemeByName(String themeName) async {
    final theme = themeName == 'dark' ? DarkTheme() : LightTheme();
    await changeAppTheme(theme);
  }

  changeLocale(String localeName) {
    if (LocalizationHelper.currentLocalName == localeName) return;
    LocalizationHelper.setLocale(localeName);
    emit(GeneralChangeLocale(locale: LocalizationHelper.currentLocalName));
  }

  Future<void> _loadTemperatureUnit() async {
    try {
      final box = await Hive.openBox('app_settings');
      _temperatureUnit = box.get('temperature_unit', defaultValue: 'celsius');
    } catch (e) {
      _temperatureUnit = 'celsius';
    }
  }

  Future<void> toggleTemperatureUnit() async {
    final newUnit = isCelsius ? 'fahrenheit' : 'celsius';
    await changeTemperatureUnit(newUnit);
  }

  Future<void> changeTemperatureUnit(String unit) async {
    if (unit != 'celsius' && unit != 'fahrenheit') return;
    _temperatureUnit = unit;
    try {
      final box = await Hive.openBox('app_settings');
      await box.put('temperature_unit', unit);
    } catch (e) {
      debugPrint('Error saving temperature unit: $e');
    }
    emit(GeneralChangeTemperatureUnit(unit: unit));
  }

  double celsiusToFahrenheit(double celsius) {
    return (celsius * 9 / 5) + 32;
  }

  double fahrenheitToCelsius(double fahrenheit) {
    return (fahrenheit - 32) * 5 / 9;
  }

  String formatTemperature(double celsius) {
    if (isCelsius) {
      return '${celsius.round()}°';
    } else {
      return '${celsiusToFahrenheit(celsius).round()}°';
    }
  }

  String get temperatureUnitSymbol => isCelsius ? 'C' : 'F';
}
