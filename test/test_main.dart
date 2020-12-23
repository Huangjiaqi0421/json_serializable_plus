import 'dart:convert';

import 'package:test/test.dart';

import 'json_serializable.dart';
import 'user.dart';

void main() {
  test(" serialize json to object", () {
    User user = JsonSerializablePlus.fromJson(
        json.decode("{\"name\":\"hjq\",\"id\":12}"));
    expect(
        user,
        predicate<User>(
            (user) => user.name == 'hjq' && user.id == 12, "serialize failed"));
  });

  test("serialize json to list", () {
    List<User> users = JsonSerializablePlus.fromJson(json.decode(
        "[{\"name\":\"hjq\",\"id\":12},{\"name\":\"hjq\",\"id\":12},{\"name\":\"hjq\",\"id\":12},{\"name\":\"hjq\",\"id\":12}]"));
    expect(
        users,
        predicate<List<User>>(
            ((users) => users.length > 0), "serialize json to list failed"));
  });
}
