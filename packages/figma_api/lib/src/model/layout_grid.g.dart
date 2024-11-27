// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'layout_grid.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LayoutGrid _$LayoutGridFromJson(Map<String, dynamic> json) => $checkedCreate(
      'LayoutGrid',
      json,
      ($checkedConvert) {
        $checkKeys(
          json,
          requiredKeys: const ['pattern', 'sectionSize'],
        );
        final val = LayoutGrid(
          pattern: $checkedConvert(
              'pattern', (v) => $enumDecode(_$LayoutGridPatternEnumEnumMap, v)),
          sectionSize: $checkedConvert('sectionSize', (v) => v as num),
          visible: $checkedConvert('visible', (v) => v as bool? ?? true),
          color: $checkedConvert(
              'color',
              (v) =>
                  v == null ? null : Color.fromJson(v as Map<String, dynamic>)),
          alignment: $checkedConvert('alignment',
              (v) => $enumDecodeNullable(_$LayoutGridAlignmentEnumEnumMap, v)),
          gutterSize: $checkedConvert('gutterSize', (v) => v as num?),
          offset: $checkedConvert('offset', (v) => v as num?),
          count: $checkedConvert('count', (v) => v as num?),
        );
        return val;
      },
    );

Map<String, dynamic> _$LayoutGridToJson(LayoutGrid instance) =>
    <String, dynamic>{
      'pattern': _$LayoutGridPatternEnumEnumMap[instance.pattern]!,
      'sectionSize': instance.sectionSize,
      if (instance.visible case final value?) 'visible': value,
      if (instance.color?.toJson() case final value?) 'color': value,
      if (_$LayoutGridAlignmentEnumEnumMap[instance.alignment]
          case final value?)
        'alignment': value,
      if (instance.gutterSize case final value?) 'gutterSize': value,
      if (instance.offset case final value?) 'offset': value,
      if (instance.count case final value?) 'count': value,
    };

const _$LayoutGridPatternEnumEnumMap = {
  LayoutGridPatternEnum.COLUMNS: 'COLUMNS',
  LayoutGridPatternEnum.ROWS: 'ROWS',
  LayoutGridPatternEnum.GRID: 'GRID',
};

const _$LayoutGridAlignmentEnumEnumMap = {
  LayoutGridAlignmentEnum.MIN: 'MIN',
  LayoutGridAlignmentEnum.MAX: 'MAX',
  LayoutGridAlignmentEnum.CENTER: 'CENTER',
  LayoutGridAlignmentEnum.STRETCH: 'STRETCH',
};
