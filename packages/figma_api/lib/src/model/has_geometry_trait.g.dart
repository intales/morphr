// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'has_geometry_trait.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

HasGeometryTrait _$HasGeometryTraitFromJson(Map<String, dynamic> json) =>
    $checkedCreate(
      'HasGeometryTrait',
      json,
      ($checkedConvert) {
        $checkKeys(
          json,
          requiredKeys: const ['fills', 'strokes'],
        );
        final val = HasGeometryTrait(
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
                  _$HasGeometryTraitStrokeAlignEnumEnumMap, v)),
        );
        return val;
      },
    );

Map<String, dynamic> _$HasGeometryTraitToJson(HasGeometryTrait instance) =>
    <String, dynamic>{
      'fills': instance.fills.map((e) => e.toJson()).toList(),
      'strokes': instance.strokes.map((e) => e.toJson()).toList(),
      if (instance.strokeWeight case final value?) 'strokeWeight': value,
      if (_$HasGeometryTraitStrokeAlignEnumEnumMap[instance.strokeAlign]
          case final value?)
        'strokeAlign': value,
    };

const _$HasGeometryTraitStrokeAlignEnumEnumMap = {
  HasGeometryTraitStrokeAlignEnum.INSIDE: 'INSIDE',
  HasGeometryTraitStrokeAlignEnum.OUTSIDE: 'OUTSIDE',
  HasGeometryTraitStrokeAlignEnum.CENTER: 'CENTER',
};
