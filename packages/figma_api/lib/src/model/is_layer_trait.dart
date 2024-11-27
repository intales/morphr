//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:json_annotation/json_annotation.dart';

part 'is_layer_trait.g.dart';


@JsonSerializable(
  checked: true,
  createToJson: true,
  disallowUnrecognizedKeys: false,
  explicitToJson: true,
)
class IsLayerTrait {
  /// Returns a new [IsLayerTrait] instance.
  IsLayerTrait({

    required  this.id,

    required  this.name,

     this.visible = true,

     this.locked = false,
  });

  @JsonKey(
    
    name: r'id',
    required: true,
    includeIfNull: false,
  )


  final String id;



  @JsonKey(
    
    name: r'name',
    required: true,
    includeIfNull: false,
  )


  final String name;



  @JsonKey(
    defaultValue: true,
    name: r'visible',
    required: false,
    includeIfNull: false,
  )


  final bool? visible;



  @JsonKey(
    defaultValue: false,
    name: r'locked',
    required: false,
    includeIfNull: false,
  )


  final bool? locked;





    @override
    bool operator ==(Object other) => identical(this, other) || other is IsLayerTrait &&
      other.id == id &&
      other.name == name &&
      other.visible == visible &&
      other.locked == locked;

    @override
    int get hashCode =>
        id.hashCode +
        name.hashCode +
        visible.hashCode +
        locked.hashCode;

  factory IsLayerTrait.fromJson(Map<String, dynamic> json) => _$IsLayerTraitFromJson(json);

  Map<String, dynamic> toJson() => _$IsLayerTraitToJson(this);

  @override
  String toString() {
    return toJson().toString();
  }

}

