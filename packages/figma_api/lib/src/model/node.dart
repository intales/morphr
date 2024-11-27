//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:figma_api/src/model/paint.dart';
import 'package:figma_api/src/model/rectangle.dart';
import 'package:figma_api/src/model/easing_type.dart';
import 'package:figma_api/src/model/effect.dart';
import 'package:figma_api/src/model/blend_mode.dart';
import 'package:figma_api/src/model/layout_constraint.dart';
import 'package:figma_api/src/model/layout_grid.dart';
import 'package:figma_api/src/model/export_setting.dart';
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

    required  this.id,

     this.name,

    required  this.type,

     this.visible = true,

     this.locked = false,

     this.opacity = 1,

     this.blendMode,

     this.preserveRatio = false,

     this.layoutAlign,

     this.constraints,

     this.transitionNodeID,

     this.transitionDuration,

     this.transitionEasing,

     this.absoluteBoundingBox,

     this.fills,

     this.strokes,

     this.strokeWeight,

     this.strokeAlign,

     this.strokeDashes,

     this.cornerRadius,

     this.rectangleCornerRadii,

     this.exportSettings,

     this.effects,

     this.isMask = false,

     this.layoutMode,

     this.primaryAxisSizingMode,

     this.counterAxisSizingMode,

     this.primaryAxisAlignItems,

     this.counterAxisAlignItems,

     this.paddingLeft,

     this.paddingRight,

     this.paddingTop,

     this.paddingBottom,

     this.itemSpacing,

     this.layoutGrids,

     this.clipsContent = true,

     this.children,
  });

  @JsonKey(
    
    name: r'id',
    required: true,
    includeIfNull: false,
  )


  final String id;



  @JsonKey(
    
    name: r'name',
    required: false,
    includeIfNull: false,
  )


  final String? name;



  @JsonKey(
    
    name: r'type',
    required: true,
    includeIfNull: false,
  )


  final NodeTypeEnum type;



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
    
    name: r'blendMode',
    required: false,
    includeIfNull: false,
  )


  final BlendMode? blendMode;



  @JsonKey(
    defaultValue: false,
    name: r'preserveRatio',
    required: false,
    includeIfNull: false,
  )


  final bool? preserveRatio;



  @JsonKey(
    
    name: r'layoutAlign',
    required: false,
    includeIfNull: false,
  )


  final NodeLayoutAlignEnum? layoutAlign;



  @JsonKey(
    
    name: r'constraints',
    required: false,
    includeIfNull: false,
  )


  final LayoutConstraint? constraints;



  @JsonKey(
    
    name: r'transitionNodeID',
    required: false,
    includeIfNull: false,
  )


  final String? transitionNodeID;



  @JsonKey(
    
    name: r'transitionDuration',
    required: false,
    includeIfNull: false,
  )


  final num? transitionDuration;



  @JsonKey(
    
    name: r'transitionEasing',
    required: false,
    includeIfNull: false,
  )


  final EasingType? transitionEasing;



  @JsonKey(
    
    name: r'absoluteBoundingBox',
    required: false,
    includeIfNull: false,
  )


  final Rectangle? absoluteBoundingBox;



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
    
    name: r'strokeAlign',
    required: false,
    includeIfNull: false,
  )


  final NodeStrokeAlignEnum? strokeAlign;



  @JsonKey(
    
    name: r'strokeDashes',
    required: false,
    includeIfNull: false,
  )


  final List<num>? strokeDashes;



  @JsonKey(
    
    name: r'cornerRadius',
    required: false,
    includeIfNull: false,
  )


  final num? cornerRadius;



  @JsonKey(
    
    name: r'rectangleCornerRadii',
    required: false,
    includeIfNull: false,
  )


  final List<num>? rectangleCornerRadii;



  @JsonKey(
    
    name: r'exportSettings',
    required: false,
    includeIfNull: false,
  )


  final List<ExportSetting>? exportSettings;



  @JsonKey(
    
    name: r'effects',
    required: false,
    includeIfNull: false,
  )


  final List<Effect>? effects;



  @JsonKey(
    defaultValue: false,
    name: r'isMask',
    required: false,
    includeIfNull: false,
  )


  final bool? isMask;



  @JsonKey(
    
    name: r'layoutMode',
    required: false,
    includeIfNull: false,
  )


  final NodeLayoutModeEnum? layoutMode;



  @JsonKey(
    
    name: r'primaryAxisSizingMode',
    required: false,
    includeIfNull: false,
  )


  final NodePrimaryAxisSizingModeEnum? primaryAxisSizingMode;



  @JsonKey(
    
    name: r'counterAxisSizingMode',
    required: false,
    includeIfNull: false,
  )


  final NodeCounterAxisSizingModeEnum? counterAxisSizingMode;



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
    
    name: r'layoutGrids',
    required: false,
    includeIfNull: false,
  )


  final List<LayoutGrid>? layoutGrids;



  @JsonKey(
    defaultValue: true,
    name: r'clipsContent',
    required: false,
    includeIfNull: false,
  )


  final bool? clipsContent;



  @JsonKey(
    
    name: r'children',
    required: false,
    includeIfNull: false,
  )


  final List<Node>? children;





    @override
    bool operator ==(Object other) => identical(this, other) || other is Node &&
      other.id == id &&
      other.name == name &&
      other.type == type &&
      other.visible == visible &&
      other.locked == locked &&
      other.opacity == opacity &&
      other.blendMode == blendMode &&
      other.preserveRatio == preserveRatio &&
      other.layoutAlign == layoutAlign &&
      other.constraints == constraints &&
      other.transitionNodeID == transitionNodeID &&
      other.transitionDuration == transitionDuration &&
      other.transitionEasing == transitionEasing &&
      other.absoluteBoundingBox == absoluteBoundingBox &&
      other.fills == fills &&
      other.strokes == strokes &&
      other.strokeWeight == strokeWeight &&
      other.strokeAlign == strokeAlign &&
      other.strokeDashes == strokeDashes &&
      other.cornerRadius == cornerRadius &&
      other.rectangleCornerRadii == rectangleCornerRadii &&
      other.exportSettings == exportSettings &&
      other.effects == effects &&
      other.isMask == isMask &&
      other.layoutMode == layoutMode &&
      other.primaryAxisSizingMode == primaryAxisSizingMode &&
      other.counterAxisSizingMode == counterAxisSizingMode &&
      other.primaryAxisAlignItems == primaryAxisAlignItems &&
      other.counterAxisAlignItems == counterAxisAlignItems &&
      other.paddingLeft == paddingLeft &&
      other.paddingRight == paddingRight &&
      other.paddingTop == paddingTop &&
      other.paddingBottom == paddingBottom &&
      other.itemSpacing == itemSpacing &&
      other.layoutGrids == layoutGrids &&
      other.clipsContent == clipsContent &&
      other.children == children;

    @override
    int get hashCode =>
        id.hashCode +
        name.hashCode +
        type.hashCode +
        visible.hashCode +
        locked.hashCode +
        opacity.hashCode +
        blendMode.hashCode +
        preserveRatio.hashCode +
        layoutAlign.hashCode +
        constraints.hashCode +
        transitionNodeID.hashCode +
        transitionDuration.hashCode +
        transitionEasing.hashCode +
        absoluteBoundingBox.hashCode +
        fills.hashCode +
        strokes.hashCode +
        strokeWeight.hashCode +
        strokeAlign.hashCode +
        strokeDashes.hashCode +
        cornerRadius.hashCode +
        rectangleCornerRadii.hashCode +
        exportSettings.hashCode +
        effects.hashCode +
        isMask.hashCode +
        layoutMode.hashCode +
        primaryAxisSizingMode.hashCode +
        counterAxisSizingMode.hashCode +
        primaryAxisAlignItems.hashCode +
        counterAxisAlignItems.hashCode +
        paddingLeft.hashCode +
        paddingRight.hashCode +
        paddingTop.hashCode +
        paddingBottom.hashCode +
        itemSpacing.hashCode +
        layoutGrids.hashCode +
        clipsContent.hashCode +
        children.hashCode;

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
TEXT(r'TEXT'),
@JsonValue(r'VECTOR')
VECTOR(r'VECTOR'),
@JsonValue(r'BOOLEAN_OPERATION')
BOOLEAN_OPERATION(r'BOOLEAN_OPERATION'),
@JsonValue(r'STAR')
STAR(r'STAR'),
@JsonValue(r'LINE')
LINE(r'LINE'),
@JsonValue(r'ELLIPSE')
ELLIPSE(r'ELLIPSE'),
@JsonValue(r'REGULAR_POLYGON')
REGULAR_POLYGON(r'REGULAR_POLYGON'),
@JsonValue(r'INSTANCE')
INSTANCE(r'INSTANCE'),
@JsonValue(r'COMPONENT')
COMPONENT(r'COMPONENT'),
@JsonValue(r'COMPONENT_SET')
COMPONENT_SET(r'COMPONENT_SET'),
@JsonValue(r'SECTION')
SECTION(r'SECTION'),
@JsonValue(r'STICKY')
STICKY(r'STICKY'),
@JsonValue(r'SHAPE_WITH_TEXT')
SHAPE_WITH_TEXT(r'SHAPE_WITH_TEXT'),
@JsonValue(r'CONNECTOR')
CONNECTOR(r'CONNECTOR'),
@JsonValue(r'TABLE')
TABLE(r'TABLE'),
@JsonValue(r'TABLE_CELL')
TABLE_CELL(r'TABLE_CELL'),
@JsonValue(r'SLICE')
SLICE(r'SLICE');

