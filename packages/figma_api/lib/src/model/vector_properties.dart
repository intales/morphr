//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:figma_api/src/model/path.dart';
import 'package:json_annotation/json_annotation.dart';

part 'vector_properties.g.dart';


@JsonSerializable(
  checked: true,
  createToJson: true,
  disallowUnrecognizedKeys: false,
  explicitToJson: true,
)
class VectorProperties {
  /// Returns a new [VectorProperties] instance.
  VectorProperties({

     this.fillGeometry,

     this.strokeGeometry,

     this.strokeCap,

     this.strokeJoin,
  });

  @JsonKey(
    
    name: r'fillGeometry',
    required: false,
    includeIfNull: false,
  )


  final List<Path>? fillGeometry;



  @JsonKey(
    
    name: r'strokeGeometry',
    required: false,
    includeIfNull: false,
  )


  final List<Path>? strokeGeometry;



  @JsonKey(
    
    name: r'strokeCap',
    required: false,
    includeIfNull: false,
  )


  final VectorPropertiesStrokeCapEnum? strokeCap;



  @JsonKey(
    
    name: r'strokeJoin',
    required: false,
    includeIfNull: false,
  )


  final VectorPropertiesStrokeJoinEnum? strokeJoin;





    @override
    bool operator ==(Object other) => identical(this, other) || other is VectorProperties &&
      other.fillGeometry == fillGeometry &&
      other.strokeGeometry == strokeGeometry &&
      other.strokeCap == strokeCap &&
      other.strokeJoin == strokeJoin;

    @override
    int get hashCode =>
        fillGeometry.hashCode +
        strokeGeometry.hashCode +
        strokeCap.hashCode +
        strokeJoin.hashCode;

  factory VectorProperties.fromJson(Map<String, dynamic> json) => _$VectorPropertiesFromJson(json);

  Map<String, dynamic> toJson() => _$VectorPropertiesToJson(this);

  @override
  String toString() {
    return toJson().toString();
  }

}


enum VectorPropertiesStrokeCapEnum {
@JsonValue(r'NONE')
NONE(r'NONE'),
@JsonValue(r'ROUND')
ROUND(r'ROUND'),
@JsonValue(r'SQUARE')
SQUARE(r'SQUARE'),
@JsonValue(r'LINE_ARROW')
LINE_ARROW(r'LINE_ARROW'),
@JsonValue(r'TRIANGLE_ARROW')
TRIANGLE_ARROW(r'TRIANGLE_ARROW');

const VectorPropertiesStrokeCapEnum(this.value);

final String value;

@override
String toString() => value;
}



enum VectorPropertiesStrokeJoinEnum {
@JsonValue(r'MITER')
MITER(r'MITER'),
@JsonValue(r'BEVEL')
BEVEL(r'BEVEL'),
@JsonValue(r'ROUND')
ROUND(r'ROUND');

const VectorPropertiesStrokeJoinEnum(this.value);

final String value;

@override
String toString() => value;
}


