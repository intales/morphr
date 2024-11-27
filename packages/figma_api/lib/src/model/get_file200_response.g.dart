// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_file200_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GetFile200Response _$GetFile200ResponseFromJson(Map<String, dynamic> json) =>
    $checkedCreate(
      'GetFile200Response',
      json,
      ($checkedConvert) {
        final val = GetFile200Response(
          name: $checkedConvert('name', (v) => v as String?),
          lastModified: $checkedConvert('lastModified',
              (v) => v == null ? null : DateTime.parse(v as String)),
          version: $checkedConvert('version', (v) => v as String?),
          document: $checkedConvert(
              'document',
              (v) => v == null
                  ? null
                  : Document.fromJson(v as Map<String, dynamic>)),
        );
        return val;
      },
    );

Map<String, dynamic> _$GetFile200ResponseToJson(GetFile200Response instance) =>
    <String, dynamic>{
      if (instance.name case final value?) 'name': value,
      if (instance.lastModified?.toIso8601String() case final value?)
        'lastModified': value,
      if (instance.version case final value?) 'version': value,
      if (instance.document?.toJson() case final value?) 'document': value,
    };
