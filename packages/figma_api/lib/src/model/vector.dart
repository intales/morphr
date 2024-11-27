//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:json_annotation/json_annotation.dart';

part 'vector.g.dart';


@JsonSerializable(
  checked: true,
  createToJson: true,
  disallowUnrecognizedKeys: false,
  explicitToJson: true,
)
class Vector {
  /// Returns a new [Vector] instance.
  Vector({

    required  this.x,

    required  this.y,
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





    @override
    bool operator ==(Object other) => identical(this, other) || other is Vector &&
      other.x == x &&
      other.y == y;

    @override
    int get hashCode =>
        x.hashCode +
        y.hashCode;

  factory Vector.fromJson(Map<String, dynamic> json) => _$VectorFromJson(json);

  Map<String, dynamic> toJson() => _$VectorToJson(this);

  @override
  String toString() {
    return toJson().toString();
  }

}

