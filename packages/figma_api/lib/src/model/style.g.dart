// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'style.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Style _$StyleFromJson(Map<String, dynamic> json) => $checkedCreate(
      'Style',
      json,
      ($checkedConvert) {
        final val = Style(
          key: $checkedConvert('key', (v) => v as String?),
          name: $checkedConvert('name', (v) => v as String?),
          styleType: $checkedConvert('styleType',
              (v) => $enumDecodeNullable(_$StyleStyleTypeEnumEnumMap, v)),
        );
        return val;
      },
    );

Map<String, dynamic> _$StyleToJson(Style instance) => <String, dynamic>{
      if (instance.key case final value?) 'key': value,
      if (instance.name case final value?) 'name': value,
      if (_$StyleStyleTypeEnumEnumMap[instance.styleType] case final value?)
        'styleType': value,
    };

const _$StyleStyleTypeEnumEnumMap = {
  StyleStyleTypeEnum.FILL: 'FILL',
  StyleStyleTypeEnum.TEXT: 'TEXT',
  StyleStyleTypeEnum.EFFECT: 'EFFECT',
  StyleStyleTypeEnum.GRID: 'GRID',
};
