// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'node.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Node _$NodeFromJson(Map<String, dynamic> json) => $checkedCreate(
      'Node',
      json,
      ($checkedConvert) {
        $checkKeys(
          json,
          requiredKeys: const ['id', 'type'],
        );
        final val = Node(
          id: $checkedConvert('id', (v) => v as String),
          name: $checkedConvert('name', (v) => v as String?),
          type: $checkedConvert(
              'type', (v) => $enumDecode(_$NodeTypeEnumEnumMap, v)),
          visible: $checkedConvert('visible', (v) => v as bool? ?? true),
          locked: $checkedConvert('locked', (v) => v as bool? ?? false),
          opacity: $checkedConvert('opacity', (v) => v as num? ?? 1),
          blendMode: $checkedConvert(
              'blendMode', (v) => $enumDecodeNullable(_$BlendModeEnumMap, v)),
          preserveRatio:
              $checkedConvert('preserveRatio', (v) => v as bool? ?? false),
          layoutAlign: $checkedConvert('layoutAlign',
              (v) => $enumDecodeNullable(_$NodeLayoutAlignEnumEnumMap, v)),
          constraints: $checkedConvert(
              'constraints',
              (v) => v == null
                  ? null
                  : LayoutConstraint.fromJson(v as Map<String, dynamic>)),
          transitionNodeID:
              $checkedConvert('transitionNodeID', (v) => v as String?),
          transitionDuration:
              $checkedConvert('transitionDuration', (v) => v as num?),
          transitionEasing: $checkedConvert('transitionEasing',
              (v) => $enumDecodeNullable(_$EasingTypeEnumMap, v)),
          absoluteBoundingBox: $checkedConvert(
              'absoluteBoundingBox',
              (v) => v == null
                  ? null
                  : Rectangle.fromJson(v as Map<String, dynamic>)),
          fills: $checkedConvert(
              'fills',
              (v) => (v as List<dynamic>?)
                  ?.map((e) => Paint.fromJson(e as Map<String, dynamic>))
                  .toList()),
          strokes: $checkedConvert(
              'strokes',
              (v) => (v as List<dynamic>?)
                  ?.map((e) => Paint.fromJson(e as Map<String, dynamic>))
                  .toList()),
          strokeWeight: $checkedConvert('strokeWeight', (v) => v as num?),
          strokeAlign: $checkedConvert('strokeAlign',
              (v) => $enumDecodeNullable(_$NodeStrokeAlignEnumEnumMap, v)),
          strokeDashes: $checkedConvert('strokeDashes',
              (v) => (v as List<dynamic>?)?.map((e) => e as num).toList()),
          cornerRadius: $checkedConvert('cornerRadius', (v) => v as num?),
          rectangleCornerRadii: $checkedConvert('rectangleCornerRadii',
              (v) => (v as List<dynamic>?)?.map((e) => e as num).toList()),
          exportSettings: $checkedConvert(
              'exportSettings',
              (v) => (v as List<dynamic>?)
                  ?.map(
                      (e) => ExportSetting.fromJson(e as Map<String, dynamic>))
                  .toList()),
          effects: $checkedConvert(
              'effects',
              (v) => (v as List<dynamic>?)
                  ?.map((e) => Effect.fromJson(e as Map<String, dynamic>))
                  .toList()),
          isMask: $checkedConvert('isMask', (v) => v as bool? ?? false),
          layoutMode: $checkedConvert('layoutMode',
              (v) => $enumDecodeNullable(_$NodeLayoutModeEnumEnumMap, v)),
          primaryAxisSizingMode: $checkedConvert(
              'primaryAxisSizingMode',
              (v) => $enumDecodeNullable(
                  _$NodePrimaryAxisSizingModeEnumEnumMap, v)),
          counterAxisSizingMode: $checkedConvert(
              'counterAxisSizingMode',
              (v) => $enumDecodeNullable(
                  _$NodeCounterAxisSizingModeEnumEnumMap, v)),
          primaryAxisAlignItems: $checkedConvert(
              'primaryAxisAlignItems',
              (v) => $enumDecodeNullable(
                  _$NodePrimaryAxisAlignItemsEnumEnumMap, v)),
          counterAxisAlignItems: $checkedConvert(
              'counterAxisAlignItems',
              (v) => $enumDecodeNullable(
                  _$NodeCounterAxisAlignItemsEnumEnumMap, v)),
          paddingLeft: $checkedConvert('paddingLeft', (v) => v as num?),
          paddingRight: $checkedConvert('paddingRight', (v) => v as num?),
          paddingTop: $checkedConvert('paddingTop', (v) => v as num?),
          paddingBottom: $checkedConvert('paddingBottom', (v) => v as num?),
          itemSpacing: $checkedConvert('itemSpacing', (v) => v as num?),
          layoutGrids: $checkedConvert(
              'layoutGrids',
              (v) => (v as List<dynamic>?)
                  ?.map((e) => LayoutGrid.fromJson(e as Map<String, dynamic>))
                  .toList()),
          clipsContent:
              $checkedConvert('clipsContent', (v) => v as bool? ?? true),
          children: $checkedConvert(
              'children',
              (v) => (v as List<dynamic>?)
                  ?.map((e) => Node.fromJson(e as Map<String, dynamic>))
                  .toList()),
        );
        return val;
      },
    );

