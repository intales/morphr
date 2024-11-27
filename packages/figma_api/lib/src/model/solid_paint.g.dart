// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'solid_paint.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SolidPaint _$SolidPaintFromJson(Map<String, dynamic> json) => $checkedCreate(
      'SolidPaint',
      json,
      ($checkedConvert) {
        $checkKeys(
          json,
          requiredKeys: const ['type', 'color'],
        );
        final val = SolidPaint(
          type: $checkedConvert(
              'type', (v) => $enumDecode(_$SolidPaintTypeEnumEnumMap, v)),
          color: $checkedConvert(
              'color', (v) => RGBA.fromJson(v as Map<String, dynamic>)),
        );
        return val;
      },
    );

Map<String, dynamic> _$SolidPaintToJson(SolidPaint instance) =>
    <String, dynamic>{
      'type': _$SolidPaintTypeEnumEnumMap[instance.type]!,
      'color': instance.color.toJson(),
    };

const _$SolidPaintTypeEnumEnumMap = {
  SolidPaintTypeEnum.SOLID: 'SOLID',
};
