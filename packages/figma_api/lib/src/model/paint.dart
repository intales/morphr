//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:figma_api/src/model/vector.dart';
import 'package:figma_api/src/model/color_stop.dart';
import 'package:figma_api/src/model/color.dart';
import 'package:figma_api/src/model/blend_mode.dart';
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

     this.visible = true,

     this.opacity = 1,

     this.color,

     this.gradientHandlePositions,

     this.gradientStops,

     this.blendMode,

     this.imageRef,

     this.imageTransform,

     this.scaleMode,

     this.scalingFactor,
  });

  @JsonKey(
    
    name: r'type',
    required: true,
    includeIfNull: false,
  )


  final PaintTypeEnum type;



  @JsonKey(
    defaultValue: true,
    name: r'visible',
    required: false,
    includeIfNull: false,
  )


  final bool? visible;



          // minimum: 0
          // maximum: 1
  @JsonKey(
    defaultValue: 1,
    name: r'opacity',
    required: false,
    includeIfNull: false,
  )


  final num? opacity;



  @JsonKey(
    
    name: r'color',
    required: false,
    includeIfNull: false,
  )


  final Color? color;



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



  @JsonKey(
    
    name: r'blendMode',
    required: false,
    includeIfNull: false,
  )


  final BlendMode? blendMode;



  @JsonKey(
    
    name: r'imageRef',
    required: false,
    includeIfNull: false,
  )


  final String? imageRef;



  @JsonKey(
    
    name: r'imageTransform',
    required: false,
    includeIfNull: false,
  )


  final List<List<num>>? imageTransform;



  @JsonKey(
    
    name: r'scaleMode',
    required: false,
    includeIfNull: false,
  )


  final PaintScaleModeEnum? scaleMode;



  @JsonKey(
    
    name: r'scalingFactor',
    required: false,
    includeIfNull: false,
  )


  final num? scalingFactor;





    @override
    bool operator ==(Object other) => identical(this, other) || other is Paint &&
      other.type == type &&
      other.visible == visible &&
      other.opacity == opacity &&
      other.color == color &&
      other.gradientHandlePositions == gradientHandlePositions &&
      other.gradientStops == gradientStops &&
      other.blendMode == blendMode &&
      other.imageRef == imageRef &&
      other.imageTransform == imageTransform &&
      other.scaleMode == scaleMode &&
      other.scalingFactor == scalingFactor;

    @override
    int get hashCode =>
        type.hashCode +
        visible.hashCode +
        opacity.hashCode +
        color.hashCode +
        gradientHandlePositions.hashCode +
        gradientStops.hashCode +
        blendMode.hashCode +
        imageRef.hashCode +
        imageTransform.hashCode +
        scaleMode.hashCode +
        scalingFactor.hashCode;

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
GRADIENT_RADIAL(r'GRADIENT_RADIAL'),
@JsonValue(r'GRADIENT_ANGULAR')
GRADIENT_ANGULAR(r'GRADIENT_ANGULAR'),
@JsonValue(r'GRADIENT_DIAMOND')
GRADIENT_DIAMOND(r'GRADIENT_DIAMOND'),
@JsonValue(r'IMAGE')
IMAGE(r'IMAGE');

const PaintTypeEnum(this.value);

final String value;

@override
String toString() => value;
}



enum PaintScaleModeEnum {
@JsonValue(r'FILL')
FILL(r'FILL'),
@JsonValue(r'FIT')
FIT(r'FIT'),
@JsonValue(r'TILE')
TILE(r'TILE'),
@JsonValue(r'STRETCH')
STRETCH(r'STRETCH');

const PaintScaleModeEnum(this.value);

final String value;

@override
String toString() => value;
}