Map<String, dynamic> _$NodeToJson(Node instance) => <String, dynamic>{
      'id': instance.id,
      if (instance.name case final value?) 'name': value,
      'type': _$NodeTypeEnumEnumMap[instance.type]!,
      if (instance.visible case final value?) 'visible': value,
      if (instance.locked case final value?) 'locked': value,
      if (instance.opacity case final value?) 'opacity': value,
      if (_$BlendModeEnumMap[instance.blendMode] case final value?)
        'blendMode': value,
      if (instance.preserveRatio case final value?) 'preserveRatio': value,
      if (_$NodeLayoutAlignEnumEnumMap[instance.layoutAlign] case final value?)
        'layoutAlign': value,
      if (instance.constraints?.toJson() case final value?)
        'constraints': value,
      if (instance.transitionNodeID case final value?)
        'transitionNodeID': value,
      if (instance.transitionDuration case final value?)
        'transitionDuration': value,
      if (_$EasingTypeEnumMap[instance.transitionEasing] case final value?)
        'transitionEasing': value,
      if (instance.absoluteBoundingBox?.toJson() case final value?)
        'absoluteBoundingBox': value,
      if (instance.fills?.map((e) => e.toJson()).toList() case final value?)
        'fills': value,
      if (instance.strokes?.map((e) => e.toJson()).toList() case final value?)
        'strokes': value,
      if (instance.strokeWeight case final value?) 'strokeWeight': value,
      if (_$NodeStrokeAlignEnumEnumMap[instance.strokeAlign] case final value?)
        'strokeAlign': value,
      if (instance.strokeDashes case final value?) 'strokeDashes': value,
      if (instance.cornerRadius case final value?) 'cornerRadius': value,
      if (instance.rectangleCornerRadii case final value?)
        'rectangleCornerRadii': value,
      if (instance.exportSettings?.map((e) => e.toJson()).toList()
          case final value?)
        'exportSettings': value,
      if (instance.effects?.map((e) => e.toJson()).toList() case final value?)
        'effects': value,
      if (instance.isMask case final value?) 'isMask': value,
      if (_$NodeLayoutModeEnumEnumMap[instance.layoutMode] case final value?)
        'layoutMode': value,
      if (_$NodePrimaryAxisSizingModeEnumEnumMap[instance.primaryAxisSizingMode]
          case final value?)
        'primaryAxisSizingMode': value,
      if (_$NodeCounterAxisSizingModeEnumEnumMap[instance.counterAxisSizingMode]
          case final value?)
        'counterAxisSizingMode': value,
      if (_$NodePrimaryAxisAlignItemsEnumEnumMap[instance.primaryAxisAlignItems]
          case final value?)
        'primaryAxisAlignItems': value,
      if (_$NodeCounterAxisAlignItemsEnumEnumMap[instance.counterAxisAlignItems]
          case final value?)
        'counterAxisAlignItems': value,
      if (instance.paddingLeft case final value?) 'paddingLeft': value,
      if (instance.paddingRight case final value?) 'paddingRight': value,
      if (instance.paddingTop case final value?) 'paddingTop': value,
      if (instance.paddingBottom case final value?) 'paddingBottom': value,
      if (instance.itemSpacing case final value?) 'itemSpacing': value,
      if (instance.layoutGrids?.map((e) => e.toJson()).toList()
          case final value?)
        'layoutGrids': value,
      if (instance.clipsContent case final value?) 'clipsContent': value,
      if (instance.children?.map((e) => e.toJson()).toList() case final value?)
        'children': value,
    };

