class WeatherEndpoints {
  static const String currentWeather = '/weather';
  static const String forecast = '/forecast';
  static const String iconUrl = 'https://openweathermap.org/img/wn/';

  // Get icon URL
  static String getIconUrl(String iconCode, {bool large = false}) {
    return '$iconUrl$iconCode${large ? '@4x' : '@2x'}.png';
  }
}
