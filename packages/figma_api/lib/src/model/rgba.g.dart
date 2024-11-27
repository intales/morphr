// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'rgba.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RGBA _$RGBAFromJson(Map<String, dynamic> json) => $checkedCreate(
      'RGBA',
      json,
      ($checkedConvert) {
        $checkKeys(
          json,
          requiredKeys: const ['r', 'g', 'b', 'a'],
        );
        final val = RGBA(
          r: $checkedConvert('r', (v) => v as num),
          g: $checkedConvert('g', (v) => v as num),
          b: $checkedConvert('b', (v) => v as num),
          a: $checkedConvert('a', (v) => v as num),
        );
        return val;
      },
    );

Map<String, dynamic> _$RGBAToJson(RGBA instance) => <String, dynamic>{
      'r': instance.r,
      'g': instance.g,
      'b': instance.b,
      'a': instance.a,
    };
