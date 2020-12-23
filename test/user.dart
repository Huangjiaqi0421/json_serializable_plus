

import 'package:json_annotation/json_annotation.dart';

part 'user.g.dart';
@JsonSerializable()
class User {
  String name;
  int id;
  List<Student> students;
  User(this.name,this.id,this.students);
  factory User.fromJson(Map<String,dynamic> json)=>_$UserFromJson(json);
}


@JsonSerializable()
class Student {
  String name;
  int id;
  Student(this.name,this.id);
  factory Student.fromJson(Map<String,dynamic> json)=>_$StudentFromJson(json);
}




