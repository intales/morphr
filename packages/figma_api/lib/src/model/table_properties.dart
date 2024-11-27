//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:json_annotation/json_annotation.dart';

part 'table_properties.g.dart';


@JsonSerializable(
  checked: true,
  createToJson: true,
  disallowUnrecognizedKeys: false,
  explicitToJson: true,
)
class TableProperties {
  /// Returns a new [TableProperties] instance.
  TableProperties({

     this.numRows,

     this.numColumns,

     this.cellSpacing,
  });

  @JsonKey(
    
    name: r'numRows',
    required: false,
    includeIfNull: false,
  )


  final num? numRows;



  @JsonKey(
    
    name: r'numColumns',
    required: false,
    includeIfNull: false,
  )


  final num? numColumns;



  @JsonKey(
    
    name: r'cellSpacing',
    required: false,
    includeIfNull: false,
  )


  final num? cellSpacing;





    @override
    bool operator ==(Object other) => identical(this, other) || other is TableProperties &&
      other.numRows == numRows &&
      other.numColumns == numColumns &&
      other.cellSpacing == cellSpacing;

    @override
    int get hashCode =>
        numRows.hashCode +
        numColumns.hashCode +
        cellSpacing.hashCode;

  factory TableProperties.fromJson(Map<String, dynamic> json) => _$TablePropertiesFromJson(json);

  Map<String, dynamic> toJson() => _$TablePropertiesToJson(this);

  @override
  String toString() {
    return toJson().toString();
  }

}

