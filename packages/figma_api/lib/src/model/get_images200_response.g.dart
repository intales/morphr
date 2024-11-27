// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_images200_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GetImages200Response _$GetImages200ResponseFromJson(
        Map<String, dynamic> json) =>
    $checkedCreate(
      'GetImages200Response',
      json,
      ($checkedConvert) {
        final val = GetImages200Response(
          images: $checkedConvert(
              'images',
              (v) => (v as Map<String, dynamic>?)?.map(
                    (k, e) => MapEntry(k, e as String),
                  )),
        );
        return val;
      },
    );

Map<String, dynamic> _$GetImages200ResponseToJson(
        GetImages200Response instance) =>
    <String, dynamic>{
      if (instance.images case final value?) 'images': value,
    };
