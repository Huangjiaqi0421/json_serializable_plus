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
      case 'User':
        return List<User>();
      case 'Student':
        return List<Student>();
    }
  }

  static dynamic _fromJsonMap<T>(json, String type) {
    switch (type) {
      case 'User':
        return User.fromJson(json);
      case 'Student':
        return Student.fromJson(json);
    }
  }
}
