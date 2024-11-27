// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'component_property.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ComponentProperty _$ComponentPropertyFromJson(Map<String, dynamic> json) =>
    $checkedCreate(
      'ComponentProperty',
      json,
      ($checkedConvert) {
        final val = ComponentProperty(
          type: $checkedConvert(
              'type',
              (v) =>
                  $enumDecodeNullable(_$ComponentPropertyTypeEnumEnumMap, v)),
          value: $checkedConvert('value', (v) => v as String?),
        );
        return val;
      },
    );

Map<String, dynamic> _$ComponentPropertyToJson(ComponentProperty instance) =>
    <String, dynamic>{
      if (_$ComponentPropertyTypeEnumEnumMap[instance.type] case final value?)
        'type': value,
      if (instance.value case final value?) 'value': value,
    };

const _$ComponentPropertyTypeEnumEnumMap = {
  ComponentPropertyTypeEnum.BOOLEAN: 'BOOLEAN',
  ComponentPropertyTypeEnum.INSTANCE_SWAP: 'INSTANCE_SWAP',
  ComponentPropertyTypeEnum.TEXT: 'TEXT',
  ComponentPropertyTypeEnum.VARIANT: 'VARIANT',
};
