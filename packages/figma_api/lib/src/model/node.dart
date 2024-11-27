//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:figma_api/src/model/paint.dart';
import 'package:figma_api/src/model/rectangle.dart';
import 'package:figma_api/src/model/type_style.dart';
import 'package:figma_api/src/model/effect.dart';
import 'package:figma_api/src/model/layout_constraint.dart';
import 'package:json_annotation/json_annotation.dart';

part 'node.g.dart';


@JsonSerializable(
  checked: true,
  createToJson: true,
  disallowUnrecognizedKeys: false,
  explicitToJson: true,
)
class Node {
  /// Returns a new [Node] instance.
  Node({

     this.id,

     this.name,

     this.type,

     this.visible = true,

     this.locked = false,

     this.children,

     this.absoluteBoundingBox,

     this.constraints,

     this.layoutMode,

     this.primaryAxisAlignItems,

     this.counterAxisAlignItems,

     this.paddingLeft,

     this.paddingRight,

     this.paddingTop,

     this.paddingBottom,

     this.itemSpacing,

     this.fills,

     this.strokes,

     this.strokeWeight,

     this.effects,

     this.characters,

     this.style,

     this.cornerRadius,
  });

  @JsonKey(
    
    name: r'id',
    required: false,
    includeIfNull: false,
  )


  final String? id;



  @JsonKey(
    
    name: r'name',
    required: false,
    includeIfNull: false,
  )


  final String? name;



  @JsonKey(
    
    name: r'type',
    required: false,
    includeIfNull: false,
  )


  final NodeTypeEnum? type;



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
    
    name: r'children',
    required: false,
    includeIfNull: false,
  )


  final List<Node>? children;



  @JsonKey(
    
    name: r'absoluteBoundingBox',
    required: false,
    includeIfNull: false,
  )


  final Rectangle? absoluteBoundingBox;



  @JsonKey(
    
    name: r'constraints',
    required: false,
    includeIfNull: false,
  )


  final LayoutConstraint? constraints;



  @JsonKey(
    
    name: r'layoutMode',
    required: false,
    includeIfNull: false,
  )


  final NodeLayoutModeEnum? layoutMode;



  @JsonKey(
    
    name: r'primaryAxisAlignItems',
    required: false,
    includeIfNull: false,
  )


  final NodePrimaryAxisAlignItemsEnum? primaryAxisAlignItems;



  @JsonKey(
    
    name: r'counterAxisAlignItems',
    required: false,
    includeIfNull: false,
  )


  final NodeCounterAxisAlignItemsEnum? counterAxisAlignItems;



  @JsonKey(
    
    name: r'paddingLeft',
    required: false,
    includeIfNull: false,
  )


  final num? paddingLeft;



  @JsonKey(
    
    name: r'paddingRight',
    required: false,
    includeIfNull: false,
  )


  final num? paddingRight;



  @JsonKey(
    
    name: r'paddingTop',
    required: false,
    includeIfNull: false,
  )


  final num? paddingTop;



  @JsonKey(
    
    name: r'paddingBottom',
    required: false,
    includeIfNull: false,
  )


  final num? paddingBottom;



  @JsonKey(
    
    name: r'itemSpacing',
    required: false,
    includeIfNull: false,
  )


  final num? itemSpacing;



  @JsonKey(
    
    name: r'fills',
    required: false,
    includeIfNull: false,
  )


  final List<Paint>? fills;



  @JsonKey(
    
    name: r'strokes',
    required: false,
    includeIfNull: false,
  )


  final List<Paint>? strokes;



  @JsonKey(
    
    name: r'strokeWeight',
    required: false,
    includeIfNull: false,
  )


  final num? strokeWeight;



  @JsonKey(
    
    name: r'effects',
    required: false,
    includeIfNull: false,
  )


  final List<Effect>? effects;



  @JsonKey(
    
    name: r'characters',
    required: false,
    includeIfNull: false,
  )


  final String? characters;



  @JsonKey(
    
    name: r'style',
    required: false,
    includeIfNull: false,
  )


  final TypeStyle? style;



  @JsonKey(
    
    name: r'cornerRadius',
    required: false,
    includeIfNull: false,
  )


  final num? cornerRadius;





    @override
    bool operator ==(Object other) => identical(this, other) || other is Node &&
      other.id == id &&
      other.name == name &&
      other.type == type &&
      other.visible == visible &&
      other.locked == locked &&
      other.children == children &&
      other.absoluteBoundingBox == absoluteBoundingBox &&
      other.constraints == constraints &&
      other.layoutMode == layoutMode &&
      other.primaryAxisAlignItems == primaryAxisAlignItems &&
      other.counterAxisAlignItems == counterAxisAlignItems &&
      other.paddingLeft == paddingLeft &&
      other.paddingRight == paddingRight &&
      other.paddingTop == paddingTop &&
      other.paddingBottom == paddingBottom &&
      other.itemSpacing == itemSpacing &&
      other.fills == fills &&
      other.strokes == strokes &&
      other.strokeWeight == strokeWeight &&
      other.effects == effects &&
      other.characters == characters &&
      other.style == style &&
      other.cornerRadius == cornerRadius;

    @override
    int get hashCode =>
        id.hashCode +
        name.hashCode +
        type.hashCode +
        visible.hashCode +
        locked.hashCode +
        children.hashCode +
        absoluteBoundingBox.hashCode +
        constraints.hashCode +
        layoutMode.hashCode +
        primaryAxisAlignItems.hashCode +
        counterAxisAlignItems.hashCode +
        paddingLeft.hashCode +
        paddingRight.hashCode +
        paddingTop.hashCode +
        paddingBottom.hashCode +
        itemSpacing.hashCode +
        fills.hashCode +
        strokes.hashCode +
        strokeWeight.hashCode +
        effects.hashCode +
        characters.hashCode +
        style.hashCode +
        cornerRadius.hashCode;

  factory Node.fromJson(Map<String, dynamic> json) => _$NodeFromJson(json);

  Map<String, dynamic> toJson() => _$NodeToJson(this);

  @override
  String toString() {
    return toJson().toString();
  }

}


