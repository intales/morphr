//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:figma_api/src/model/paint.dart';
import 'package:json_annotation/json_annotation.dart';

part 'text_node.g.dart';


@JsonSerializable(
  checked: true,
  createToJson: true,
  disallowUnrecognizedKeys: false,
  explicitToJson: true,
)
class TextNode {
  /// Returns a new [TextNode] instance.
  TextNode({

    required  this.id,

    required  this.name,

     this.visible = true,

     this.locked = false,

    required  this.x,

    required  this.y,

    required  this.width,

    required  this.height,

     this.rotation = 0,

    required  this.fills,

    required  this.strokes,

     this.strokeWeight = 1,

     this.strokeAlign,

    required  this.type,

    required  this.characters,
  });

  @JsonKey(
    
    name: r'id',
    required: true,
    includeIfNull: false,
  )


  final String id;



  @JsonKey(
    
    name: r'name',
    required: true,
    includeIfNull: false,
  )


  final String name;



  @JsonKey(
    defaultValue: true,
    name: r'visible',
    required: false,
    includeIfNull: false,
  )


  final bool? visible;



  @JsonKey(
    defaultValue: false,
    name: r'locked',
    required: false,
    includeIfNull: false,
  )


  final bool? locked;



  @JsonKey(
    
    name: r'x',
    required: true,
    includeIfNull: false,
  )


  final num x;



  @JsonKey(
    
    name: r'y',
    required: true,
    includeIfNull: false,
  )


  final num y;



  @JsonKey(
    
    name: r'width',
    required: true,
    includeIfNull: false,
  )


  final num width;



  @JsonKey(
    
    name: r'height',
    required: true,
    includeIfNull: false,
  )


  final num height;



  @JsonKey(
    defaultValue: 0,
    name: r'rotation',
    required: false,
    includeIfNull: false,
  )


  final num? rotation;



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


  final TextNodeStrokeAlignEnum? strokeAlign;



  @JsonKey(
    
    name: r'type',
    required: true,
    includeIfNull: false,
  )


  final TextNodeTypeEnum type;



  @JsonKey(
    
    name: r'characters',
    required: true,
    includeIfNull: false,
  )


  final String characters;





    @override
    bool operator ==(Object other) => identical(this, other) || other is TextNode &&
      other.id == id &&
      other.name == name &&
      other.visible == visible &&
      other.locked == locked &&
      other.x == x &&
      other.y == y &&
      other.width == width &&
      other.height == height &&
      other.rotation == rotation &&
      other.fills == fills &&
      other.strokes == strokes &&
      other.strokeWeight == strokeWeight &&
      other.strokeAlign == strokeAlign &&
      other.type == type &&
      other.characters == characters;

    @override
    int get hashCode =>
        id.hashCode +
        name.hashCode +
        visible.hashCode +
        locked.hashCode +
        x.hashCode +
        y.hashCode +
        width.hashCode +
        height.hashCode +
        rotation.hashCode +
        fills.hashCode +
        strokes.hashCode +
        strokeWeight.hashCode +
        strokeAlign.hashCode +
        type.hashCode +
        characters.hashCode;

  factory TextNode.fromJson(Map<String, dynamic> json) => _$TextNodeFromJson(json);

  Map<String, dynamic> toJson() => _$TextNodeToJson(this);

  @override
  String toString() {
    return toJson().toString();
  }

}


enum TextNodeStrokeAlignEnum {
@JsonValue(r'INSIDE')
INSIDE(r'INSIDE'),
@JsonValue(r'OUTSIDE')
OUTSIDE(r'OUTSIDE'),
@JsonValue(r'CENTER')
CENTER(r'CENTER');

const TextNodeStrokeAlignEnum(this.value);

final String value;

@override
String toString() => value;
}



enum TextNodeTypeEnum {
@JsonValue(r'TEXT')
TEXT(r'TEXT');

const TextNodeTypeEnum(this.value);

final String value;

@override
String toString() => value;
}