const NodeTypeEnum(this.value);

final String value;

@override
String toString() => value;
}



enum NodeLayoutAlignEnum {
@JsonValue(r'INHERIT')
INHERIT(r'INHERIT'),
@JsonValue(r'STRETCH')
STRETCH(r'STRETCH'),
@JsonValue(r'MIN')
MIN(r'MIN'),
@JsonValue(r'CENTER')
CENTER(r'CENTER'),
@JsonValue(r'MAX')
MAX(r'MAX');

const NodeLayoutAlignEnum(this.value);

final String value;

@override
String toString() => value;
}



enum NodeStrokeAlignEnum {
@JsonValue(r'INSIDE')
INSIDE(r'INSIDE'),
@JsonValue(r'OUTSIDE')
OUTSIDE(r'OUTSIDE'),
@JsonValue(r'CENTER')
CENTER(r'CENTER');

const NodeStrokeAlignEnum(this.value);

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



enum NodePrimaryAxisSizingModeEnum {
@JsonValue(r'FIXED')
FIXED(r'FIXED'),
@JsonValue(r'AUTO')
AUTO(r'AUTO');

const NodePrimaryAxisSizingModeEnum(this.value);

final String value;

@override
String toString() => value;
}



enum NodeCounterAxisSizingModeEnum {
@JsonValue(r'FIXED')
FIXED(r'FIXED'),
@JsonValue(r'AUTO')
AUTO(r'AUTO');

const NodeCounterAxisSizingModeEnum(this.value);

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


