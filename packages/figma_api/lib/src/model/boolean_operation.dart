//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:figma_api/src/model/node.dart';
import 'package:json_annotation/json_annotation.dart';

part 'boolean_operation.g.dart';


@JsonSerializable(
  checked: true,
  createToJson: true,
  disallowUnrecognizedKeys: false,
  explicitToJson: true,
)
class BooleanOperation {
  /// Returns a new [BooleanOperation] instance.
  BooleanOperation({

     this.operation,

     this.children,
  });

  @JsonKey(
    
    name: r'operation',
    required: false,
    includeIfNull: false,
  )


  final BooleanOperationOperationEnum? operation;



  @JsonKey(
    
    name: r'children',
    required: false,
    includeIfNull: false,
  )


  final List<Node>? children;





    @override
    bool operator ==(Object other) => identical(this, other) || other is BooleanOperation &&
      other.operation == operation &&
      other.children == children;

    @override
    int get hashCode =>
        operation.hashCode +
        children.hashCode;

  factory BooleanOperation.fromJson(Map<String, dynamic> json) => _$BooleanOperationFromJson(json);

  Map<String, dynamic> toJson() => _$BooleanOperationToJson(this);

  @override
  String toString() {
    return toJson().toString();
  }

}


enum BooleanOperationOperationEnum {
@JsonValue(r'UNION')
UNION(r'UNION'),
@JsonValue(r'INTERSECT')
INTERSECT(r'INTERSECT'),
@JsonValue(r'SUBTRACT')
SUBTRACT(r'SUBTRACT'),
@JsonValue(r'EXCLUDE')
EXCLUDE(r'EXCLUDE');

const BooleanOperationOperationEnum(this.value);

final String value;

@override
String toString() => value;
}


