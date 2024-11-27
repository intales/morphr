//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:figma_api/src/model/vector.dart';
import 'package:figma_api/src/model/color.dart';
import 'package:json_annotation/json_annotation.dart';

part 'effect.g.dart';


@JsonSerializable(
  checked: true,
  createToJson: true,
  disallowUnrecognizedKeys: false,
  explicitToJson: true,
)
class Effect {
  /// Returns a new [Effect] instance.
  Effect({

    required  this.type,

     this.color,

     this.offset,

     this.radius,

     this.visible = true,

     this.blendMode,
  });

  @JsonKey(
    
    name: r'type',
    required: true,
    includeIfNull: false,
  )


  final EffectTypeEnum type;



  @JsonKey(
    
    name: r'color',
    required: false,
    includeIfNull: false,
  )


  final Color? color;



  @JsonKey(
    
    name: r'offset',
    required: false,
    includeIfNull: false,
  )


  final Vector? offset;



  @JsonKey(
    
    name: r'radius',
    required: false,
    includeIfNull: false,
  )


  final num? radius;



  @JsonKey(
    defaultValue: true,
    name: r'visible',
    required: false,
    includeIfNull: false,
  )


  final bool? visible;



  @JsonKey(
    
    name: r'blendMode',
    required: false,
    includeIfNull: false,
  )


  final EffectBlendModeEnum? blendMode;





    @override
    bool operator ==(Object other) => identical(this, other) || other is Effect &&
      other.type == type &&
      other.color == color &&
      other.offset == offset &&
      other.radius == radius &&
      other.visible == visible &&
      other.blendMode == blendMode;

    @override
    int get hashCode =>
        type.hashCode +
        color.hashCode +
        offset.hashCode +
        radius.hashCode +
        visible.hashCode +
        blendMode.hashCode;

  factory Effect.fromJson(Map<String, dynamic> json) => _$EffectFromJson(json);

  Map<String, dynamic> toJson() => _$EffectToJson(this);

  @override
  String toString() {
    return toJson().toString();
  }

}


enum EffectTypeEnum {
@JsonValue(r'DROP_SHADOW')
DROP_SHADOW(r'DROP_SHADOW'),
@JsonValue(r'INNER_SHADOW')
INNER_SHADOW(r'INNER_SHADOW'),
@JsonValue(r'LAYER_BLUR')
LAYER_BLUR(r'LAYER_BLUR');

const EffectTypeEnum(this.value);

final String value;

@override
String toString() => value;
}



enum EffectBlendModeEnum {
@JsonValue(r'NORMAL')
NORMAL(r'NORMAL'),
@JsonValue(r'MULTIPLY')
MULTIPLY(r'MULTIPLY'),
@JsonValue(r'SCREEN')
SCREEN(r'SCREEN'),
@JsonValue(r'OVERLAY')
OVERLAY(r'OVERLAY');

const EffectBlendModeEnum(this.value);

final String value;

@override
String toString() => value;
}


