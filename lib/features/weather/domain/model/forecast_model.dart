class ForecastModel {
  final String cityName;
  final String countryCode;
  final List<ForecastItem> forecastList;

  ForecastModel({
    required this.cityName,
    required this.countryCode,
    required this.forecastList,
  });

  factory ForecastModel.fromJson(Map<String, dynamic> json) {
    final List<dynamic> list = json['list'] ?? [];
    final List<ForecastItem> items =
        list.map((item) => ForecastItem.fromJson(item)).toList();

    return ForecastModel(
      cityName: json['city']?['name'] ?? '',
      countryCode: json['city']?['country'] ?? '',
      forecastList: items,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'city': {'name': cityName, 'country': countryCode},
      'list': forecastList.map((item) => item.toJson()).toList(),
    };
  }

  // Group forecast by day (for 5-day display)
  List<DailyForecast> getDailyForecasts() {
    Map<String, List<ForecastItem>> groupedByDay = {};

    for (var item in forecastList) {
      String dateKey = _formatDate(item.dateTime);
      if (groupedByDay[dateKey] == null) {
        groupedByDay[dateKey] = [];
      }
      groupedByDay[dateKey]!.add(item);
    }

    List<DailyForecast> dailyForecasts = [];
    groupedByDay.forEach((date, items) {
      dailyForecasts.add(DailyForecast(date: date, forecasts: items));
    });

    return dailyForecasts;
  }

  String _formatDate(DateTime date) {
    return '${date.year}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}';
  }
}

class ForecastItem {
  final DateTime dateTime;
  final double temperature;
  final double feelsLike;
  final double tempMin;
  final double tempMax;
  final int humidity;
  final double windSpeed;
  final String weatherMain;
  final String weatherDescription;
  final String icon;
  final int pressure;

  ForecastItem({
    required this.dateTime,
    required this.temperature,
    required this.feelsLike,
    required this.tempMin,
    required this.tempMax,
    required this.humidity,
    required this.windSpeed,
    required this.weatherMain,
    required this.weatherDescription,
    required this.icon,
    required this.pressure,
  });

  factory ForecastItem.fromJson(Map<String, dynamic> json) {
    return ForecastItem(
      dateTime: DateTime.fromMillisecondsSinceEpoch((json['dt'] ?? 0) * 1000),
      temperature: (json['main']?['temp'] ?? 0).toDouble(),
      feelsLike: (json['main']?['feels_like'] ?? 0).toDouble(),
      tempMin: (json['main']?['temp_min'] ?? 0).toDouble(),
      tempMax: (json['main']?['temp_max'] ?? 0).toDouble(),
      humidity: json['main']?['humidity'] ?? 0,
      windSpeed: (json['wind']?['speed'] ?? 0).toDouble(),
      weatherMain: json['weather']?[0]?['main'] ?? '',
      weatherDescription: json['weather']?[0]?['description'] ?? '',
      icon: json['weather']?[0]?['icon'] ?? '01d',
      pressure: json['main']?['pressure'] ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'dt': dateTime.millisecondsSinceEpoch ~/ 1000,
      'main': {
        'temp': temperature,
        'feels_like': feelsLike,
        'temp_min': tempMin,
        'temp_max': tempMax,
        'humidity': humidity,
        'pressure': pressure,
      },
      'wind': {'speed': windSpeed},
      'weather': [
        {'main': weatherMain, 'description': weatherDescription, 'icon': icon},
      ],
    };
  }
}

class DailyForecast {
  final String date;
  final List<ForecastItem> forecasts;

  DailyForecast({required this.date, required this.forecasts});

  // Get max temperature for the day
  double getMaxTemp() {
    if (forecasts.isEmpty) return 0;
    return forecasts.map((e) => e.tempMax).reduce((a, b) => a > b ? a : b);
  }

  // Get min temperature for the day
  double getMinTemp() {
    if (forecasts.isEmpty) return 0;
    return forecasts.map((e) => e.tempMin).reduce((a, b) => a < b ? a : b);
  }

  // Get most common weather icon
  String getMostCommonIcon() {
    if (forecasts.isEmpty) return '01d';
    Map<String, int> iconCount = {};
    for (var forecast in forecasts) {
      iconCount[forecast.icon] = (iconCount[forecast.icon] ?? 0) + 1;
    }
    return iconCount.entries.reduce((a, b) => a.value > b.value ? a : b).key;
  }

  // Get most common weather description
  String getMostCommonDescription() {
    if (forecasts.isEmpty) return '';
    Map<String, int> descCount = {};
    for (var forecast in forecasts) {
      descCount[forecast.weatherDescription] =
          (descCount[forecast.weatherDescription] ?? 0) + 1;
    }
    return descCount.entries.reduce((a, b) => a.value > b.value ? a : b).key;
  }
}
