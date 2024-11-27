//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:figma_api/src/model/rgba.dart';
import 'package:json_annotation/json_annotation.dart';

part 'solid_paint.g.dart';


@JsonSerializable(
  checked: true,
  createToJson: true,
  disallowUnrecognizedKeys: false,
  explicitToJson: true,
)
class SolidPaint {
  /// Returns a new [SolidPaint] instance.
  SolidPaint({

    required  this.type,

    required  this.color,
  });

  @JsonKey(
    
    name: r'type',
    required: true,
    includeIfNull: false,
  )


  final SolidPaintTypeEnum type;



  @JsonKey(
    
    name: r'color',
    required: true,
    includeIfNull: false,
  )


  final RGBA color;





    @override
    bool operator ==(Object other) => identical(this, other) || other is SolidPaint &&
      other.type == type &&
      other.color == color;

    @override
    int get hashCode =>
        type.hashCode +
        color.hashCode;

  factory SolidPaint.fromJson(Map<String, dynamic> json) => _$SolidPaintFromJson(json);

  Map<String, dynamic> toJson() => _$SolidPaintToJson(this);

  @override
  String toString() {
    return toJson().toString();
  }

}


enum SolidPaintTypeEnum {
@JsonValue(r'SOLID')
SOLID(r'SOLID');

const SolidPaintTypeEnum(this.value);

final String value;

@override
String toString() => value;
}


