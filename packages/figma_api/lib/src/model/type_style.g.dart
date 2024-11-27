// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'type_style.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TypeStyle _$TypeStyleFromJson(Map<String, dynamic> json) => $checkedCreate(
      'TypeStyle',
      json,
      ($checkedConvert) {
        final val = TypeStyle(
          fontFamily: $checkedConvert('fontFamily', (v) => v as String?),
          fontSize: $checkedConvert('fontSize', (v) => v as num?),
          fontWeight: $checkedConvert('fontWeight', (v) => v as num?),
          textAlignHorizontal: $checkedConvert(
              'textAlignHorizontal',
              (v) => $enumDecodeNullable(
                  _$TypeStyleTextAlignHorizontalEnumEnumMap, v)),
          textCase: $checkedConvert('textCase',
              (v) => $enumDecodeNullable(_$TypeStyleTextCaseEnumEnumMap, v)),
          textAlignVertical: $checkedConvert(
              'textAlignVertical',
              (v) => $enumDecodeNullable(
                  _$TypeStyleTextAlignVerticalEnumEnumMap, v)),
          letterSpacing: $checkedConvert('letterSpacing', (v) => v as num?),
          lineHeightPx: $checkedConvert('lineHeightPx', (v) => v as num?),
          italic: $checkedConvert('italic', (v) => v as bool?),
          fills: $checkedConvert(
              'fills',
              (v) => (v as List<dynamic>?)
                  ?.map((e) => Paint.fromJson(e as Map<String, dynamic>))
                  .toList()),
        );
        return val;
      },
    );

Map<String, dynamic> _$TypeStyleToJson(TypeStyle instance) => <String, dynamic>{
      if (instance.fontFamily case final value?) 'fontFamily': value,
      if (instance.fontSize case final value?) 'fontSize': value,
      if (instance.fontWeight case final value?) 'fontWeight': value,
      if (_$TypeStyleTextAlignHorizontalEnumEnumMap[
              instance.textAlignHorizontal]
          case final value?)
        'textAlignHorizontal': value,
      if (_$TypeStyleTextCaseEnumEnumMap[instance.textCase] case final value?)
        'textCase': value,
      if (_$TypeStyleTextAlignVerticalEnumEnumMap[instance.textAlignVertical]
          case final value?)
        'textAlignVertical': value,
      if (instance.letterSpacing case final value?) 'letterSpacing': value,
      if (instance.lineHeightPx case final value?) 'lineHeightPx': value,
      if (instance.italic case final value?) 'italic': value,
      if (instance.fills?.map((e) => e.toJson()).toList() case final value?)
        'fills': value,
    };

const _$TypeStyleTextAlignHorizontalEnumEnumMap = {
  TypeStyleTextAlignHorizontalEnum.LEFT: 'LEFT',
  TypeStyleTextAlignHorizontalEnum.RIGHT: 'RIGHT',
  TypeStyleTextAlignHorizontalEnum.CENTER: 'CENTER',
  TypeStyleTextAlignHorizontalEnum.JUSTIFIED: 'JUSTIFIED',
};

const _$TypeStyleTextCaseEnumEnumMap = {
  TypeStyleTextCaseEnum.UPPER: 'UPPER',
  TypeStyleTextCaseEnum.LOWER: 'LOWER',
  TypeStyleTextCaseEnum.TITLE: 'TITLE',
  TypeStyleTextCaseEnum.SMALL_CAPS: 'SMALL_CAPS',
};

const _$TypeStyleTextAlignVerticalEnumEnumMap = {
  TypeStyleTextAlignVerticalEnum.TOP: 'TOP',
  TypeStyleTextAlignVerticalEnum.CENTER: 'CENTER',
  TypeStyleTextAlignVerticalEnum.BOTTOM: 'BOTTOM',
};
