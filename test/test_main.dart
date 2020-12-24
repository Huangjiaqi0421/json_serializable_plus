import 'dart:convert';

import 'package:test/test.dart';

import 'json_serializable.dart';
import 'user.dart';

void main() {
  test(" serialize json to object", () {
    Teacher teacher = JsonSerializablePlus.fromJson(
        json.decode("{\"teacherName\":\"hjq\",\"id\":32,\"students\":[{\"studentName\":\"s1\",\"id\":12},{\"studentName\":\"s2\",\"id\":12}]}"));
    expect(
        teacher,
        predicate<Teacher>(
            (teacher) => teacher.teacherName == 'hjq' && teacher.id == 32 && teacher.students.length==2, "serialize failed"));
  });

  test("serialize json to list", () {
    List<Student> student = JsonSerializablePlus.fromJson(json.decode(
        "[{\"studentName\":\"s1\",\"id\":12},{\"studentName\":\"s2\",\"id\":12}]"));
    expect(
        student,
        predicate<List<Student>>(
            ((students) => students.length > 0), "serialize json to list failed"));
  });
}
