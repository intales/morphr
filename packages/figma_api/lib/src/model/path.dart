//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:json_annotation/json_annotation.dart';

part 'path.g.dart';


@JsonSerializable(
  checked: true,
  createToJson: true,
  disallowUnrecognizedKeys: false,
  explicitToJson: true,
)
class Path {
  /// Returns a new [Path] instance.
  Path({

     this.path,

     this.windingRule,
  });

  @JsonKey(
    
    name: r'path',
    required: false,
    includeIfNull: false,
  )


  final String? path;



  @JsonKey(
    
    name: r'windingRule',
    required: false,
    includeIfNull: false,
  )


  final PathWindingRuleEnum? windingRule;





    @override
    bool operator ==(Object other) => identical(this, other) || other is Path &&
      other.path == path &&
      other.windingRule == windingRule;

    @override
    int get hashCode =>
        path.hashCode +
        windingRule.hashCode;

  factory Path.fromJson(Map<String, dynamic> json) => _$PathFromJson(json);

  Map<String, dynamic> toJson() => _$PathToJson(this);

  @override
  String toString() {
    return toJson().toString();
  }

}


enum PathWindingRuleEnum {
@JsonValue(r'NONZERO')
NONZERO(r'NONZERO'),
@JsonValue(r'EVENODD')
EVENODD(r'EVENODD');

const PathWindingRuleEnum(this.value);

final String value;

@override
String toString() => value;
}


