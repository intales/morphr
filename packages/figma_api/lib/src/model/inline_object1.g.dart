// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'inline_object1.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

InlineObject1 _$InlineObject1FromJson(Map<String, dynamic> json) =>
    $checkedCreate(
      'InlineObject1',
      json,
      ($checkedConvert) {
        $checkKeys(
          json,
          requiredKeys: const ['status', 'err'],
        );
        final val = InlineObject1(
          status: $checkedConvert('status',
              (v) => $enumDecode(_$InlineObject1StatusEnumEnumMap, v)),
          err: $checkedConvert('err', (v) => v as String),
        );
        return val;
      },
    );

Map<String, dynamic> _$InlineObject1ToJson(InlineObject1 instance) =>
    <String, dynamic>{
      'status': _$InlineObject1StatusEnumEnumMap[instance.status]!,
      'err': instance.err,
    };

const _$InlineObject1StatusEnumEnumMap = {
  InlineObject1StatusEnum.n403: '403',
};
