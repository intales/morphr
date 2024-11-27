// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'paint.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Paint _$PaintFromJson(Map<String, dynamic> json) => $checkedCreate(
      'Paint',
      json,
      ($checkedConvert) {
        $checkKeys(
          json,
          requiredKeys: const ['type'],
        );
        final val = Paint(
          type: $checkedConvert(
              'type', (v) => $enumDecode(_$PaintTypeEnumEnumMap, v)),
          color: $checkedConvert(
              'color',
              (v) =>
                  v == null ? null : Color.fromJson(v as Map<String, dynamic>)),
          opacity: $checkedConvert('opacity', (v) => v as num?),
          gradientHandlePositions: $checkedConvert(
              'gradientHandlePositions',
              (v) => (v as List<dynamic>?)
                  ?.map((e) => Vector.fromJson(e as Map<String, dynamic>))
                  .toList()),
          gradientStops: $checkedConvert(
              'gradientStops',
              (v) => (v as List<dynamic>?)
                  ?.map((e) => ColorStop.fromJson(e as Map<String, dynamic>))
                  .toList()),
        );
        return val;
      },
    );

Map<String, dynamic> _$PaintToJson(Paint instance) => <String, dynamic>{
      'type': _$PaintTypeEnumEnumMap[instance.type]!,
      if (instance.color?.toJson() case final value?) 'color': value,
      if (instance.opacity case final value?) 'opacity': value,
      if (instance.gradientHandlePositions?.map((e) => e.toJson()).toList()
          case final value?)
        'gradientHandlePositions': value,
      if (instance.gradientStops?.map((e) => e.toJson()).toList()
          case final value?)
        'gradientStops': value,
    };

const _$PaintTypeEnumEnumMap = {
  PaintTypeEnum.SOLID: 'SOLID',
  PaintTypeEnum.GRADIENT_LINEAR: 'GRADIENT_LINEAR',
  PaintTypeEnum.GRADIENT_RADIAL: 'GRADIENT_RADIAL',
};
