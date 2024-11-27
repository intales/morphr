//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:json_annotation/json_annotation.dart';

part 'rectangle.g.dart';


@JsonSerializable(
  checked: true,
  createToJson: true,
  disallowUnrecognizedKeys: false,
  explicitToJson: true,
)
class Rectangle {
  /// Returns a new [Rectangle] instance.
  Rectangle({

    required  this.x,

    required  this.y,

    required  this.width,

    required  this.height,
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





    @override
    bool operator ==(Object other) => identical(this, other) || other is Rectangle &&
      other.x == x &&
      other.y == y &&
      other.width == width &&
      other.height == height;

    @override
    int get hashCode =>
        x.hashCode +
        y.hashCode +
        width.hashCode +
        height.hashCode;

  factory Rectangle.fromJson(Map<String, dynamic> json) => _$RectangleFromJson(json);

  Map<String, dynamic> toJson() => _$RectangleToJson(this);

  @override
  String toString() {
    return toJson().toString();
  }

}

