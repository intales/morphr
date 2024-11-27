//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:figma_api/src/model/rgba.dart';
import 'package:figma_api/src/model/node.dart';
import 'package:json_annotation/json_annotation.dart';

part 'canvas_node.g.dart';


@JsonSerializable(
  checked: true,
  createToJson: true,
  disallowUnrecognizedKeys: false,
  explicitToJson: true,
)
class CanvasNode {
  /// Returns a new [CanvasNode] instance.
  CanvasNode({

    required  this.id,

    required  this.name,

     this.visible = true,

     this.locked = false,

    required  this.type,

    required  this.children,

    required  this.backgroundColor,
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
    
    name: r'type',
    required: true,
    includeIfNull: false,
  )


  final CanvasNodeTypeEnum type;



  @JsonKey(
    
    name: r'children',
    required: true,
    includeIfNull: false,
  )


  final List<Node> children;



  @JsonKey(
    
    name: r'backgroundColor',
    required: true,
    includeIfNull: false,
  )


  final RGBA backgroundColor;





    @override
    bool operator ==(Object other) => identical(this, other) || other is CanvasNode &&
      other.id == id &&
      other.name == name &&
      other.visible == visible &&
      other.locked == locked &&
      other.type == type &&
      other.children == children &&
      other.backgroundColor == backgroundColor;

    @override
    int get hashCode =>
        id.hashCode +
        name.hashCode +
        visible.hashCode +
        locked.hashCode +
        type.hashCode +
        children.hashCode +
        backgroundColor.hashCode;

  factory CanvasNode.fromJson(Map<String, dynamic> json) => _$CanvasNodeFromJson(json);

  Map<String, dynamic> toJson() => _$CanvasNodeToJson(this);

  @override
  String toString() {
    return toJson().toString();
  }

}


enum CanvasNodeTypeEnum {
@JsonValue(r'CANVAS')
CANVAS(r'CANVAS');

const CanvasNodeTypeEnum(this.value);

final String value;

@override
String toString() => value;
}


