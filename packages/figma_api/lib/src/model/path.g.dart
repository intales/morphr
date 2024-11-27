// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'path.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Path _$PathFromJson(Map<String, dynamic> json) => $checkedCreate(
      'Path',
      json,
      ($checkedConvert) {
        final val = Path(
          path: $checkedConvert('path', (v) => v as String?),
          windingRule: $checkedConvert('windingRule',
              (v) => $enumDecodeNullable(_$PathWindingRuleEnumEnumMap, v)),
        );
        return val;
      },
    );

Map<String, dynamic> _$PathToJson(Path instance) => <String, dynamic>{
      if (instance.path case final value?) 'path': value,
      if (_$PathWindingRuleEnumEnumMap[instance.windingRule] case final value?)
        'windingRule': value,
    };

const _$PathWindingRuleEnumEnumMap = {
  PathWindingRuleEnum.NONZERO: 'NONZERO',
  PathWindingRuleEnum.EVENODD: 'EVENODD',
};
