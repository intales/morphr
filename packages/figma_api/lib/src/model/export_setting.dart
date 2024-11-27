//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:figma_api/src/model/constraint.dart';
import 'package:json_annotation/json_annotation.dart';

part 'export_setting.g.dart';


@JsonSerializable(
  checked: true,
  createToJson: true,
  disallowUnrecognizedKeys: false,
  explicitToJson: true,
)
class ExportSetting {
  /// Returns a new [ExportSetting] instance.
  ExportSetting({

    required  this.suffix,

    required  this.format,

    required  this.constraint,
  });

  @JsonKey(
    
    name: r'suffix',
    required: true,
    includeIfNull: false,
  )


  final String suffix;



  @JsonKey(
    
    name: r'format',
    required: true,
    includeIfNull: false,
  )


  final ExportSettingFormatEnum format;



  @JsonKey(
    
    name: r'constraint',
    required: true,
    includeIfNull: false,
  )


  final Constraint constraint;





    @override
    bool operator ==(Object other) => identical(this, other) || other is ExportSetting &&
      other.suffix == suffix &&
      other.format == format &&
      other.constraint == constraint;

    @override
    int get hashCode =>
        suffix.hashCode +
        format.hashCode +
        constraint.hashCode;

  factory ExportSetting.fromJson(Map<String, dynamic> json) => _$ExportSettingFromJson(json);

  Map<String, dynamic> toJson() => _$ExportSettingToJson(this);

  @override
  String toString() {
    return toJson().toString();
  }

}


enum ExportSettingFormatEnum {
@JsonValue(r'JPG')
JPG(r'JPG'),
@JsonValue(r'PNG')
PNG(r'PNG'),
@JsonValue(r'SVG')
SVG(r'SVG'),
@JsonValue(r'PDF')
PDF(r'PDF');

const ExportSettingFormatEnum(this.value);

final String value;

@override
String toString() => value;
}


