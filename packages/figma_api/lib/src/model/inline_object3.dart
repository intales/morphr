//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:json_annotation/json_annotation.dart';

part 'inline_object3.g.dart';

@JsonSerializable(
  checked: true,
  createToJson: true,
  disallowUnrecognizedKeys: false,
  explicitToJson: true,
)
class InlineObject3 {
  /// Returns a new [InlineObject3] instance.
  InlineObject3({
    required this.status,
    required this.err,
  });

  @JsonKey(
    name: r'status',
    required: true,
    includeIfNull: false,
  )
  final InlineObject3StatusEnum status;

  @JsonKey(
    name: r'err',
    required: true,
    includeIfNull: false,
  )
  final String err;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is InlineObject3 && other.status == status && other.err == err;

  @override
  int get hashCode => status.hashCode + err.hashCode;

  factory InlineObject3.fromJson(Map<String, dynamic> json) =>
      _$InlineObject3FromJson(json);

  Map<String, dynamic> toJson() => _$InlineObject3ToJson(this);

  @override
  String toString() {
    return toJson().toString();
  }
}

enum InlineObject3StatusEnum {
  @JsonValue('429')
  n429('429');

  const InlineObject3StatusEnum(this.value);

  final String value;

  @override
  String toString() => value;
}
