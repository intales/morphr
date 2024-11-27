//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:figma_api/src/model/paint.dart';
import 'package:json_annotation/json_annotation.dart';

part 'rectangle_node.g.dart';


@JsonSerializable(
  checked: true,
  createToJson: true,
  disallowUnrecognizedKeys: false,
  explicitToJson: true,
)
class RectangleNode {
  /// Returns a new [RectangleNode] instance.
  RectangleNode({

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


  final RectangleNodeStrokeAlignEnum? strokeAlign;



  @JsonKey(
    
    name: r'type',
    required: true,
    includeIfNull: false,
  )


  final RectangleNodeTypeEnum type;





    @override
    bool operator ==(Object other) => identical(this, other) || other is RectangleNode &&
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
      other.type == type;

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
        type.hashCode;

  factory RectangleNode.fromJson(Map<String, dynamic> json) => _$RectangleNodeFromJson(json);

  Map<String, dynamic> toJson() => _$RectangleNodeToJson(this);

  @override
  String toString() {
    return toJson().toString();
  }

}


enum RectangleNodeStrokeAlignEnum {
@JsonValue(r'INSIDE')
INSIDE(r'INSIDE'),
@JsonValue(r'OUTSIDE')
OUTSIDE(r'OUTSIDE'),
@JsonValue(r'CENTER')
CENTER(r'CENTER');

const RectangleNodeStrokeAlignEnum(this.value);

final String value;

@override
String toString() => value;
}



enum RectangleNodeTypeEnum {
@JsonValue(r'RECTANGLE')
RECTANGLE(r'RECTANGLE');

const RectangleNodeTypeEnum(this.value);

final String value;

@override
String toString() => value;
}


