// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'inline_object4.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

InlineObject4 _$InlineObject4FromJson(Map<String, dynamic> json) =>
    $checkedCreate(
      'InlineObject4',
      json,
      ($checkedConvert) {
        $checkKeys(
          json,
          requiredKeys: const ['status', 'err'],
        );
        final val = InlineObject4(
          status: $checkedConvert('status',
              (v) => $enumDecode(_$InlineObject4StatusEnumEnumMap, v)),
          err: $checkedConvert('err', (v) => v as String),
        );
        return val;
      },
    );

Map<String, dynamic> _$InlineObject4ToJson(InlineObject4 instance) =>
    <String, dynamic>{
      'status': _$InlineObject4StatusEnumEnumMap[instance.status]!,
      'err': instance.err,
    };

const _$InlineObject4StatusEnumEnumMap = {
  InlineObject4StatusEnum.n500: '500',
};
