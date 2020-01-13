import 'package:json_annotation/json_annotation.dart';
part 'Location.g.dart';

@JsonSerializable()
class Location{

  double lat;
  double long;
  Location({
    this.lat,
    this.long,
  });

  factory Location.fromJson(Map<String, dynamic> json) => _$LocationFromJson(json);

  Map<String, dynamic> toJson() => _$LocationToJson(this);

}