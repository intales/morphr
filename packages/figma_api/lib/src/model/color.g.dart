// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'color.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Color _$ColorFromJson(Map<String, dynamic> json) => $checkedCreate(
      'Color',
      json,
      ($checkedConvert) {
        $checkKeys(
          json,
          requiredKeys: const ['r', 'g', 'b', 'a'],
        );
        final val = Color(
          r: $checkedConvert('r', (v) => v as num),
          g: $checkedConvert('g', (v) => v as num),
          b: $checkedConvert('b', (v) => v as num),
          a: $checkedConvert('a', (v) => v as num),
        );
        return val;
      },
    );

Map<String, dynamic> _$ColorToJson(Color instance) => <String, dynamic>{
      'r': instance.r,
      'g': instance.g,
      'b': instance.b,
      'a': instance.a,
    };
