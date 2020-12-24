import 'package:build/build.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:json_serializable_plus/src/json_serializable_aggregate_generator.dart';

import 'src/aggregate/build_config.dart';
import 'src/aggregate/aggregate_builder.dart';

Builder jsonSerializablePlus(BuilderOptions options) {
  BuildConfig config = BuildConfig.fromJson(options.config);
  return AggregateBuilder(
      JsonSerializableAggregateGenerator(), config, "json_serializable.dart");
}
