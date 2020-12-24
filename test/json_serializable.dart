// GENERATED CODE - DO NOT MODIFY BY HAND
import 'user.dart';

class JsonSerializablePlus {
  static T fromJson<T>(json) {
    String type = T.toString();

    if (json is List) {
      if (!type.startsWith("List<")) {
        return null;
      }
      String typeParameters = type.substring(5, type.lastIndexOf(">"));
      List typeList = _createTypeList(typeParameters);
      if (typeList == null) {
        return null;
      }
      json.forEach((item) {
        typeList.add(_fromJsonMap(item, typeParameters));
      });
      return typeList as T;
    } else {
      return _fromJsonMap(json, type) as T;
    }
  }

  static List _createTypeList(String typeParameters) {
    switch (typeParameters) {
      case 'Teacher':
        return List<Teacher>();
      case 'Student':
        return List<Student>();
    }
    return null;
  }

  static dynamic _fromJsonMap<T>(json, String type) {
    switch (type) {
      case 'Teacher':
        return Teacher.fromJson(json);
      case 'Student':
        return Student.fromJson(json);
    }
  }
}
