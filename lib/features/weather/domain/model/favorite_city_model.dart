import 'package:hive/hive.dart';

part 'favorite_city_model.g.dart';

@HiveType(typeId: 1)
class FavoriteCityModel extends HiveObject {
  @HiveField(0)
  final String cityName;

  @HiveField(1)
  final String countryCode;

  @HiveField(2)
  final double? lat;

  @HiveField(3)
  final double? lon;

  @HiveField(4)
  final DateTime addedAt;

  FavoriteCityModel({
    required this.cityName,
    required this.countryCode,
    this.lat,
    this.lon,
    required this.addedAt,
  });

  String get displayName => '$cityName, $countryCode';

  @override
  String toString() {
    return 'FavoriteCityModel(cityName: $cityName, countryCode: $countryCode, lat: $lat, lon: $lon, addedAt: $addedAt)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is FavoriteCityModel &&
        other.cityName == cityName &&
        other.countryCode == countryCode;
  }

  @override
  int get hashCode => cityName.hashCode ^ countryCode.hashCode;
}
