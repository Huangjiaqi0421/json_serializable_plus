// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Teacher _$TeacherFromJson(Map<String, dynamic> json) {
  return Teacher(
    json['teacherName'] as String,
    json['id'] as int,
    (json['students'] as List)
        ?.map((e) =>
            e == null ? null : Student.fromJson(e as Map<String, dynamic>))
        ?.toList(),
  );
}

Map<String, dynamic> _$TeacherToJson(Teacher instance) => <String, dynamic>{
      'teacherName': instance.teacherName,
      'id': instance.id,
      'students': instance.students,
    };

Student _$StudentFromJson(Map<String, dynamic> json) {
  return Student(
    json['studentName'] as String,
    json['id'] as int,
  );
}

Map<String, dynamic> _$StudentToJson(Student instance) => <String, dynamic>{
      'studentName': instance.studentName,
      'id': instance.id,
    };
