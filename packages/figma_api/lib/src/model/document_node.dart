//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:figma_api/src/model/canvas_node.dart';
import 'package:json_annotation/json_annotation.dart';

part 'document_node.g.dart';


@JsonSerializable(
  checked: true,
  createToJson: true,
  disallowUnrecognizedKeys: false,
  explicitToJson: true,
)
class DocumentNode {
  /// Returns a new [DocumentNode] instance.
  DocumentNode({

    required  this.id,

    required  this.name,

     this.visible = true,

     this.locked = false,

    required  this.type,

    required  this.children,
  });

  @JsonKey(
    
    name: r'id',
    required: true,
    includeIfNull: false,
  )


  final String id;



  @JsonKey(
    
    name: r'name',
    required: true,
    includeIfNull: false,
  )


  final String name;



  @JsonKey(
    defaultValue: true,
    name: r'visible',
    required: false,
    includeIfNull: false,
  )


  final bool? visible;



  @JsonKey(
    defaultValue: false,
    name: r'locked',
    required: false,
    includeIfNull: false,
  )


  final bool? locked;



  @JsonKey(
    
    name: r'type',
    required: true,
    includeIfNull: false,
  )


  final DocumentNodeTypeEnum type;



  @JsonKey(
    
    name: r'children',
    required: true,
    includeIfNull: false,
  )


  final List<CanvasNode> children;





    @override
    bool operator ==(Object other) => identical(this, other) || other is DocumentNode &&
      other.id == id &&
      other.name == name &&
      other.visible == visible &&
      other.locked == locked &&
      other.type == type &&
      other.children == children;

    @override
    int get hashCode =>
        id.hashCode +
        name.hashCode +
        visible.hashCode +
        locked.hashCode +
        type.hashCode +
        children.hashCode;

  factory DocumentNode.fromJson(Map<String, dynamic> json) => _$DocumentNodeFromJson(json);

  Map<String, dynamic> toJson() => _$DocumentNodeToJson(this);

  @override
  String toString() {
    return toJson().toString();
  }

}


enum DocumentNodeTypeEnum {
@JsonValue(r'DOCUMENT')
DOCUMENT(r'DOCUMENT');

const DocumentNodeTypeEnum(this.value);

final String value;

@override
String toString() => value;
}