const _$NodeTypeEnumEnumMap = {
  NodeTypeEnum.FRAME: 'FRAME',
  NodeTypeEnum.GROUP: 'GROUP',
  NodeTypeEnum.RECTANGLE: 'RECTANGLE',
  NodeTypeEnum.TEXT: 'TEXT',
  NodeTypeEnum.VECTOR: 'VECTOR',
  NodeTypeEnum.BOOLEAN_OPERATION: 'BOOLEAN_OPERATION',
  NodeTypeEnum.STAR: 'STAR',
  NodeTypeEnum.LINE: 'LINE',
  NodeTypeEnum.ELLIPSE: 'ELLIPSE',
  NodeTypeEnum.REGULAR_POLYGON: 'REGULAR_POLYGON',
  NodeTypeEnum.INSTANCE: 'INSTANCE',
  NodeTypeEnum.COMPONENT: 'COMPONENT',
  NodeTypeEnum.COMPONENT_SET: 'COMPONENT_SET',
  NodeTypeEnum.SECTION: 'SECTION',
  NodeTypeEnum.STICKY: 'STICKY',
  NodeTypeEnum.SHAPE_WITH_TEXT: 'SHAPE_WITH_TEXT',
  NodeTypeEnum.CONNECTOR: 'CONNECTOR',
  NodeTypeEnum.TABLE: 'TABLE',
  NodeTypeEnum.TABLE_CELL: 'TABLE_CELL',
  NodeTypeEnum.SLICE: 'SLICE',
};

const _$BlendModeEnumMap = {
  BlendMode.PASS_THROUGH: 'PASS_THROUGH',
  BlendMode.NORMAL: 'NORMAL',
  BlendMode.DARKEN: 'DARKEN',
  BlendMode.MULTIPLY: 'MULTIPLY',
  BlendMode.LINEAR_BURN: 'LINEAR_BURN',
  BlendMode.COLOR_BURN: 'COLOR_BURN',
  BlendMode.LIGHTEN: 'LIGHTEN',
  BlendMode.SCREEN: 'SCREEN',
  BlendMode.LINEAR_DODGE: 'LINEAR_DODGE',
  BlendMode.COLOR_DODGE: 'COLOR_DODGE',
  BlendMode.OVERLAY: 'OVERLAY',
  BlendMode.SOFT_LIGHT: 'SOFT_LIGHT',
  BlendMode.HARD_LIGHT: 'HARD_LIGHT',
  BlendMode.DIFFERENCE: 'DIFFERENCE',
  BlendMode.EXCLUSION: 'EXCLUSION',
  BlendMode.HUE: 'HUE',
  BlendMode.SATURATION: 'SATURATION',
  BlendMode.COLOR: 'COLOR',
  BlendMode.LUMINOSITY: 'LUMINOSITY',
};

const _$NodeLayoutAlignEnumEnumMap = {
  NodeLayoutAlignEnum.INHERIT: 'INHERIT',
  NodeLayoutAlignEnum.STRETCH: 'STRETCH',
  NodeLayoutAlignEnum.MIN: 'MIN',
  NodeLayoutAlignEnum.CENTER: 'CENTER',
  NodeLayoutAlignEnum.MAX: 'MAX',
};

const _$EasingTypeEnumMap = {
  EasingType.EASE_IN: 'EASE_IN',
  EasingType.EASE_OUT: 'EASE_OUT',
  EasingType.EASE_IN_AND_OUT: 'EASE_IN_AND_OUT',
  EasingType.LINEAR: 'LINEAR',
};

const _$NodeStrokeAlignEnumEnumMap = {
  NodeStrokeAlignEnum.INSIDE: 'INSIDE',
  NodeStrokeAlignEnum.OUTSIDE: 'OUTSIDE',
  NodeStrokeAlignEnum.CENTER: 'CENTER',
};

const _$NodeLayoutModeEnumEnumMap = {
  NodeLayoutModeEnum.NONE: 'NONE',
  NodeLayoutModeEnum.HORIZONTAL: 'HORIZONTAL',
  NodeLayoutModeEnum.VERTICAL: 'VERTICAL',
};

const _$NodePrimaryAxisSizingModeEnumEnumMap = {
  NodePrimaryAxisSizingModeEnum.FIXED: 'FIXED',
  NodePrimaryAxisSizingModeEnum.AUTO: 'AUTO',
};

const _$NodeCounterAxisSizingModeEnumEnumMap = {
  NodeCounterAxisSizingModeEnum.FIXED: 'FIXED',
  NodeCounterAxisSizingModeEnum.AUTO: 'AUTO',
};

const _$NodePrimaryAxisAlignItemsEnumEnumMap = {
  NodePrimaryAxisAlignItemsEnum.MIN: 'MIN',
  NodePrimaryAxisAlignItemsEnum.CENTER: 'CENTER',
  NodePrimaryAxisAlignItemsEnum.MAX: 'MAX',
  NodePrimaryAxisAlignItemsEnum.SPACE_BETWEEN: 'SPACE_BETWEEN',
};

const _$NodeCounterAxisAlignItemsEnumEnumMap = {
  NodeCounterAxisAlignItemsEnum.MIN: 'MIN',
  NodeCounterAxisAlignItemsEnum.CENTER: 'CENTER',
  NodeCounterAxisAlignItemsEnum.MAX: 'MAX',
};
