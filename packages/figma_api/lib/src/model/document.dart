//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:figma_api/src/model/canvas.dart';
import 'package:json_annotation/json_annotation.dart';

part 'document.g.dart';


@JsonSerializable(
  checked: true,
  createToJson: true,
  disallowUnrecognizedKeys: false,
  explicitToJson: true,
)
class Document {
  /// Returns a new [Document] instance.
  Document({

     this.id,

     this.name,

     this.type,

     this.children,
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


  final DocumentTypeEnum? type;



  @JsonKey(
    
    name: r'children',
    required: false,
    includeIfNull: false,
  )


  final List<Canvas>? children;





    @override
    bool operator ==(Object other) => identical(this, other) || other is Document &&
      other.id == id &&
      other.name == name &&
      other.type == type &&
      other.children == children;

    @override
    int get hashCode =>
        id.hashCode +
        name.hashCode +
        type.hashCode +
        children.hashCode;

  factory Document.fromJson(Map<String, dynamic> json) => _$DocumentFromJson(json);

  Map<String, dynamic> toJson() => _$DocumentToJson(this);

  @override
  String toString() {
    return toJson().toString();
  }

}


enum DocumentTypeEnum {
@JsonValue(r'DOCUMENT')
DOCUMENT(r'DOCUMENT');

const DocumentTypeEnum(this.value);

final String value;

@override
String toString() => value;
}


