//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:json_annotation/json_annotation.dart';

part 'constraint.g.dart';


@JsonSerializable(
  checked: true,
  createToJson: true,
  disallowUnrecognizedKeys: false,
  explicitToJson: true,
)
class Constraint {
  /// Returns a new [Constraint] instance.
  Constraint({

    required  this.type,

    required  this.value,
  });

  @JsonKey(
    
    name: r'type',
    required: true,
    includeIfNull: false,
  )


  final ConstraintTypeEnum type;



  @JsonKey(
    
    name: r'value',
    required: true,
    includeIfNull: false,
  )


  final num value;





    @override
    bool operator ==(Object other) => identical(this, other) || other is Constraint &&
      other.type == type &&
      other.value == value;

    @override
    int get hashCode =>
        type.hashCode +
        value.hashCode;

  factory Constraint.fromJson(Map<String, dynamic> json) => _$ConstraintFromJson(json);

  Map<String, dynamic> toJson() => _$ConstraintToJson(this);

  @override
  String toString() {
    return toJson().toString();
  }

}


enum ConstraintTypeEnum {
@JsonValue(r'SCALE')
SCALE(r'SCALE'),
@JsonValue(r'WIDTH')
WIDTH(r'WIDTH'),
@JsonValue(r'HEIGHT')
HEIGHT(r'HEIGHT');

const ConstraintTypeEnum(this.value);

final String value;

@override
String toString() => value;
}


