// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'vector_properties.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

VectorProperties _$VectorPropertiesFromJson(Map<String, dynamic> json) =>
    $checkedCreate(
      'VectorProperties',
      json,
      ($checkedConvert) {
        final val = VectorProperties(
          fillGeometry: $checkedConvert(
              'fillGeometry',
              (v) => (v as List<dynamic>?)
                  ?.map((e) => Path.fromJson(e as Map<String, dynamic>))
                  .toList()),
          strokeGeometry: $checkedConvert(
              'strokeGeometry',
              (v) => (v as List<dynamic>?)
                  ?.map((e) => Path.fromJson(e as Map<String, dynamic>))
                  .toList()),
          strokeCap: $checkedConvert(
              'strokeCap',
              (v) => $enumDecodeNullable(
                  _$VectorPropertiesStrokeCapEnumEnumMap, v)),
          strokeJoin: $checkedConvert(
              'strokeJoin',
              (v) => $enumDecodeNullable(
                  _$VectorPropertiesStrokeJoinEnumEnumMap, v)),
        );
        return val;
      },
    );

Map<String, dynamic> _$VectorPropertiesToJson(VectorProperties instance) =>
    <String, dynamic>{
      if (instance.fillGeometry?.map((e) => e.toJson()).toList()
          case final value?)
        'fillGeometry': value,
      if (instance.strokeGeometry?.map((e) => e.toJson()).toList()
          case final value?)
        'strokeGeometry': value,
      if (_$VectorPropertiesStrokeCapEnumEnumMap[instance.strokeCap]
          case final value?)
        'strokeCap': value,
      if (_$VectorPropertiesStrokeJoinEnumEnumMap[instance.strokeJoin]
          case final value?)
        'strokeJoin': value,
    };

const _$VectorPropertiesStrokeCapEnumEnumMap = {
  VectorPropertiesStrokeCapEnum.NONE: 'NONE',
  VectorPropertiesStrokeCapEnum.ROUND: 'ROUND',
  VectorPropertiesStrokeCapEnum.SQUARE: 'SQUARE',
  VectorPropertiesStrokeCapEnum.LINE_ARROW: 'LINE_ARROW',
  VectorPropertiesStrokeCapEnum.TRIANGLE_ARROW: 'TRIANGLE_ARROW',
};

const _$VectorPropertiesStrokeJoinEnumEnumMap = {
  VectorPropertiesStrokeJoinEnum.MITER: 'MITER',
  VectorPropertiesStrokeJoinEnum.BEVEL: 'BEVEL',
  VectorPropertiesStrokeJoinEnum.ROUND: 'ROUND',
};
