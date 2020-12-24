# json_serializable_plus

使用build_runner，对官方json_serializable功能的增加，提供了统一的json解析方法。
支持List解析。

构建器会找到 [package：json_annotation](https://pub.dev/packages/json_annotation)注释的 类，生成统一的解析方法。

查看[json_serializable](https://pub.dev/packages/json_serializable)的使用方法

## Getting Started

* 当前最新版本 json_serializable_plus: ^0.0.3

在已经添加json_serializable 的基础上，只需要在`dev_dependencies`中添加`json_serializable_plus:^x.x.x` 。
最终的`pubspec.yaml` 文件类似下面这样:
```
dependencies:
  flutter:
    sdk: flutter

  json_annotation: '>=3.1.0 <3.2.0'


dev_dependencies:
  flutter_test:
    sdk: flutter

  build_runner: ^1.0.0
  json_serializable: ^3.5.1
  json_serializable_plus: ^0.0.3


```
## Example
1. 给`Teacher` 和 `Student`设置 `@JsonSerializable()`注解

```
import 'package:json_annotation/json_annotation.dart';

part 'user.g.dart';
@JsonSerializable()
class Teacher {
  String teacherName;
  int id;
  List<Student> students;
  Teacher(this.teacherName,this.id,this.students);
  factory Teacher.fromJson(Map<String,dynamic> json)=>_$TeacherFromJson(json);
}


@JsonSerializable()
class Student {
  String studentName;
  int id;
  Student(this.studentName,this.id);
  factory Student.fromJson(Map<String,dynamic> json)=>_$StudentFromJson(json);
}


```


2. 运行`flutter pub run build_runner build`会在根目录会生成一个json_serializable.dart 文件

3. 调用方法解析json

```
Teacher teacher = JsonSerializablePlus.fromJson(
        json.decode("{\"teacherName\":\"hjq\",\"id\":32,\"students\":[{\"studentName\":\"s1\",\"id\":12},{\"studentName\":\"s2\",\"id\":12}]}"));

 List<Student> student = JsonSerializablePlus.fromJson(json.decode(
        "[{\"studentName\":\"s1\",\"id\":12},{\"studentName\":\"s2\",\"id\":12}]"));
```

## TODO
* 增加对json_annotation 字段的解析

## QA

* 运行`flutter pub run build_runner build`时出现

```
Failed to precompile build_runner:build_runner:
../../../../../.pub-cache/hosted/pub.flutter-io.cn/build_resolvers-x.x.x/lib/src/resolver.dart:343:10: Error: Method not found: 'SummaryBuilder'.
return SummaryBuilder(sdkSources, sdk.context)
 ```

`dev_dependencies`指定`build_resolvers`版本 >= `^1.5.1`


* 运行`flutter pub run build_runner build`时出现`[SEVERE] Conflicting outputs were detected and the build is unable to prompt for permission to remove them.`

代码提交时会把生成的*.g.dart提交上去，但是dart_tool/build 不会提交，所以在缺少dart_tool/build的文件情况下，flutter 无法自己删除重建。
运行以下代码

```
flutter packages pub run build_runner clean
flutter packages pub run build_runner build --delete-conflicting-outputs
```


