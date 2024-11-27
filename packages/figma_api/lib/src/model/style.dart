//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:json_annotation/json_annotation.dart';

part 'style.g.dart';


@JsonSerializable(
  checked: true,
  createToJson: true,
  disallowUnrecognizedKeys: false,
  explicitToJson: true,
)
class Style {
  /// Returns a new [Style] instance.
  Style({

     this.key,

     this.name,

     this.styleType,
  });

  @JsonKey(
    
    name: r'key',
    required: false,
    includeIfNull: false,
  )


  final String? key;



  @JsonKey(
    
    name: r'name',
    required: false,
    includeIfNull: false,
  )


  final String? name;



  @JsonKey(
    
    name: r'styleType',
    required: false,
    includeIfNull: false,
  )


  final StyleStyleTypeEnum? styleType;





    @override
    bool operator ==(Object other) => identical(this, other) || other is Style &&
      other.key == key &&
      other.name == name &&
      other.styleType == styleType;

    @override
    int get hashCode =>
        key.hashCode +
        name.hashCode +
        styleType.hashCode;

  factory Style.fromJson(Map<String, dynamic> json) => _$StyleFromJson(json);

  Map<String, dynamic> toJson() => _$StyleToJson(this);

  @override
  String toString() {
    return toJson().toString();
  }

}


enum StyleStyleTypeEnum {
@JsonValue(r'FILL')
FILL(r'FILL'),
@JsonValue(r'TEXT')
TEXT(r'TEXT'),
@JsonValue(r'EFFECT')
EFFECT(r'EFFECT'),
@JsonValue(r'GRID')
GRID(r'GRID');

const StyleStyleTypeEnum(this.value);

final String value;

@override
String toString() => value;
}


