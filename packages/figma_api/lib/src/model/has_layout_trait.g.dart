// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'has_layout_trait.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

HasLayoutTrait _$HasLayoutTraitFromJson(Map<String, dynamic> json) =>
    $checkedCreate(
      'HasLayoutTrait',
      json,
      ($checkedConvert) {
        $checkKeys(
          json,
          requiredKeys: const ['x', 'y', 'width', 'height'],
        );
        final val = HasLayoutTrait(
          x: $checkedConvert('x', (v) => v as num),
          y: $checkedConvert('y', (v) => v as num),
          width: $checkedConvert('width', (v) => v as num),
          height: $checkedConvert('height', (v) => v as num),
          rotation: $checkedConvert('rotation', (v) => v as num? ?? 0),
        );
        return val;
      },
    );

Map<String, dynamic> _$HasLayoutTraitToJson(HasLayoutTrait instance) =>
    <String, dynamic>{
      'x': instance.x,
      'y': instance.y,
      'width': instance.width,
      'height': instance.height,
      if (instance.rotation case final value?) 'rotation': value,
    };
