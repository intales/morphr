//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:json_annotation/json_annotation.dart';

part 'color.g.dart';


@JsonSerializable(
  checked: true,
  createToJson: true,
  disallowUnrecognizedKeys: false,
  explicitToJson: true,
)
class Color {
  /// Returns a new [Color] instance.
  Color({

    required  this.r,

    required  this.g,

    required  this.b,

    required  this.a,
  });

          // minimum: 0
          // maximum: 1
  @JsonKey(
    
    name: r'r',
    required: true,
    includeIfNull: false,
  )


  final num r;



          // minimum: 0
          // maximum: 1
  @JsonKey(
    
    name: r'g',
    required: true,
    includeIfNull: false,
  )


  final num g;



          // minimum: 0
          // maximum: 1
  @JsonKey(
    
    name: r'b',
    required: true,
    includeIfNull: false,
  )


  final num b;



          // minimum: 0
          // maximum: 1
  @JsonKey(
    
    name: r'a',
    required: true,
    includeIfNull: false,
  )


  final num a;





    @override
    bool operator ==(Object other) => identical(this, other) || other is Color &&
      other.r == r &&
      other.g == g &&
      other.b == b &&
      other.a == a;

    @override
    int get hashCode =>
        r.hashCode +
        g.hashCode +
        b.hashCode +
        a.hashCode;

  factory Color.fromJson(Map<String, dynamic> json) => _$ColorFromJson(json);

  Map<String, dynamic> toJson() => _$ColorToJson(this);

  @override
  String toString() {
    return toJson().toString();
  }

}

