// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'paint.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Paint _$PaintFromJson(Map<String, dynamic> json) => $checkedCreate(
      'Paint',
      json,
      ($checkedConvert) {
        $checkKeys(
          json,
          requiredKeys: const ['type'],
        );
        final val = Paint(
          type: $checkedConvert(
              'type', (v) => $enumDecode(_$PaintTypeEnumEnumMap, v)),
          visible: $checkedConvert('visible', (v) => v as bool? ?? true),
          opacity: $checkedConvert('opacity', (v) => v as num? ?? 1),
          color: $checkedConvert(
              'color',
              (v) =>
                  v == null ? null : Color.fromJson(v as Map<String, dynamic>)),
          gradientHandlePositions: $checkedConvert(
              'gradientHandlePositions',
              (v) => (v as List<dynamic>?)
                  ?.map((e) => Vector.fromJson(e as Map<String, dynamic>))
                  .toList()),
          gradientStops: $checkedConvert(
              'gradientStops',
              (v) => (v as List<dynamic>?)
                  ?.map((e) => ColorStop.fromJson(e as Map<String, dynamic>))
                  .toList()),
          blendMode: $checkedConvert(
              'blendMode', (v) => $enumDecodeNullable(_$BlendModeEnumMap, v)),
          imageRef: $checkedConvert('imageRef', (v) => v as String?),
          imageTransform: $checkedConvert(
              'imageTransform',
              (v) => (v as List<dynamic>?)
                  ?.map(
                      (e) => (e as List<dynamic>).map((e) => e as num).toList())
                  .toList()),
          scaleMode: $checkedConvert('scaleMode',
              (v) => $enumDecodeNullable(_$PaintScaleModeEnumEnumMap, v)),
          scalingFactor: $checkedConvert('scalingFactor', (v) => v as num?),
        );
        return val;
      },
    );

Map<String, dynamic> _$PaintToJson(Paint instance) => <String, dynamic>{
      'type': _$PaintTypeEnumEnumMap[instance.type]!,
      if (instance.visible case final value?) 'visible': value,
      if (instance.opacity case final value?) 'opacity': value,
      if (instance.color?.toJson() case final value?) 'color': value,
      if (instance.gradientHandlePositions?.map((e) => e.toJson()).toList()
          case final value?)
        'gradientHandlePositions': value,
      if (instance.gradientStops?.map((e) => e.toJson()).toList()
          case final value?)
        'gradientStops': value,
      if (_$BlendModeEnumMap[instance.blendMode] case final value?)
        'blendMode': value,
      if (instance.imageRef case final value?) 'imageRef': value,
      if (instance.imageTransform case final value?) 'imageTransform': value,
      if (_$PaintScaleModeEnumEnumMap[instance.scaleMode] case final value?)
        'scaleMode': value,
      if (instance.scalingFactor case final value?) 'scalingFactor': value,
    };

const _$PaintTypeEnumEnumMap = {
  PaintTypeEnum.SOLID: 'SOLID',
  PaintTypeEnum.GRADIENT_LINEAR: 'GRADIENT_LINEAR',
  PaintTypeEnum.GRADIENT_RADIAL: 'GRADIENT_RADIAL',
  PaintTypeEnum.GRADIENT_ANGULAR: 'GRADIENT_ANGULAR',
  PaintTypeEnum.GRADIENT_DIAMOND: 'GRADIENT_DIAMOND',
  PaintTypeEnum.IMAGE: 'IMAGE',
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

const _$PaintScaleModeEnumEnumMap = {
  PaintScaleModeEnum.FILL: 'FILL',
  PaintScaleModeEnum.FIT: 'FIT',
  PaintScaleModeEnum.TILE: 'TILE',
  PaintScaleModeEnum.STRETCH: 'STRETCH',
};
