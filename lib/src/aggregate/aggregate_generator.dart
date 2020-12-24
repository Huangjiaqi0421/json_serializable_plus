import 'dart:async';

import 'package:analyzer/dart/element/element.dart';
import 'package:build/src/asset/id.dart';
import 'package:build/build.dart';
import 'package:build/src/builder/build_step.dart';
import 'package:json_serializable_plus/src/aggregate/build_config.dart';
import 'package:source_gen/source_gen.dart';

abstract class AggregateGenerator {

  FutureOr<String> generate(Stream<AssetId> assetIds, BuildConfig config, BuildStep buildStep);


}


abstract class AggregateGeneratorForAnnotation<T> extends AggregateGenerator{
  TypeChecker get checker => TypeChecker.fromRuntime(T);

  ///Since the input of aggregate builders isn't a real asset that could be read,
  ///we also can't use buildStep.inputLibrary to resolve it.
  ///However, recent versions of the build system allow us to resolve any asset our builder can read.
  ///return null,if input is not a library
  Future<LibraryElement> libraryFor(BuildStep buildStep, AssetId input) async {
    print(input.path);
    if(! await buildStep.resolver.isLibrary(input)){
      return null;
    }
    final library = await buildStep.resolver.libraryFor(input);
    return library;
  }
}