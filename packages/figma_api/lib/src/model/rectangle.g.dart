// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'rectangle.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Rectangle _$RectangleFromJson(Map<String, dynamic> json) => $checkedCreate(
      'Rectangle',
      json,
      ($checkedConvert) {
        $checkKeys(
          json,
          requiredKeys: const ['x', 'y', 'width', 'height'],
        );
        final val = Rectangle(
          x: $checkedConvert('x', (v) => v as num),
          y: $checkedConvert('y', (v) => v as num),
          width: $checkedConvert('width', (v) => v as num),
          height: $checkedConvert('height', (v) => v as num),
        );
        return val;
      },
    );

Map<String, dynamic> _$RectangleToJson(Rectangle instance) => <String, dynamic>{
      'x': instance.x,
      'y': instance.y,
      'width': instance.width,
      'height': instance.height,
    };
