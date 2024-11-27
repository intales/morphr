// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'canvas_node.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CanvasNode _$CanvasNodeFromJson(Map<String, dynamic> json) => $checkedCreate(
      'CanvasNode',
      json,
      ($checkedConvert) {
        $checkKeys(
          json,
          requiredKeys: const [
            'id',
            'name',
            'type',
            'children',
            'backgroundColor'
          ],
        );
        final val = CanvasNode(
          id: $checkedConvert('id', (v) => v as String),
          name: $checkedConvert('name', (v) => v as String),
          visible: $checkedConvert('visible', (v) => v as bool? ?? true),
          locked: $checkedConvert('locked', (v) => v as bool? ?? false),
          type: $checkedConvert(
              'type', (v) => $enumDecode(_$CanvasNodeTypeEnumEnumMap, v)),
          children: $checkedConvert(
              'children',
              (v) => (v as List<dynamic>)
                  .map((e) => Node.fromJson(e as Map<String, dynamic>))
                  .toList()),
          backgroundColor: $checkedConvert('backgroundColor',
              (v) => RGBA.fromJson(v as Map<String, dynamic>)),
        );
        return val;
      },
    );

Map<String, dynamic> _$CanvasNodeToJson(CanvasNode instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      if (instance.visible case final value?) 'visible': value,
      if (instance.locked case final value?) 'locked': value,
      'type': _$CanvasNodeTypeEnumEnumMap[instance.type]!,
      'children': instance.children.map((e) => e.toJson()).toList(),
      'backgroundColor': instance.backgroundColor.toJson(),
    };

const _$CanvasNodeTypeEnumEnumMap = {
  CanvasNodeTypeEnum.CANVAS: 'CANVAS',
};
