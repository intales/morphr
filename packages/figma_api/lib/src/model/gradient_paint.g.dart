// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'gradient_paint.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GradientPaint _$GradientPaintFromJson(Map<String, dynamic> json) =>
    $checkedCreate(
      'GradientPaint',
      json,
      ($checkedConvert) {
        $checkKeys(
          json,
          requiredKeys: const ['type', 'gradientStops'],
        );
        final val = GradientPaint(
          type: $checkedConvert(
              'type', (v) => $enumDecode(_$GradientPaintTypeEnumEnumMap, v)),
          gradientStops: $checkedConvert(
              'gradientStops',
              (v) => (v as List<dynamic>)
                  .map((e) => ColorStop.fromJson(e as Map<String, dynamic>))
                  .toList()),
        );
        return val;
      },
    );

Map<String, dynamic> _$GradientPaintToJson(GradientPaint instance) =>
    <String, dynamic>{
      'type': _$GradientPaintTypeEnumEnumMap[instance.type]!,
      'gradientStops': instance.gradientStops.map((e) => e.toJson()).toList(),
    };

const _$GradientPaintTypeEnumEnumMap = {
  GradientPaintTypeEnum.LINEAR: 'GRADIENT_LINEAR',
  GradientPaintTypeEnum.RADIAL: 'GRADIENT_RADIAL',
  GradientPaintTypeEnum.ANGULAR: 'GRADIENT_ANGULAR',
  GradientPaintTypeEnum.DIAMOND: 'GRADIENT_DIAMOND',
};
