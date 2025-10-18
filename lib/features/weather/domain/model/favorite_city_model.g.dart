// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'favorite_city_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class FavoriteCityModelAdapter extends TypeAdapter<FavoriteCityModel> {
  @override
  final int typeId = 1;

  @override
  FavoriteCityModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return FavoriteCityModel(
      cityName: fields[0] as String,
      countryCode: fields[1] as String,
      lat: fields[2] as double?,
      lon: fields[3] as double?,
      addedAt: fields[4] as DateTime,
    );
  }

  @override
  void write(BinaryWriter writer, FavoriteCityModel obj) {
    writer
      ..writeByte(5)
      ..writeByte(0)
      ..write(obj.cityName)
      ..writeByte(1)
      ..write(obj.countryCode)
      ..writeByte(2)
      ..write(obj.lat)
      ..writeByte(3)
      ..write(obj.lon)
      ..writeByte(4)
      ..write(obj.addedAt);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is FavoriteCityModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
