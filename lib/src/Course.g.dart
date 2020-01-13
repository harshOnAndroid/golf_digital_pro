// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'Course.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Course _$CourseFromJson(Map<String, dynamic> json) {
  return Course(
    course_name: json['course_name'] as String,
    address: json['address'] as String,
    city: json['city'] as String,
    state: json['state'] as String,
    postal_code: json['postal_code'] as String,
    phone: json['phone'] as String,
    holes: json['holes'] as int,
    avg_cost: json['avg_cost'] as String,
    logo: json['logo'] as String,
    location: json['location'] == null
        ? null
        : Location.fromJson(json['location'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$CourseToJson(Course instance) => <String, dynamic>{
      'course_name': instance.course_name,
      'address': instance.address,
      'city': instance.city,
      'state': instance.state,
      'postal_code': instance.postal_code,
      'phone': instance.phone,
      'holes': instance.holes,
      'avg_cost': instance.avg_cost,
      'logo': instance.logo,
      'location': instance.location,
    };
