//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:figma_api/src/model/color.dart';
import 'package:json_annotation/json_annotation.dart';

part 'color_stop.g.dart';


@JsonSerializable(
  checked: true,
  createToJson: true,
  disallowUnrecognizedKeys: false,
  explicitToJson: true,
)
class ColorStop {
  /// Returns a new [ColorStop] instance.
  ColorStop({

    required  this.position,

    required  this.color,
  });

  @JsonKey(
    
    name: r'position',
    required: true,
    includeIfNull: false,
  )


  final num position;



  @JsonKey(
    
    name: r'color',
    required: true,
    includeIfNull: false,
  )


  final Color color;





    @override
    bool operator ==(Object other) => identical(this, other) || other is ColorStop &&
      other.position == position &&
      other.color == color;

    @override
    int get hashCode =>
        position.hashCode +
        color.hashCode;

  factory ColorStop.fromJson(Map<String, dynamic> json) => _$ColorStopFromJson(json);

  Map<String, dynamic> toJson() => _$ColorStopToJson(this);

  @override
  String toString() {
    return toJson().toString();
  }

}

