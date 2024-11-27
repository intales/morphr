//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:json_annotation/json_annotation.dart';

part 'component_property.g.dart';


@JsonSerializable(
  checked: true,
  createToJson: true,
  disallowUnrecognizedKeys: false,
  explicitToJson: true,
)
class ComponentProperty {
  /// Returns a new [ComponentProperty] instance.
  ComponentProperty({

     this.type,

     this.value,
  });

  @JsonKey(
    
    name: r'type',
    required: false,
    includeIfNull: false,
  )


  final ComponentPropertyTypeEnum? type;



  @JsonKey(
    
    name: r'value',
    required: false,
    includeIfNull: false,
  )


  final String? value;





    @override
    bool operator ==(Object other) => identical(this, other) || other is ComponentProperty &&
      other.type == type &&
      other.value == value;

    @override
    int get hashCode =>
        type.hashCode +
        value.hashCode;

  factory ComponentProperty.fromJson(Map<String, dynamic> json) => _$ComponentPropertyFromJson(json);

  Map<String, dynamic> toJson() => _$ComponentPropertyToJson(this);

  @override
  String toString() {
    return toJson().toString();
  }

}


enum ComponentPropertyTypeEnum {
@JsonValue(r'BOOLEAN')
BOOLEAN(r'BOOLEAN'),
@JsonValue(r'INSTANCE_SWAP')
INSTANCE_SWAP(r'INSTANCE_SWAP'),
@JsonValue(r'TEXT')
TEXT(r'TEXT'),
@JsonValue(r'VARIANT')
VARIANT(r'VARIANT');

const ComponentPropertyTypeEnum(this.value);

final String value;

@override
String toString() => value;
}


