//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:figma_api/src/model/color_stop.dart';
import 'package:json_annotation/json_annotation.dart';

part 'gradient_paint.g.dart';


@JsonSerializable(
  checked: true,
  createToJson: true,
  disallowUnrecognizedKeys: false,
  explicitToJson: true,
)
class GradientPaint {
  /// Returns a new [GradientPaint] instance.
  GradientPaint({

    required  this.type,

    required  this.gradientStops,
  });

  @JsonKey(
    
    name: r'type',
    required: true,
    includeIfNull: false,
  )


  final GradientPaintTypeEnum type;



  @JsonKey(
    
    name: r'gradientStops',
    required: true,
    includeIfNull: false,
  )


  final List<ColorStop> gradientStops;





    @override
    bool operator ==(Object other) => identical(this, other) || other is GradientPaint &&
      other.type == type &&
      other.gradientStops == gradientStops;

    @override
    int get hashCode =>
        type.hashCode +
        gradientStops.hashCode;

  factory GradientPaint.fromJson(Map<String, dynamic> json) => _$GradientPaintFromJson(json);

  Map<String, dynamic> toJson() => _$GradientPaintToJson(this);

  @override
  String toString() {
    return toJson().toString();
  }

}


enum GradientPaintTypeEnum {
@JsonValue(r'GRADIENT_LINEAR')
LINEAR(r'GRADIENT_LINEAR'),
@JsonValue(r'GRADIENT_RADIAL')
RADIAL(r'GRADIENT_RADIAL'),
@JsonValue(r'GRADIENT_ANGULAR')
ANGULAR(r'GRADIENT_ANGULAR'),
@JsonValue(r'GRADIENT_DIAMOND')
DIAMOND(r'GRADIENT_DIAMOND');

const GradientPaintTypeEnum(this.value);

final String value;

@override
String toString() => value;
}


