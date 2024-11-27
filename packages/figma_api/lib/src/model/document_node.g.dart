// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'document_node.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DocumentNode _$DocumentNodeFromJson(Map<String, dynamic> json) =>
    $checkedCreate(
      'DocumentNode',
      json,
      ($checkedConvert) {
        $checkKeys(
          json,
          requiredKeys: const ['id', 'name', 'type', 'children'],
        );
        final val = DocumentNode(
          id: $checkedConvert('id', (v) => v as String),
          name: $checkedConvert('name', (v) => v as String),
          visible: $checkedConvert('visible', (v) => v as bool? ?? true),
          locked: $checkedConvert('locked', (v) => v as bool? ?? false),
          type: $checkedConvert(
              'type', (v) => $enumDecode(_$DocumentNodeTypeEnumEnumMap, v)),
          children: $checkedConvert(
              'children',
              (v) => (v as List<dynamic>)
                  .map((e) => CanvasNode.fromJson(e as Map<String, dynamic>))
                  .toList()),
        );
        return val;
      },
    );

Map<String, dynamic> _$DocumentNodeToJson(DocumentNode instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      if (instance.visible case final value?) 'visible': value,
      if (instance.locked case final value?) 'locked': value,
      'type': _$DocumentNodeTypeEnumEnumMap[instance.type]!,
      'children': instance.children.map((e) => e.toJson()).toList(),
    };

const _$DocumentNodeTypeEnumEnumMap = {
  DocumentNodeTypeEnum.DOCUMENT: 'DOCUMENT',
};
