//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:figma_api/src/model/vector.dart';
import 'package:figma_api/src/model/color_stop.dart';
import 'package:figma_api/src/model/color.dart';
import 'package:json_annotation/json_annotation.dart';

part 'paint.g.dart';


@JsonSerializable(
  checked: true,
  createToJson: true,
  disallowUnrecognizedKeys: false,
  explicitToJson: true,
)
class Paint {
  /// Returns a new [Paint] instance.
  Paint({

    required  this.type,

     this.color,

     this.opacity,

     this.gradientHandlePositions,

     this.gradientStops,
  });

  @JsonKey(
    
    name: r'type',
    required: true,
    includeIfNull: false,
  )


  final PaintTypeEnum type;



  @JsonKey(
    
    name: r'color',
    required: false,
    includeIfNull: false,
  )


  final Color? color;



          // minimum: 0
          // maximum: 1
  @JsonKey(
    
    name: r'opacity',
    required: false,
    includeIfNull: false,
  )


  final num? opacity;



  @JsonKey(
    
    name: r'gradientHandlePositions',
    required: false,
    includeIfNull: false,
  )


  final List<Vector>? gradientHandlePositions;



  @JsonKey(
    
    name: r'gradientStops',
    required: false,
    includeIfNull: false,
  )


  final List<ColorStop>? gradientStops;





    @override
    bool operator ==(Object other) => identical(this, other) || other is Paint &&
      other.type == type &&
      other.color == color &&
      other.opacity == opacity &&
      other.gradientHandlePositions == gradientHandlePositions &&
      other.gradientStops == gradientStops;

    @override
    int get hashCode =>
        type.hashCode +
        color.hashCode +
        opacity.hashCode +
        gradientHandlePositions.hashCode +
        gradientStops.hashCode;

  factory Paint.fromJson(Map<String, dynamic> json) => _$PaintFromJson(json);

  Map<String, dynamic> toJson() => _$PaintToJson(this);

  @override
  String toString() {
    return toJson().toString();
  }

}


enum PaintTypeEnum {
@JsonValue(r'SOLID')
SOLID(r'SOLID'),
@JsonValue(r'GRADIENT_LINEAR')
GRADIENT_LINEAR(r'GRADIENT_LINEAR'),
@JsonValue(r'GRADIENT_RADIAL')
GRADIENT_RADIAL(r'GRADIENT_RADIAL');

const PaintTypeEnum(this.value);

final String value;

@override
String toString() => value;
}


