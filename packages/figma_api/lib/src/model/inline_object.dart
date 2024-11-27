//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:json_annotation/json_annotation.dart';

part 'inline_object.g.dart';

@JsonSerializable(
  checked: true,
  createToJson: true,
  disallowUnrecognizedKeys: false,
  explicitToJson: true,
)
class InlineObject {
  /// Returns a new [InlineObject] instance.
  InlineObject({
    required this.status,
    required this.err,
  });

  @JsonKey(
    name: r'status',
    required: true,
    includeIfNull: false,
  )
  final InlineObjectStatusEnum status;

  @JsonKey(
    name: r'err',
    required: true,
    includeIfNull: false,
  )
  final String err;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is InlineObject && other.status == status && other.err == err;

  @override
  int get hashCode => status.hashCode + err.hashCode;

  factory InlineObject.fromJson(Map<String, dynamic> json) =>
      _$InlineObjectFromJson(json);

  Map<String, dynamic> toJson() => _$InlineObjectToJson(this);

  @override
  String toString() {
    return toJson().toString();
  }
}

enum InlineObjectStatusEnum {
  @JsonValue('400')
  n400('400');

  const InlineObjectStatusEnum(this.value);

  final String value;

  @override
  String toString() => value;
}
