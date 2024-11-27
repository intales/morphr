// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'color_stop.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ColorStop _$ColorStopFromJson(Map<String, dynamic> json) => $checkedCreate(
      'ColorStop',
      json,
      ($checkedConvert) {
        $checkKeys(
          json,
          requiredKeys: const ['position', 'color'],
        );
        final val = ColorStop(
          position: $checkedConvert('position', (v) => v as num),
          color: $checkedConvert(
              'color', (v) => Color.fromJson(v as Map<String, dynamic>)),
        );
        return val;
      },
    );

Map<String, dynamic> _$ColorStopToJson(ColorStop instance) => <String, dynamic>{
      'position': instance.position,
      'color': instance.color.toJson(),
    };
