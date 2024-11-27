// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'component_set.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ComponentSet _$ComponentSetFromJson(Map<String, dynamic> json) =>
    $checkedCreate(
      'ComponentSet',
      json,
      ($checkedConvert) {
        $checkKeys(
          json,
          requiredKeys: const ['key', 'name', 'description'],
        );
        final val = ComponentSet(
          key: $checkedConvert('key', (v) => v as String),
          name: $checkedConvert('name', (v) => v as String),
          description: $checkedConvert('description', (v) => v as String),
          remote: $checkedConvert('remote', (v) => v as bool?),
        );
        return val;
      },
    );

Map<String, dynamic> _$ComponentSetToJson(ComponentSet instance) =>
    <String, dynamic>{
      'key': instance.key,
      'name': instance.name,
      'description': instance.description,
      if (instance.remote case final value?) 'remote': value,
    };
