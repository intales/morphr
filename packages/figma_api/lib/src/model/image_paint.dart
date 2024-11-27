//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:json_annotation/json_annotation.dart';

part 'image_paint.g.dart';


@JsonSerializable(
  checked: true,
  createToJson: true,
  disallowUnrecognizedKeys: false,
  explicitToJson: true,
)
class ImagePaint {
  /// Returns a new [ImagePaint] instance.
  ImagePaint({

    required  this.type,

    required  this.imageRef,

    required  this.scaleMode,
  });

  @JsonKey(
    
    name: r'type',
    required: true,
    includeIfNull: false,
  )


  final ImagePaintTypeEnum type;



  @JsonKey(
    
    name: r'imageRef',
    required: true,
    includeIfNull: false,
  )


  final String imageRef;



  @JsonKey(
    
    name: r'scaleMode',
    required: true,
    includeIfNull: false,
  )


  final ImagePaintScaleModeEnum scaleMode;





    @override
    bool operator ==(Object other) => identical(this, other) || other is ImagePaint &&
      other.type == type &&
      other.imageRef == imageRef &&
      other.scaleMode == scaleMode;

    @override
    int get hashCode =>
        type.hashCode +
        imageRef.hashCode +
        scaleMode.hashCode;

  factory ImagePaint.fromJson(Map<String, dynamic> json) => _$ImagePaintFromJson(json);

  Map<String, dynamic> toJson() => _$ImagePaintToJson(this);

  @override
  String toString() {
    return toJson().toString();
  }

}


enum ImagePaintTypeEnum {
@JsonValue(r'IMAGE')
IMAGE(r'IMAGE');

const ImagePaintTypeEnum(this.value);

final String value;

@override
String toString() => value;
}



enum ImagePaintScaleModeEnum {
@JsonValue(r'FILL')
FILL(r'FILL'),
@JsonValue(r'FIT')
FIT(r'FIT'),
@JsonValue(r'TILE')
TILE(r'TILE'),
@JsonValue(r'STRETCH')
STRETCH(r'STRETCH');

const ImagePaintScaleModeEnum(this.value);

final String value;

@override
String toString() => value;
}


