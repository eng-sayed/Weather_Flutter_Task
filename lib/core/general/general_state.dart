part of 'general_cubit.dart';

@immutable
abstract class GeneralState {}

class GeneralInitial extends GeneralState {}

class GeneralChangeAppTheme extends GeneralState {
  final String themeName;
  GeneralChangeAppTheme({required this.themeName});
}

class GeneralChangeLocale extends GeneralState {
  final String locale;
  GeneralChangeLocale({required this.locale});
}

class GeneralChangeTemperatureUnit extends GeneralState {
  final String unit;
  GeneralChangeTemperatureUnit({required this.unit});
}
