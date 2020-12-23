import 'dart:async';

import 'package:analyzer/dart/element/element.dart';
import 'package:build/src/asset/id.dart';
import 'package:build/src/builder/build_step.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:json_serializable_plus/src/aggregate/build_config.dart';
import 'package:source_gen/source_gen.dart';

import 'aggregate/aggregate_generator.dart';

class JsonSerializableAggregateGenerator
    extends AggregateGeneratorForAnnotation<JsonSerializable> {
  List<String> _importList = <String>[];
  List<String> _classNames = <String>[];

  @override
  FutureOr<String> generate(
      Stream<AssetId> assetIds, BuildConfig config, BuildStep buildStep) async {

    await collect(assetIds,buildStep, config);

    return _generateFile();
  }

  String _generateFile() {
    StringBuffer contentBuffer = StringBuffer();

    contentBuffer.writeAll(_importList);

    contentBuffer.write('''
    class JsonSerializablePlus{
    
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
      
    ''');

    contentBuffer.write(generateCreateTypeListFunction());

    contentBuffer.write(generateFromJsonMapFunction());

    contentBuffer.write('}');
    return contentBuffer.toString();
  }

  /// collect assets info (file path ,class name ...)
  Future collect(Stream<AssetId> assetIds, BuildStep buildStep, BuildConfig config) async {
    await for (final input in assetIds) {

      LibraryElement library = await libraryFor(buildStep, input);
      if(library==null){
        continue;
      }
      final classesInLibrary = LibraryReader(library).annotatedWith(checker);

      if (classesInLibrary.isNotEmpty) {
        _addImport(input.path, config.specialSyntheticAssets);
      }

      classesInLibrary.forEach((element) {
        _addClassName(element);
      });
    }
  }

  void _addClassName(AnnotatedElement annotatedElement){
    _classNames.add(annotatedElement.element.name);
  }


  void _addImport(String path, String specialSyntheticAssets) {
    _importList.add(
        "import '${path.replaceFirst('$specialSyntheticAssets/', '')}';\n");/// example:  path 'lib/entity' =>'entity'
  }

  String generateCreateTypeListFunction() {

    return '''
        static List _createTypeList(String typeParameters){
          switch(typeParameters){
            ${_classNames.map((name) => "case '${name}':return List<${name}>();").join()}
    }
  }
    ''';


  }

  String generateFromJsonMapFunction() {

    return '''
          static dynamic _fromJsonMap<T>(json, String type) {
            switch (type) {
            ${_classNames.map((name) => "case '${name}':return ${name}.fromJson(json);").join()}
    }
  }
    ''';



  }
}
