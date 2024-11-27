//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:figma_api/src/model/color.dart';
import 'package:json_annotation/json_annotation.dart';

part 'layout_grid.g.dart';


@JsonSerializable(
  checked: true,
  createToJson: true,
  disallowUnrecognizedKeys: false,
  explicitToJson: true,
)
class LayoutGrid {
  /// Returns a new [LayoutGrid] instance.
  LayoutGrid({

    required  this.pattern,

    required  this.sectionSize,

     this.visible = true,

     this.color,

     this.alignment,

     this.gutterSize,

     this.offset,

     this.count,
  });

  @JsonKey(
    
    name: r'pattern',
    required: true,
    includeIfNull: false,
  )


  final LayoutGridPatternEnum pattern;



  @JsonKey(
    
    name: r'sectionSize',
    required: true,
    includeIfNull: false,
  )


  final num sectionSize;



  @JsonKey(
    defaultValue: true,
    name: r'visible',
    required: false,
    includeIfNull: false,
  )


  final bool? visible;



  @JsonKey(
    
    name: r'color',
    required: false,
    includeIfNull: false,
  )


  final Color? color;



  @JsonKey(
    
    name: r'alignment',
    required: false,
    includeIfNull: false,
  )


  final LayoutGridAlignmentEnum? alignment;



  @JsonKey(
    
    name: r'gutterSize',
    required: false,
    includeIfNull: false,
  )


  final num? gutterSize;



  @JsonKey(
    
    name: r'offset',
    required: false,
    includeIfNull: false,
  )


  final num? offset;



  @JsonKey(
    
    name: r'count',
    required: false,
    includeIfNull: false,
  )


  final num? count;





    @override
    bool operator ==(Object other) => identical(this, other) || other is LayoutGrid &&
      other.pattern == pattern &&
      other.sectionSize == sectionSize &&
      other.visible == visible &&
      other.color == color &&
      other.alignment == alignment &&
      other.gutterSize == gutterSize &&
      other.offset == offset &&
      other.count == count;

    @override
    int get hashCode =>
        pattern.hashCode +
        sectionSize.hashCode +
        visible.hashCode +
        color.hashCode +
        alignment.hashCode +
        gutterSize.hashCode +
        offset.hashCode +
        count.hashCode;

  factory LayoutGrid.fromJson(Map<String, dynamic> json) => _$LayoutGridFromJson(json);

  Map<String, dynamic> toJson() => _$LayoutGridToJson(this);

  @override
  String toString() {
    return toJson().toString();
  }

}


enum LayoutGridPatternEnum {
@JsonValue(r'COLUMNS')
COLUMNS(r'COLUMNS'),
@JsonValue(r'ROWS')
ROWS(r'ROWS'),
@JsonValue(r'GRID')
GRID(r'GRID');

const LayoutGridPatternEnum(this.value);

final String value;

@override
String toString() => value;
}



enum LayoutGridAlignmentEnum {
@JsonValue(r'MIN')
MIN(r'MIN'),
@JsonValue(r'MAX')
MAX(r'MAX'),
@JsonValue(r'CENTER')
CENTER(r'CENTER'),
@JsonValue(r'STRETCH')
STRETCH(r'STRETCH');

const LayoutGridAlignmentEnum(this.value);

final String value;

@override
String toString() => value;
}


