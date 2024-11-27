// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'inline_object2.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

InlineObject2 _$InlineObject2FromJson(Map<String, dynamic> json) =>
    $checkedCreate(
      'InlineObject2',
      json,
      ($checkedConvert) {
        $checkKeys(
          json,
          requiredKeys: const ['status', 'err'],
        );
        final val = InlineObject2(
          status: $checkedConvert('status',
              (v) => $enumDecode(_$InlineObject2StatusEnumEnumMap, v)),
          err: $checkedConvert('err', (v) => v as String),
        );
        return val;
      },
    );

Map<String, dynamic> _$InlineObject2ToJson(InlineObject2 instance) =>
    <String, dynamic>{
      'status': _$InlineObject2StatusEnumEnumMap[instance.status]!,
      'err': instance.err,
    };

const _$InlineObject2StatusEnumEnumMap = {
  InlineObject2StatusEnum.n404: '404',
};
