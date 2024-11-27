// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'image_paint.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ImagePaint _$ImagePaintFromJson(Map<String, dynamic> json) => $checkedCreate(
      'ImagePaint',
      json,
      ($checkedConvert) {
        $checkKeys(
          json,
          requiredKeys: const ['type', 'imageRef', 'scaleMode'],
        );
        final val = ImagePaint(
          type: $checkedConvert(
              'type', (v) => $enumDecode(_$ImagePaintTypeEnumEnumMap, v)),
          imageRef: $checkedConvert('imageRef', (v) => v as String),
          scaleMode: $checkedConvert('scaleMode',
              (v) => $enumDecode(_$ImagePaintScaleModeEnumEnumMap, v)),
        );
        return val;
      },
    );

Map<String, dynamic> _$ImagePaintToJson(ImagePaint instance) =>
    <String, dynamic>{
      'type': _$ImagePaintTypeEnumEnumMap[instance.type]!,
      'imageRef': instance.imageRef,
      'scaleMode': _$ImagePaintScaleModeEnumEnumMap[instance.scaleMode]!,
    };

const _$ImagePaintTypeEnumEnumMap = {
  ImagePaintTypeEnum.IMAGE: 'IMAGE',
};

const _$ImagePaintScaleModeEnumEnumMap = {
  ImagePaintScaleModeEnum.FILL: 'FILL',
  ImagePaintScaleModeEnum.FIT: 'FIT',
  ImagePaintScaleModeEnum.TILE: 'TILE',
  ImagePaintScaleModeEnum.STRETCH: 'STRETCH',
};
