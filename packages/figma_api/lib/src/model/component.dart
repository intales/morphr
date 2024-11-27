//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:json_annotation/json_annotation.dart';

part 'component.g.dart';


@JsonSerializable(
  checked: true,
  createToJson: true,
  disallowUnrecognizedKeys: false,
  explicitToJson: true,
)
class Component {
  /// Returns a new [Component] instance.
  Component({

    required  this.key,

    required  this.name,

    required  this.description,

    required  this.remote,
  });

  @JsonKey(
    
    name: r'key',
    required: true,
    includeIfNull: false,
  )


  final String key;



  @JsonKey(
    
    name: r'name',
    required: true,
    includeIfNull: false,
  )


  final String name;



  @JsonKey(
    
    name: r'description',
    required: true,
    includeIfNull: false,
  )


  final String description;



  @JsonKey(
    
    name: r'remote',
    required: true,
    includeIfNull: false,
  )


  final bool remote;





    @override
    bool operator ==(Object other) => identical(this, other) || other is Component &&
      other.key == key &&
      other.name == name &&
      other.description == description &&
      other.remote == remote;

    @override
    int get hashCode =>
        key.hashCode +
        name.hashCode +
        description.hashCode +
        remote.hashCode;

  factory Component.fromJson(Map<String, dynamic> json) => _$ComponentFromJson(json);

  Map<String, dynamic> toJson() => _$ComponentToJson(this);

  @override
  String toString() {
    return toJson().toString();
  }

}