enum NodeTypeEnum {
@JsonValue(r'FRAME')
FRAME(r'FRAME'),
@JsonValue(r'GROUP')
GROUP(r'GROUP'),
@JsonValue(r'RECTANGLE')
RECTANGLE(r'RECTANGLE'),
@JsonValue(r'TEXT')
TEXT(r'TEXT');

const NodeTypeEnum(this.value);

final String value;

@override
String toString() => value;
}



enum NodeLayoutModeEnum {
@JsonValue(r'NONE')
NONE(r'NONE'),
@JsonValue(r'HORIZONTAL')
HORIZONTAL(r'HORIZONTAL'),
@JsonValue(r'VERTICAL')
VERTICAL(r'VERTICAL');

const NodeLayoutModeEnum(this.value);

final String value;

@override
String toString() => value;
}



enum NodePrimaryAxisAlignItemsEnum {
@JsonValue(r'MIN')
MIN(r'MIN'),
@JsonValue(r'CENTER')
CENTER(r'CENTER'),
@JsonValue(r'MAX')
MAX(r'MAX'),
@JsonValue(r'SPACE_BETWEEN')
SPACE_BETWEEN(r'SPACE_BETWEEN');

const NodePrimaryAxisAlignItemsEnum(this.value);

final String value;

@override
String toString() => value;
}



enum NodeCounterAxisAlignItemsEnum {
@JsonValue(r'MIN')
MIN(r'MIN'),
@JsonValue(r'CENTER')
CENTER(r'CENTER'),
@JsonValue(r'MAX')
MAX(r'MAX');

const NodeCounterAxisAlignItemsEnum(this.value);

final String value;

@override
String toString() => value;
}


