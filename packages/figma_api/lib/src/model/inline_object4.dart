//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:json_annotation/json_annotation.dart';

part 'inline_object4.g.dart';

@JsonSerializable(
  checked: true,
  createToJson: true,
  disallowUnrecognizedKeys: false,
  explicitToJson: true,
)
class InlineObject4 {
  /// Returns a new [InlineObject4] instance.
  InlineObject4({
    required this.status,
    required this.err,
  });

  @JsonKey(
    name: r'status',
    required: true,
    includeIfNull: false,
  )
  final InlineObject4StatusEnum status;

  @JsonKey(
    name: r'err',
    required: true,
    includeIfNull: false,
  )
  final String err;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is InlineObject4 && other.status == status && other.err == err;

  @override
  int get hashCode => status.hashCode + err.hashCode;

  factory InlineObject4.fromJson(Map<String, dynamic> json) =>
      _$InlineObject4FromJson(json);

  Map<String, dynamic> toJson() => _$InlineObject4ToJson(this);

  @override
  String toString() {
    return toJson().toString();
  }
}

enum InlineObject4StatusEnum {
  @JsonValue('500')
  n500('500');

  const InlineObject4StatusEnum(this.value);

  final String value;

  @override
  String toString() => value;
}
