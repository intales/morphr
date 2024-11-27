// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'boolean_operation.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BooleanOperation _$BooleanOperationFromJson(Map<String, dynamic> json) =>
    $checkedCreate(
      'BooleanOperation',
      json,
      ($checkedConvert) {
        final val = BooleanOperation(
          operation: $checkedConvert(
              'operation',
              (v) => $enumDecodeNullable(
                  _$BooleanOperationOperationEnumEnumMap, v)),
          children: $checkedConvert(
              'children',
              (v) => (v as List<dynamic>?)
                  ?.map((e) => Node.fromJson(e as Map<String, dynamic>))
                  .toList()),
        );
        return val;
      },
    );

Map<String, dynamic> _$BooleanOperationToJson(BooleanOperation instance) =>
    <String, dynamic>{
      if (_$BooleanOperationOperationEnumEnumMap[instance.operation]
          case final value?)
        'operation': value,
      if (instance.children?.map((e) => e.toJson()).toList() case final value?)
        'children': value,
    };

const _$BooleanOperationOperationEnumEnumMap = {
  BooleanOperationOperationEnum.UNION: 'UNION',
  BooleanOperationOperationEnum.INTERSECT: 'INTERSECT',
  BooleanOperationOperationEnum.SUBTRACT: 'SUBTRACT',
  BooleanOperationOperationEnum.EXCLUDE: 'EXCLUDE',
};
