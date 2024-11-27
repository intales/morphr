// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'constraint.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Constraint _$ConstraintFromJson(Map<String, dynamic> json) => $checkedCreate(
      'Constraint',
      json,
      ($checkedConvert) {
        $checkKeys(
          json,
          requiredKeys: const ['type', 'value'],
        );
        final val = Constraint(
          type: $checkedConvert(
              'type', (v) => $enumDecode(_$ConstraintTypeEnumEnumMap, v)),
          value: $checkedConvert('value', (v) => v as num),
        );
        return val;
      },
    );

Map<String, dynamic> _$ConstraintToJson(Constraint instance) =>
    <String, dynamic>{
      'type': _$ConstraintTypeEnumEnumMap[instance.type]!,
      'value': instance.value,
    };

const _$ConstraintTypeEnumEnumMap = {
  ConstraintTypeEnum.SCALE: 'SCALE',
  ConstraintTypeEnum.WIDTH: 'WIDTH',
  ConstraintTypeEnum.HEIGHT: 'HEIGHT',
};
