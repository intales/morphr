// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'document.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Document _$DocumentFromJson(Map<String, dynamic> json) => $checkedCreate(
      'Document',
      json,
      ($checkedConvert) {
        final val = Document(
          id: $checkedConvert('id', (v) => v as String?),
          name: $checkedConvert('name', (v) => v as String?),
          type: $checkedConvert(
              'type', (v) => $enumDecodeNullable(_$DocumentTypeEnumEnumMap, v)),
          children: $checkedConvert(
              'children',
              (v) => (v as List<dynamic>?)
                  ?.map((e) => Canvas.fromJson(e as Map<String, dynamic>))
                  .toList()),
        );
        return val;
      },
    );

Map<String, dynamic> _$DocumentToJson(Document instance) => <String, dynamic>{
      if (instance.id case final value?) 'id': value,
      if (instance.name case final value?) 'name': value,
      if (_$DocumentTypeEnumEnumMap[instance.type] case final value?)
        'type': value,
      if (instance.children?.map((e) => e.toJson()).toList() case final value?)
        'children': value,
    };

const _$DocumentTypeEnumEnumMap = {
  DocumentTypeEnum.DOCUMENT: 'DOCUMENT',
};
