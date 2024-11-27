// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'vector.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Vector _$VectorFromJson(Map<String, dynamic> json) => $checkedCreate(
      'Vector',
      json,
      ($checkedConvert) {
        $checkKeys(
          json,
          requiredKeys: const ['x', 'y'],
        );
        final val = Vector(
          x: $checkedConvert('x', (v) => v as num),
          y: $checkedConvert('y', (v) => v as num),
        );
        return val;
      },
    );

Map<String, dynamic> _$VectorToJson(Vector instance) => <String, dynamic>{
      'x': instance.x,
      'y': instance.y,
    };
