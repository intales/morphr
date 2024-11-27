// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'group_node.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GroupNode _$GroupNodeFromJson(Map<String, dynamic> json) => $checkedCreate(
      'GroupNode',
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
            'children',
            'type'
          ],
        );
        final val = GroupNode(
          id: $checkedConvert('id', (v) => v as String),
          name: $checkedConvert('name', (v) => v as String),
          visible: $checkedConvert('visible', (v) => v as bool? ?? true),
          locked: $checkedConvert('locked', (v) => v as bool? ?? false),
          x: $checkedConvert('x', (v) => v as num),
          y: $checkedConvert('y', (v) => v as num),
          width: $checkedConvert('width', (v) => v as num),
          height: $checkedConvert('height', (v) => v as num),
          rotation: $checkedConvert('rotation', (v) => v as num? ?? 0),
          children: $checkedConvert(
              'children',
              (v) => (v as List<dynamic>)
                  .map((e) => Node.fromJson(e as Map<String, dynamic>))
                  .toList()),
          type: $checkedConvert(
              'type', (v) => $enumDecode(_$GroupNodeTypeEnumEnumMap, v)),
        );
        return val;
      },
    );

Map<String, dynamic> _$GroupNodeToJson(GroupNode instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      if (instance.visible case final value?) 'visible': value,
      if (instance.locked case final value?) 'locked': value,
      'x': instance.x,
      'y': instance.y,
      'width': instance.width,
      'height': instance.height,
      if (instance.rotation case final value?) 'rotation': value,
      'children': instance.children.map((e) => e.toJson()).toList(),
      'type': _$GroupNodeTypeEnumEnumMap[instance.type]!,
    };

const _$GroupNodeTypeEnumEnumMap = {
  GroupNodeTypeEnum.GROUP: 'GROUP',
};
