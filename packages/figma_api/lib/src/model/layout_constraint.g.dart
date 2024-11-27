// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'layout_constraint.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LayoutConstraint _$LayoutConstraintFromJson(Map<String, dynamic> json) =>
    $checkedCreate(
      'LayoutConstraint',
      json,
      ($checkedConvert) {
        $checkKeys(
          json,
          requiredKeys: const ['vertical', 'horizontal'],
        );
        final val = LayoutConstraint(
          vertical: $checkedConvert('vertical',
              (v) => $enumDecode(_$LayoutConstraintVerticalEnumEnumMap, v)),
          horizontal: $checkedConvert('horizontal',
              (v) => $enumDecode(_$LayoutConstraintHorizontalEnumEnumMap, v)),
        );
        return val;
      },
    );

Map<String, dynamic> _$LayoutConstraintToJson(LayoutConstraint instance) =>
    <String, dynamic>{
      'vertical': _$LayoutConstraintVerticalEnumEnumMap[instance.vertical]!,
      'horizontal':
          _$LayoutConstraintHorizontalEnumEnumMap[instance.horizontal]!,
    };

const _$LayoutConstraintVerticalEnumEnumMap = {
  LayoutConstraintVerticalEnum.TOP: 'TOP',
  LayoutConstraintVerticalEnum.BOTTOM: 'BOTTOM',
  LayoutConstraintVerticalEnum.CENTER: 'CENTER',
  LayoutConstraintVerticalEnum.SCALE: 'SCALE',
  LayoutConstraintVerticalEnum.STRETCH: 'STRETCH',
  LayoutConstraintVerticalEnum.TOP_BOTTOM: 'TOP_BOTTOM',
};

const _$LayoutConstraintHorizontalEnumEnumMap = {
  LayoutConstraintHorizontalEnum.LEFT: 'LEFT',
  LayoutConstraintHorizontalEnum.RIGHT: 'RIGHT',
  LayoutConstraintHorizontalEnum.CENTER: 'CENTER',
  LayoutConstraintHorizontalEnum.SCALE: 'SCALE',
  LayoutConstraintHorizontalEnum.STRETCH: 'STRETCH',
  LayoutConstraintHorizontalEnum.LEFT_RIGHT: 'LEFT_RIGHT',
};
