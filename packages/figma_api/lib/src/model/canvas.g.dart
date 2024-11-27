// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'canvas.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Canvas _$CanvasFromJson(Map<String, dynamic> json) => $checkedCreate(
      'Canvas',
      json,
      ($checkedConvert) {
        final val = Canvas(
          id: $checkedConvert('id', (v) => v as String?),
          name: $checkedConvert('name', (v) => v as String?),
          type: $checkedConvert(
              'type', (v) => $enumDecodeNullable(_$CanvasTypeEnumEnumMap, v)),
          children: $checkedConvert(
              'children',
              (v) => (v as List<dynamic>?)
                  ?.map((e) => Node.fromJson(e as Map<String, dynamic>))
                  .toList()),
          backgroundColor: $checkedConvert(
              'backgroundColor',
              (v) =>
                  v == null ? null : Color.fromJson(v as Map<String, dynamic>)),
        );
        return val;
      },
    );

Map<String, dynamic> _$CanvasToJson(Canvas instance) => <String, dynamic>{
      if (instance.id case final value?) 'id': value,
      if (instance.name case final value?) 'name': value,
      if (_$CanvasTypeEnumEnumMap[instance.type] case final value?)
        'type': value,
      if (instance.children?.map((e) => e.toJson()).toList() case final value?)
        'children': value,
      if (instance.backgroundColor?.toJson() case final value?)
        'backgroundColor': value,
    };

const _$CanvasTypeEnumEnumMap = {
  CanvasTypeEnum.CANVAS: 'CANVAS',
};
