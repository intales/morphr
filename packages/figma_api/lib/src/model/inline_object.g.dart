// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'inline_object.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

InlineObject _$InlineObjectFromJson(Map<String, dynamic> json) =>
    $checkedCreate(
      'InlineObject',
      json,
      ($checkedConvert) {
        $checkKeys(
          json,
          requiredKeys: const ['status', 'err'],
        );
        final val = InlineObject(
          status: $checkedConvert(
              'status', (v) => $enumDecode(_$InlineObjectStatusEnumEnumMap, v)),
          err: $checkedConvert('err', (v) => v as String),
        );
        return val;
      },
    );

Map<String, dynamic> _$InlineObjectToJson(InlineObject instance) =>
    <String, dynamic>{
      'status': _$InlineObjectStatusEnumEnumMap[instance.status]!,
      'err': instance.err,
    };

const _$InlineObjectStatusEnumEnumMap = {
  InlineObjectStatusEnum.n400: '400',
};
