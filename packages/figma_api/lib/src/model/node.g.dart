// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'node.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Node _$NodeFromJson(Map<String, dynamic> json) => $checkedCreate(
      'Node',
      json,
      ($checkedConvert) {
        final val = Node(
          id: $checkedConvert('id', (v) => v as String?),
          name: $checkedConvert('name', (v) => v as String?),
          type: $checkedConvert(
              'type', (v) => $enumDecodeNullable(_$NodeTypeEnumEnumMap, v)),
          visible: $checkedConvert('visible', (v) => v as bool? ?? true),
          locked: $checkedConvert('locked', (v) => v as bool? ?? false),
          children: $checkedConvert(
              'children',
              (v) => (v as List<dynamic>?)
                  ?.map((e) => Node.fromJson(e as Map<String, dynamic>))
                  .toList()),
          absoluteBoundingBox: $checkedConvert(
              'absoluteBoundingBox',
              (v) => v == null
                  ? null
                  : Rectangle.fromJson(v as Map<String, dynamic>)),
          constraints: $checkedConvert(
              'constraints',
              (v) => v == null
                  ? null
                  : LayoutConstraint.fromJson(v as Map<String, dynamic>)),
          layoutMode: $checkedConvert('layoutMode',
              (v) => $enumDecodeNullable(_$NodeLayoutModeEnumEnumMap, v)),
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
          effects: $checkedConvert(
              'effects',
              (v) => (v as List<dynamic>?)
                  ?.map((e) => Effect.fromJson(e as Map<String, dynamic>))
                  .toList()),
          characters: $checkedConvert('characters', (v) => v as String?),
          style: $checkedConvert(
              'style',
              (v) => v == null
                  ? null
                  : TypeStyle.fromJson(v as Map<String, dynamic>)),
          cornerRadius: $checkedConvert('cornerRadius', (v) => v as num?),
        );
        return val;
      },
    );

Map<String, dynamic> _$NodeToJson(Node instance) => <String, dynamic>{
      if (instance.id case final value?) 'id': value,
      if (instance.name case final value?) 'name': value,
      if (_$NodeTypeEnumEnumMap[instance.type] case final value?) 'type': value,
      if (instance.visible case final value?) 'visible': value,
      if (instance.locked case final value?) 'locked': value,
      if (instance.children?.map((e) => e.toJson()).toList() case final value?)
        'children': value,
      if (instance.absoluteBoundingBox?.toJson() case final value?)
        'absoluteBoundingBox': value,
      if (instance.constraints?.toJson() case final value?)
        'constraints': value,
      if (_$NodeLayoutModeEnumEnumMap[instance.layoutMode] case final value?)
        'layoutMode': value,
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
      if (instance.fills?.map((e) => e.toJson()).toList() case final value?)
        'fills': value,
      if (instance.strokes?.map((e) => e.toJson()).toList() case final value?)
        'strokes': value,
      if (instance.strokeWeight case final value?) 'strokeWeight': value,
      if (instance.effects?.map((e) => e.toJson()).toList() case final value?)
        'effects': value,
      if (instance.characters case final value?) 'characters': value,
      if (instance.style?.toJson() case final value?) 'style': value,
      if (instance.cornerRadius case final value?) 'cornerRadius': value,
    };

const _$NodeTypeEnumEnumMap = {
  NodeTypeEnum.FRAME: 'FRAME',
  NodeTypeEnum.GROUP: 'GROUP',
  NodeTypeEnum.RECTANGLE: 'RECTANGLE',
  NodeTypeEnum.TEXT: 'TEXT',
};

const _$NodeLayoutModeEnumEnumMap = {
  NodeLayoutModeEnum.NONE: 'NONE',
  NodeLayoutModeEnum.HORIZONTAL: 'HORIZONTAL',
  NodeLayoutModeEnum.VERTICAL: 'VERTICAL',
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
