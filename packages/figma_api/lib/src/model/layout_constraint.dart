//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:json_annotation/json_annotation.dart';

part 'layout_constraint.g.dart';


@JsonSerializable(
  checked: true,
  createToJson: true,
  disallowUnrecognizedKeys: false,
  explicitToJson: true,
)
class LayoutConstraint {
  /// Returns a new [LayoutConstraint] instance.
  LayoutConstraint({

    required  this.vertical,

    required  this.horizontal,
  });

  @JsonKey(
    
    name: r'vertical',
    required: true,
    includeIfNull: false,
  )


  final LayoutConstraintVerticalEnum vertical;



  @JsonKey(
    
    name: r'horizontal',
    required: true,
    includeIfNull: false,
  )


  final LayoutConstraintHorizontalEnum horizontal;





    @override
    bool operator ==(Object other) => identical(this, other) || other is LayoutConstraint &&
      other.vertical == vertical &&
      other.horizontal == horizontal;

    @override
    int get hashCode =>
        vertical.hashCode +
        horizontal.hashCode;

  factory LayoutConstraint.fromJson(Map<String, dynamic> json) => _$LayoutConstraintFromJson(json);

  Map<String, dynamic> toJson() => _$LayoutConstraintToJson(this);

  @override
  String toString() {
    return toJson().toString();
  }

}


enum LayoutConstraintVerticalEnum {
@JsonValue(r'TOP')
TOP(r'TOP'),
@JsonValue(r'BOTTOM')
BOTTOM(r'BOTTOM'),
@JsonValue(r'CENTER')
CENTER(r'CENTER'),
@JsonValue(r'SCALE')
SCALE(r'SCALE'),
@JsonValue(r'STRETCH')
STRETCH(r'STRETCH'),
@JsonValue(r'TOP_BOTTOM')
TOP_BOTTOM(r'TOP_BOTTOM');

const LayoutConstraintVerticalEnum(this.value);

final String value;

@override
String toString() => value;
}



enum LayoutConstraintHorizontalEnum {
@JsonValue(r'LEFT')
LEFT(r'LEFT'),
@JsonValue(r'RIGHT')
RIGHT(r'RIGHT'),
@JsonValue(r'CENTER')
CENTER(r'CENTER'),
@JsonValue(r'SCALE')
SCALE(r'SCALE'),
@JsonValue(r'STRETCH')
STRETCH(r'STRETCH'),
@JsonValue(r'LEFT_RIGHT')
LEFT_RIGHT(r'LEFT_RIGHT');

const LayoutConstraintHorizontalEnum(this.value);

final String value;

@override
String toString() => value;
}


