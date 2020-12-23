// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

User _$UserFromJson(Map<String, dynamic> json) {
  return User(
    json['name'] as String,
    json['id'] as int,
    (json['students'] as List)
        ?.map((e) =>
            e == null ? null : Student.fromJson(e as Map<String, dynamic>))
        ?.toList(),
  );
}

Map<String, dynamic> _$UserToJson(User instance) => <String, dynamic>{
      'name': instance.name,
      'id': instance.id,
      'students': instance.students,
    };

Student _$StudentFromJson(Map<String, dynamic> json) {
  return Student(
    json['name'] as String,
    json['id'] as int,
  );
}

Map<String, dynamic> _$StudentToJson(Student instance) => <String, dynamic>{
      'name': instance.name,
      'id': instance.id,
    };
