//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:json_annotation/json_annotation.dart';

part 'inline_object2.g.dart';

@JsonSerializable(
  checked: true,
  createToJson: true,
  disallowUnrecognizedKeys: false,
  explicitToJson: true,
)
class InlineObject2 {
  /// Returns a new [InlineObject2] instance.
  InlineObject2({
    required this.status,
    required this.err,
  });

  @JsonKey(
    name: r'status',
    required: true,
    includeIfNull: false,
  )
  final InlineObject2StatusEnum status;

  @JsonKey(
    name: r'err',
    required: true,
    includeIfNull: false,
  )
  final String err;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is InlineObject2 && other.status == status && other.err == err;

  @override
  int get hashCode => status.hashCode + err.hashCode;

  factory InlineObject2.fromJson(Map<String, dynamic> json) =>
      _$InlineObject2FromJson(json);

  Map<String, dynamic> toJson() => _$InlineObject2ToJson(this);

  @override
  String toString() {
    return toJson().toString();
  }
}

enum InlineObject2StatusEnum {
  @JsonValue('404')
  n404('404');

  const InlineObject2StatusEnum(this.value);

  final String value;

  @override
  String toString() => value;
}
