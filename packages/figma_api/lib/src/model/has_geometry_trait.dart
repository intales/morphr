//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:figma_api/src/model/paint.dart';
import 'package:json_annotation/json_annotation.dart';

part 'has_geometry_trait.g.dart';


@JsonSerializable(
  checked: true,
  createToJson: true,
  disallowUnrecognizedKeys: false,
  explicitToJson: true,
)
class HasGeometryTrait {
  /// Returns a new [HasGeometryTrait] instance.
  HasGeometryTrait({

    required  this.fills,

    required  this.strokes,

     this.strokeWeight = 1,

     this.strokeAlign,
  });

  @JsonKey(
    
    name: r'fills',
    required: true,
    includeIfNull: false,
  )


  final List<Paint> fills;



  @JsonKey(
    
    name: r'strokes',
    required: true,
    includeIfNull: false,
  )


  final List<Paint> strokes;



  @JsonKey(
    defaultValue: 1,
    name: r'strokeWeight',
    required: false,
    includeIfNull: false,
  )


  final num? strokeWeight;



  @JsonKey(
    
    name: r'strokeAlign',
    required: false,
    includeIfNull: false,
  )


  final HasGeometryTraitStrokeAlignEnum? strokeAlign;





    @override
    bool operator ==(Object other) => identical(this, other) || other is HasGeometryTrait &&
      other.fills == fills &&
      other.strokes == strokes &&
      other.strokeWeight == strokeWeight &&
      other.strokeAlign == strokeAlign;

    @override
    int get hashCode =>
        fills.hashCode +
        strokes.hashCode +
        strokeWeight.hashCode +
        strokeAlign.hashCode;

  factory HasGeometryTrait.fromJson(Map<String, dynamic> json) => _$HasGeometryTraitFromJson(json);

  Map<String, dynamic> toJson() => _$HasGeometryTraitToJson(this);

  @override
  String toString() {
    return toJson().toString();
  }

}


enum HasGeometryTraitStrokeAlignEnum {
@JsonValue(r'INSIDE')
INSIDE(r'INSIDE'),
@JsonValue(r'OUTSIDE')
OUTSIDE(r'OUTSIDE'),
@JsonValue(r'CENTER')
CENTER(r'CENTER');

const HasGeometryTraitStrokeAlignEnum(this.value);

final String value;

@override
String toString() => value;
}


