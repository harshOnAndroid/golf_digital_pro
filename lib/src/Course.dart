

import 'package:golf_digital_pro/src/Location.dart';
import 'package:json_annotation/json_annotation.dart';
part 'Course.g.dart';

@JsonSerializable()
class Course{
  String course_name;
  String address;
  String city;
  String state;
  String postal_code;
  String phone;
  int holes;
  String avg_cost;
  String logo;
  Location location;

  Course({
    this.course_name,
    this.address,
    this.city,
    this.state,
    this.postal_code,
    this.phone,
    this.holes,
    this.avg_cost,
    this.logo,
    this.location,
});

  factory Course.fromJson(Map<String, dynamic> json) => _$CourseFromJson(json);

  Map<String, dynamic> toJson() => _$CourseToJson(this);

}
