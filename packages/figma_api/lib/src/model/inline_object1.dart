//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:json_annotation/json_annotation.dart';

part 'inline_object1.g.dart';

@JsonSerializable(
  checked: true,
  createToJson: true,
  disallowUnrecognizedKeys: false,
  explicitToJson: true,
)
class InlineObject1 {
  /// Returns a new [InlineObject1] instance.
  InlineObject1({
    required this.status,
    required this.err,
  });

  @JsonKey(
    name: r'status',
    required: true,
    includeIfNull: false,
  )
  final InlineObject1StatusEnum status;

  @JsonKey(
    name: r'err',
    required: true,
    includeIfNull: false,
  )
  final String err;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is InlineObject1 && other.status == status && other.err == err;

  @override
  int get hashCode => status.hashCode + err.hashCode;

  factory InlineObject1.fromJson(Map<String, dynamic> json) =>
      _$InlineObject1FromJson(json);

  Map<String, dynamic> toJson() => _$InlineObject1ToJson(this);

  @override
  String toString() {
    return toJson().toString();
  }
}

enum InlineObject1StatusEnum {
  @JsonValue('403')
  n403('403');

  const InlineObject1StatusEnum(this.value);

  final String value;

  @override
  String toString() => value;
}
