// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'text_node.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TextNode _$TextNodeFromJson(Map<String, dynamic> json) => $checkedCreate(
      'TextNode',
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
            'type',
            'characters'
          ],
        );
        final val = TextNode(
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
          strokeAlign: $checkedConvert('strokeAlign',
              (v) => $enumDecodeNullable(_$TextNodeStrokeAlignEnumEnumMap, v)),
          type: $checkedConvert(
              'type', (v) => $enumDecode(_$TextNodeTypeEnumEnumMap, v)),
          characters: $checkedConvert('characters', (v) => v as String),
        );
        return val;
      },
    );

Map<String, dynamic> _$TextNodeToJson(TextNode instance) => <String, dynamic>{
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
      if (_$TextNodeStrokeAlignEnumEnumMap[instance.strokeAlign]
          case final value?)
        'strokeAlign': value,
      'type': _$TextNodeTypeEnumEnumMap[instance.type]!,
      'characters': instance.characters,
    };

const _$TextNodeStrokeAlignEnumEnumMap = {
  TextNodeStrokeAlignEnum.INSIDE: 'INSIDE',
  TextNodeStrokeAlignEnum.OUTSIDE: 'OUTSIDE',
  TextNodeStrokeAlignEnum.CENTER: 'CENTER',
};

const _$TextNodeTypeEnumEnumMap = {
  TextNodeTypeEnum.TEXT: 'TEXT',
};
