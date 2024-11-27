// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'is_layer_trait.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

IsLayerTrait _$IsLayerTraitFromJson(Map<String, dynamic> json) =>
    $checkedCreate(
      'IsLayerTrait',
      json,
      ($checkedConvert) {
        $checkKeys(
          json,
          requiredKeys: const ['id', 'name'],
        );
        final val = IsLayerTrait(
          id: $checkedConvert('id', (v) => v as String),
          name: $checkedConvert('name', (v) => v as String),
          visible: $checkedConvert('visible', (v) => v as bool? ?? true),
          locked: $checkedConvert('locked', (v) => v as bool? ?? false),
        );
        return val;
      },
    );

Map<String, dynamic> _$IsLayerTraitToJson(IsLayerTrait instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      if (instance.visible case final value?) 'visible': value,
      if (instance.locked case final value?) 'locked': value,
    };
