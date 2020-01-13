// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'Location.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Location _$LocationFromJson(Map<String, dynamic> json) {
  return Location(
    lat: (json['lat'] as num)?.toDouble(),
    long: (json['long'] as num)?.toDouble(),
  );
}

Map<String, dynamic> _$LocationToJson(Location instance) => <String, dynamic>{
      'lat': instance.lat,
      'long': instance.long,
    };
