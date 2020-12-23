import 'dart:async';

import 'package:build/build.dart';
import 'package:glob/glob.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:json_serializable_plus/src/aggregate/build_config.dart';
import 'package:source_gen/source_gen.dart';
import 'package:dart_style/dart_style.dart';

import 'aggregate_generator.dart';

class AggregateBuilder implements Builder {
  final String outputName ;

  final BuildConfig _config;
  final String Function(String) _formatOutput;
  final String _header;
  final AggregateGenerator _generator;

  AggregateBuilder(
    this._generator,
    this._config,
    this.outputName, {
    String Function(String code) formatOutput,
    String header,
  })  : this._formatOutput = formatOutput ?? _formatter.format,
        this._header = header ?? defaultFileHeader {
    buildExtensions = {
      '\$${_config.specialSyntheticAssets}\$': [outputName],
    };
  }

  @override
  Map<String, List<String>> buildExtensions;

  AssetId _allFileOutput(BuildStep buildStep) {
    return AssetId(
      buildStep.inputId.package,
      '${_config.specialSyntheticAssets}/$outputName',
    );
  }

  @override
  Future<void> build(BuildStep buildStep) async {
    final buffer = StringBuffer();

    if (_header.isNotEmpty) {
      buffer.writeln(_header);
    }
    var content = await _generate(_generator, _config, buildStep);

    buffer.write(content);

    await buildStep.writeAsString(
        _allFileOutput(buildStep), _formatOutput(buffer.toString()));
  }

  FutureOr<String> _generate(
    AggregateGenerator generator,
    BuildConfig config,
    BuildStep buildStep,
  ) {
    return generator.generate(findAssets(buildStep, config), config, buildStep);
  }

  ///aggregate builders work a little differently, there is no "input" (you need to find inputs manually):
  ///Instead, we can use the findAssets API to find the inputs we want to process, and create a new AssetId based off the current package we are processing.
  Stream<AssetId> findAssets(BuildStep buildStep, BuildConfig config) =>
      buildStep.findAssets(Glob('${config.specialSyntheticAssets}/**.dart',recursive: true));
}

final _formatter = DartFormatter();

const defaultFileHeader = '// GENERATED CODE - DO NOT MODIFY BY HAND';
