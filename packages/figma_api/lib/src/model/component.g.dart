// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'component.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Component _$ComponentFromJson(Map<String, dynamic> json) => $checkedCreate(
      'Component',
      json,
      ($checkedConvert) {
        $checkKeys(
          json,
          requiredKeys: const ['key', 'name', 'description', 'remote'],
        );
        final val = Component(
          key: $checkedConvert('key', (v) => v as String),
          name: $checkedConvert('name', (v) => v as String),
          description: $checkedConvert('description', (v) => v as String),
          remote: $checkedConvert('remote', (v) => v as bool),
        );
        return val;
      },
    );

Map<String, dynamic> _$ComponentToJson(Component instance) => <String, dynamic>{
      'key': instance.key,
      'name': instance.name,
      'description': instance.description,
      'remote': instance.remote,
    };
