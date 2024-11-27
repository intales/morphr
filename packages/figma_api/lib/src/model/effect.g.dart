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
          visible: $checkedConvert('visible', (v) => v as bool? ?? true),
          radius: $checkedConvert('radius', (v) => v as num?),
          color: $checkedConvert(
              'color',
              (v) =>
                  v == null ? null : Color.fromJson(v as Map<String, dynamic>)),
          blendMode: $checkedConvert(
              'blendMode', (v) => $enumDecodeNullable(_$BlendModeEnumMap, v)),
          offset: $checkedConvert(
              'offset',
              (v) => v == null
                  ? null
                  : Vector.fromJson(v as Map<String, dynamic>)),
          spread: $checkedConvert('spread', (v) => v as num?),
          showShadowBehindNode: $checkedConvert(
              'showShadowBehindNode', (v) => v as bool? ?? false),
        );
        return val;
      },
    );

Map<String, dynamic> _$EffectToJson(Effect instance) => <String, dynamic>{
      'type': _$EffectTypeEnumEnumMap[instance.type]!,
      if (instance.visible case final value?) 'visible': value,
      if (instance.radius case final value?) 'radius': value,
      if (instance.color?.toJson() case final value?) 'color': value,
      if (_$BlendModeEnumMap[instance.blendMode] case final value?)
        'blendMode': value,
      if (instance.offset?.toJson() case final value?) 'offset': value,
      if (instance.spread case final value?) 'spread': value,
      if (instance.showShadowBehindNode case final value?)
        'showShadowBehindNode': value,
    };

const _$EffectTypeEnumEnumMap = {
  EffectTypeEnum.DROP_SHADOW: 'DROP_SHADOW',
  EffectTypeEnum.INNER_SHADOW: 'INNER_SHADOW',
  EffectTypeEnum.LAYER_BLUR: 'LAYER_BLUR',
  EffectTypeEnum.BACKGROUND_BLUR: 'BACKGROUND_BLUR',
};

const _$BlendModeEnumMap = {
  BlendMode.PASS_THROUGH: 'PASS_THROUGH',
  BlendMode.NORMAL: 'NORMAL',
  BlendMode.DARKEN: 'DARKEN',
  BlendMode.MULTIPLY: 'MULTIPLY',
  BlendMode.LINEAR_BURN: 'LINEAR_BURN',
  BlendMode.COLOR_BURN: 'COLOR_BURN',
  BlendMode.LIGHTEN: 'LIGHTEN',
  BlendMode.SCREEN: 'SCREEN',
  BlendMode.LINEAR_DODGE: 'LINEAR_DODGE',
  BlendMode.COLOR_DODGE: 'COLOR_DODGE',
  BlendMode.OVERLAY: 'OVERLAY',
  BlendMode.SOFT_LIGHT: 'SOFT_LIGHT',
  BlendMode.HARD_LIGHT: 'HARD_LIGHT',
  BlendMode.DIFFERENCE: 'DIFFERENCE',
  BlendMode.EXCLUSION: 'EXCLUSION',
  BlendMode.HUE: 'HUE',
  BlendMode.SATURATION: 'SATURATION',
  BlendMode.COLOR: 'COLOR',
  BlendMode.LUMINOSITY: 'LUMINOSITY',
};
