// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'effect.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Effect _$EffectFromJson(Map<String, dynamic> json) => $checkedCreate(
      'Effect',
      json,
      ($checkedConvert) {
        $checkKeys(
          json,
          requiredKeys: const ['type'],
        );
        final val = Effect(
          type: $checkedConvert(
              'type', (v) => $enumDecode(_$EffectTypeEnumEnumMap, v)),
          color: $checkedConvert(
              'color',
              (v) =>
                  v == null ? null : Color.fromJson(v as Map<String, dynamic>)),
          offset: $checkedConvert(
              'offset',
              (v) => v == null
                  ? null
                  : Vector.fromJson(v as Map<String, dynamic>)),
          radius: $checkedConvert('radius', (v) => v as num?),
          visible: $checkedConvert('visible', (v) => v as bool? ?? true),
          blendMode: $checkedConvert('blendMode',
              (v) => $enumDecodeNullable(_$EffectBlendModeEnumEnumMap, v)),
        );
        return val;
      },
    );

Map<String, dynamic> _$EffectToJson(Effect instance) => <String, dynamic>{
      'type': _$EffectTypeEnumEnumMap[instance.type]!,
      if (instance.color?.toJson() case final value?) 'color': value,
      if (instance.offset?.toJson() case final value?) 'offset': value,
      if (instance.radius case final value?) 'radius': value,
      if (instance.visible case final value?) 'visible': value,
      if (_$EffectBlendModeEnumEnumMap[instance.blendMode] case final value?)
        'blendMode': value,
    };

const _$EffectTypeEnumEnumMap = {
  EffectTypeEnum.DROP_SHADOW: 'DROP_SHADOW',
  EffectTypeEnum.INNER_SHADOW: 'INNER_SHADOW',
  EffectTypeEnum.LAYER_BLUR: 'LAYER_BLUR',
};

const _$EffectBlendModeEnumEnumMap = {
  EffectBlendModeEnum.NORMAL: 'NORMAL',
  EffectBlendModeEnum.MULTIPLY: 'MULTIPLY',
  EffectBlendModeEnum.SCREEN: 'SCREEN',
  EffectBlendModeEnum.OVERLAY: 'OVERLAY',
};
