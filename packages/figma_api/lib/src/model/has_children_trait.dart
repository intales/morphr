//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:figma_api/src/model/node.dart';
import 'package:json_annotation/json_annotation.dart';

part 'has_children_trait.g.dart';


@JsonSerializable(
  checked: true,
  createToJson: true,
  disallowUnrecognizedKeys: false,
  explicitToJson: true,
)
class HasChildrenTrait {
  /// Returns a new [HasChildrenTrait] instance.
  HasChildrenTrait({

    required  this.children,
  });

  @JsonKey(
    
    name: r'children',
    required: true,
    includeIfNull: false,
  )


  final List<Node> children;





    @override
    bool operator ==(Object other) => identical(this, other) || other is HasChildrenTrait &&
      other.children == children;

    @override
    int get hashCode =>
        children.hashCode;

  factory HasChildrenTrait.fromJson(Map<String, dynamic> json) => _$HasChildrenTraitFromJson(json);

  Map<String, dynamic> toJson() => _$HasChildrenTraitToJson(this);

  @override
  String toString() {
    return toJson().toString();
  }

}

