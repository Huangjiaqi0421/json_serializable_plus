

import 'package:json_annotation/json_annotation.dart';

part 'user.g.dart';
@JsonSerializable()
class Teacher {
  String teacherName;
  int id;
  List<Student> students;
  Teacher(this.teacherName,this.id,this.students);
  factory Teacher.fromJson(Map<String,dynamic> json)=>_$TeacherFromJson(json);
  Map<String,dynamic> toJson() =>_$TeacherToJson(this);
}


@JsonSerializable()
class Student {
  String studentName;
  int id;
  Student(this.studentName,this.id);
  factory Student.fromJson(Map<String,dynamic> json)=>_$StudentFromJson(json);
  Map<String,dynamic> toJson() =>_$StudentToJson(this);

}




