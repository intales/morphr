//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:figma_api/src/model/vector.dart';
import 'package:figma_api/src/model/color.dart';
import 'package:figma_api/src/model/blend_mode.dart';
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

     this.visible = true,

     this.radius,

     this.color,

     this.blendMode,

     this.offset,

     this.spread,

     this.showShadowBehindNode = false,
  });

  @JsonKey(
    
    name: r'type',
    required: true,
    includeIfNull: false,
  )


  final EffectTypeEnum type;



  @JsonKey(
    defaultValue: true,
    name: r'visible',
    required: false,
    includeIfNull: false,
  )


  final bool? visible;



  @JsonKey(
    
    name: r'radius',
    required: false,
    includeIfNull: false,
  )


  final num? radius;



  @JsonKey(
    
    name: r'color',
    required: false,
    includeIfNull: false,
  )


  final Color? color;



  @JsonKey(
    
    name: r'blendMode',
    required: false,
    includeIfNull: false,
  )


  final BlendMode? blendMode;



  @JsonKey(
    
    name: r'offset',
    required: false,
    includeIfNull: false,
  )


  final Vector? offset;



  @JsonKey(
    
    name: r'spread',
    required: false,
    includeIfNull: false,
  )


  final num? spread;



  @JsonKey(
    defaultValue: false,
    name: r'showShadowBehindNode',
    required: false,
    includeIfNull: false,
  )


  final bool? showShadowBehindNode;





    @override
    bool operator ==(Object other) => identical(this, other) || other is Effect &&
      other.type == type &&
      other.visible == visible &&
      other.radius == radius &&
      other.color == color &&
      other.blendMode == blendMode &&
      other.offset == offset &&
      other.spread == spread &&
      other.showShadowBehindNode == showShadowBehindNode;

    @override
    int get hashCode =>
        type.hashCode +
        visible.hashCode +
        radius.hashCode +
        color.hashCode +
        blendMode.hashCode +
        offset.hashCode +
        spread.hashCode +
        showShadowBehindNode.hashCode;

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
LAYER_BLUR(r'LAYER_BLUR'),
@JsonValue(r'BACKGROUND_BLUR')
BACKGROUND_BLUR(r'BACKGROUND_BLUR');

const EffectTypeEnum(this.value);

final String value;

@override
String toString() => value;
}


