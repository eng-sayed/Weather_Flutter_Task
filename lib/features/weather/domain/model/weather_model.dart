class WeatherModel {
  final String cityName;
  final String countryCode;
  final double temperature;
  final double feelsLike;
  final int humidity;
  final double windSpeed;
  final String weatherMain;
  final String weatherDescription;
  final String icon;
  final int pressure;
  final double? tempMin;
  final double? tempMax;
  final int? visibility;
  final DateTime dateTime;
  final double? lat;
  final double? lon;

  WeatherModel({
    required this.cityName,
    required this.countryCode,
    required this.temperature,
    required this.feelsLike,
    required this.humidity,
    required this.windSpeed,
    required this.weatherMain,
    required this.weatherDescription,
    required this.icon,
    required this.pressure,
    this.tempMin,
    this.tempMax,
    this.visibility,
    required this.dateTime,
    this.lat,
    this.lon,
  });

  factory WeatherModel.fromJson(Map<String, dynamic> json) {
    return WeatherModel(
      cityName: json['name'] ?? '',
      countryCode: json['sys']?['country'] ?? '',
      temperature: (json['main']?['temp'] ?? 0).toDouble(),
      feelsLike: (json['main']?['feels_like'] ?? 0).toDouble(),
      humidity: json['main']?['humidity'] ?? 0,
      windSpeed: (json['wind']?['speed'] ?? 0).toDouble(),
      weatherMain: json['weather']?[0]?['main'] ?? '',
      weatherDescription: json['weather']?[0]?['description'] ?? '',
      icon: json['weather']?[0]?['icon'] ?? '01d',
      pressure: json['main']?['pressure'] ?? 0,
      tempMin: json['main']?['temp_min']?.toDouble(),
      tempMax: json['main']?['temp_max']?.toDouble(),
      visibility: json['visibility'],
      dateTime: DateTime.fromMillisecondsSinceEpoch((json['dt'] ?? 0) * 1000),
      lat: json['coord']?['lat']?.toDouble(),
      lon: json['coord']?['lon']?.toDouble(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': cityName,
      'sys': {'country': countryCode},
      'main': {
        'temp': temperature,
        'feels_like': feelsLike,
        'humidity': humidity,
        'pressure': pressure,
        'temp_min': tempMin,
        'temp_max': tempMax,
      },
      'wind': {'speed': windSpeed},
      'weather': [
        {'main': weatherMain, 'description': weatherDescription, 'icon': icon},
      ],
      'visibility': visibility,
      'dt': dateTime.millisecondsSinceEpoch ~/ 1000,
      'coord': {'lat': lat, 'lon': lon},
    };
  }
}
