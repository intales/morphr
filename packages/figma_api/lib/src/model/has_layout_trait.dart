//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:json_annotation/json_annotation.dart';

part 'has_layout_trait.g.dart';


@JsonSerializable(
  checked: true,
  createToJson: true,
  disallowUnrecognizedKeys: false,
  explicitToJson: true,
)
class HasLayoutTrait {
  /// Returns a new [HasLayoutTrait] instance.
  HasLayoutTrait({

    required  this.x,

    required  this.y,

    required  this.width,

    required  this.height,

     this.rotation = 0,
  });

  @JsonKey(
    
    name: r'x',
    required: true,
    includeIfNull: false,
  )


  final num x;



  @JsonKey(
    
    name: r'y',
    required: true,
    includeIfNull: false,
  )


  final num y;



  @JsonKey(
    
    name: r'width',
    required: true,
    includeIfNull: false,
  )


  final num width;



  @JsonKey(
    
    name: r'height',
    required: true,
    includeIfNull: false,
  )


  final num height;



  @JsonKey(
    defaultValue: 0,
    name: r'rotation',
    required: false,
    includeIfNull: false,
  )


  final num? rotation;





    @override
    bool operator ==(Object other) => identical(this, other) || other is HasLayoutTrait &&
      other.x == x &&
      other.y == y &&
      other.width == width &&
      other.height == height &&
      other.rotation == rotation;

    @override
    int get hashCode =>
        x.hashCode +
        y.hashCode +
        width.hashCode +
        height.hashCode +
        rotation.hashCode;

  factory HasLayoutTrait.fromJson(Map<String, dynamic> json) => _$HasLayoutTraitFromJson(json);

  Map<String, dynamic> toJson() => _$HasLayoutTraitToJson(this);

  @override
  String toString() {
    return toJson().toString();
  }

}

