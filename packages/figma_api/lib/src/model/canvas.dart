//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:figma_api/src/model/color.dart';
import 'package:figma_api/src/model/node.dart';
import 'package:json_annotation/json_annotation.dart';

part 'canvas.g.dart';


@JsonSerializable(
  checked: true,
  createToJson: true,
  disallowUnrecognizedKeys: false,
  explicitToJson: true,
)
class Canvas {
  /// Returns a new [Canvas] instance.
  Canvas({

     this.id,

     this.name,

     this.type,

     this.children,

     this.backgroundColor,

     this.prototypeStartNodeID,
  });

  @JsonKey(
    
    name: r'id',
    required: false,
    includeIfNull: false,
  )


  final String? id;



  @JsonKey(
    
    name: r'name',
    required: false,
    includeIfNull: false,
  )


  final String? name;



  @JsonKey(
    
    name: r'type',
    required: false,
    includeIfNull: false,
  )


  final CanvasTypeEnum? type;



  @JsonKey(
    
    name: r'children',
    required: false,
    includeIfNull: false,
  )


  final List<Node>? children;



  @JsonKey(
    
    name: r'backgroundColor',
    required: false,
    includeIfNull: false,
  )


  final Color? backgroundColor;



  @JsonKey(
    
    name: r'prototypeStartNodeID',
    required: false,
    includeIfNull: false,
  )


  final String? prototypeStartNodeID;





    @override
    bool operator ==(Object other) => identical(this, other) || other is Canvas &&
      other.id == id &&
      other.name == name &&
      other.type == type &&
      other.children == children &&
      other.backgroundColor == backgroundColor &&
      other.prototypeStartNodeID == prototypeStartNodeID;

    @override
    int get hashCode =>
        id.hashCode +
        name.hashCode +
        type.hashCode +
        children.hashCode +
        backgroundColor.hashCode +
        prototypeStartNodeID.hashCode;

  factory Canvas.fromJson(Map<String, dynamic> json) => _$CanvasFromJson(json);

  Map<String, dynamic> toJson() => _$CanvasToJson(this);

  @override
  String toString() {
    return toJson().toString();
  }

}


enum CanvasTypeEnum {
@JsonValue(r'CANVAS')
CANVAS(r'CANVAS');

const CanvasTypeEnum(this.value);

final String value;

@override
String toString() => value;
}


