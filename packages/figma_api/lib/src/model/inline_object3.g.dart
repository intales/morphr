// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'inline_object3.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

InlineObject3 _$InlineObject3FromJson(Map<String, dynamic> json) =>
    $checkedCreate(
      'InlineObject3',
      json,
      ($checkedConvert) {
        $checkKeys(
          json,
          requiredKeys: const ['status', 'err'],
        );
        final val = InlineObject3(
          status: $checkedConvert('status',
              (v) => $enumDecode(_$InlineObject3StatusEnumEnumMap, v)),
          err: $checkedConvert('err', (v) => v as String),
        );
        return val;
      },
    );

Map<String, dynamic> _$InlineObject3ToJson(InlineObject3 instance) =>
    <String, dynamic>{
      'status': _$InlineObject3StatusEnumEnumMap[instance.status]!,
      'err': instance.err,
    };

const _$InlineObject3StatusEnumEnumMap = {
  InlineObject3StatusEnum.n429: '429',
};
