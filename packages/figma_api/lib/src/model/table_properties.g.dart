// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'table_properties.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TableProperties _$TablePropertiesFromJson(Map<String, dynamic> json) =>
    $checkedCreate(
      'TableProperties',
      json,
      ($checkedConvert) {
        final val = TableProperties(
          numRows: $checkedConvert('numRows', (v) => v as num?),
          numColumns: $checkedConvert('numColumns', (v) => v as num?),
          cellSpacing: $checkedConvert('cellSpacing', (v) => v as num?),
        );
        return val;
      },
    );

Map<String, dynamic> _$TablePropertiesToJson(TableProperties instance) =>
    <String, dynamic>{
      if (instance.numRows case final value?) 'numRows': value,
      if (instance.numColumns case final value?) 'numColumns': value,
      if (instance.cellSpacing case final value?) 'cellSpacing': value,
    };
