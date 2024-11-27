// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'export_setting.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ExportSetting _$ExportSettingFromJson(Map<String, dynamic> json) =>
    $checkedCreate(
      'ExportSetting',
      json,
      ($checkedConvert) {
        $checkKeys(
          json,
          requiredKeys: const ['suffix', 'format', 'constraint'],
        );
        final val = ExportSetting(
          suffix: $checkedConvert('suffix', (v) => v as String),
          format: $checkedConvert('format',
              (v) => $enumDecode(_$ExportSettingFormatEnumEnumMap, v)),
          constraint: $checkedConvert('constraint',
              (v) => Constraint.fromJson(v as Map<String, dynamic>)),
        );
        return val;
      },
    );

Map<String, dynamic> _$ExportSettingToJson(ExportSetting instance) =>
    <String, dynamic>{
      'suffix': instance.suffix,
      'format': _$ExportSettingFormatEnumEnumMap[instance.format]!,
      'constraint': instance.constraint.toJson(),
    };

const _$ExportSettingFormatEnumEnumMap = {
  ExportSettingFormatEnum.JPG: 'JPG',
  ExportSettingFormatEnum.PNG: 'PNG',
  ExportSettingFormatEnum.SVG: 'SVG',
  ExportSettingFormatEnum.PDF: 'PDF',
};
