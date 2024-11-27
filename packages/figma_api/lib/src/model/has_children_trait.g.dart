// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'has_children_trait.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

HasChildrenTrait _$HasChildrenTraitFromJson(Map<String, dynamic> json) =>
    $checkedCreate(
      'HasChildrenTrait',
      json,
      ($checkedConvert) {
        $checkKeys(
          json,
          requiredKeys: const ['children'],
        );
        final val = HasChildrenTrait(
          children: $checkedConvert(
              'children',
              (v) => (v as List<dynamic>)
                  .map((e) => Node.fromJson(e as Map<String, dynamic>))
                  .toList()),
        );
        return val;
      },
    );

Map<String, dynamic> _$HasChildrenTraitToJson(HasChildrenTrait instance) =>
    <String, dynamic>{
      'children': instance.children.map((e) => e.toJson()).toList(),
    };
