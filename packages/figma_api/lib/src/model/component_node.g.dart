// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'component_node.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ComponentNode _$ComponentNodeFromJson(Map<String, dynamic> json) =>
    $checkedCreate(
      'ComponentNode',
      json,
      ($checkedConvert) {
        $checkKeys(
          json,
          requiredKeys: const [
            'id',
            'name',
            'x',
            'y',
            'width',
            'height',
            'fills',
            'strokes',
            'children',
            'type'
          ],
        );
        final val = ComponentNode(
          id: $checkedConvert('id', (v) => v as String),
          name: $checkedConvert('name', (v) => v as String),
          visible: $checkedConvert('visible', (v) => v as bool? ?? true),
          locked: $checkedConvert('locked', (v) => v as bool? ?? false),
          x: $checkedConvert('x', (v) => v as num),
          y: $checkedConvert('y', (v) => v as num),
          width: $checkedConvert('width', (v) => v as num),
          height: $checkedConvert('height', (v) => v as num),
          rotation: $checkedConvert('rotation', (v) => v as num? ?? 0),
          fills: $checkedConvert(
              'fills',
              (v) => (v as List<dynamic>)
                  .map((e) => Paint.fromJson(e as Map<String, dynamic>))
                  .toList()),
          strokes: $checkedConvert(
              'strokes',
              (v) => (v as List<dynamic>)
                  .map((e) => Paint.fromJson(e as Map<String, dynamic>))
                  .toList()),
          strokeWeight: $checkedConvert('strokeWeight', (v) => v as num? ?? 1),
          strokeAlign: $checkedConvert(
              'strokeAlign',
              (v) => $enumDecodeNullable(
                  _$ComponentNodeStrokeAlignEnumEnumMap, v)),
          children: $checkedConvert(
              'children',
              (v) => (v as List<dynamic>)
                  .map((e) => Node.fromJson(e as Map<String, dynamic>))
                  .toList()),
          type: $checkedConvert(
              'type', (v) => $enumDecode(_$ComponentNodeTypeEnumEnumMap, v)),
        );
        return val;
      },
    );

Map<String, dynamic> _$ComponentNodeToJson(ComponentNode instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      if (instance.visible case final value?) 'visible': value,
      if (instance.locked case final value?) 'locked': value,
      'x': instance.x,
      'y': instance.y,
      'width': instance.width,
      'height': instance.height,
      if (instance.rotation case final value?) 'rotation': value,
      'fills': instance.fills.map((e) => e.toJson()).toList(),
      'strokes': instance.strokes.map((e) => e.toJson()).toList(),
      if (instance.strokeWeight case final value?) 'strokeWeight': value,
      if (_$ComponentNodeStrokeAlignEnumEnumMap[instance.strokeAlign]
          case final value?)
        'strokeAlign': value,
      'children': instance.children.map((e) => e.toJson()).toList(),
      'type': _$ComponentNodeTypeEnumEnumMap[instance.type]!,
    };

const _$ComponentNodeStrokeAlignEnumEnumMap = {
  ComponentNodeStrokeAlignEnum.INSIDE: 'INSIDE',
  ComponentNodeStrokeAlignEnum.OUTSIDE: 'OUTSIDE',
  ComponentNodeStrokeAlignEnum.CENTER: 'CENTER',
};

const _$ComponentNodeTypeEnumEnumMap = {
  ComponentNodeTypeEnum.COMPONENT: 'COMPONENT',
};
