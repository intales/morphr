//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:figma_api/src/model/paint.dart';
import 'package:json_annotation/json_annotation.dart';

part 'type_style.g.dart';


@JsonSerializable(
  checked: true,
  createToJson: true,
  disallowUnrecognizedKeys: false,
  explicitToJson: true,
)
class TypeStyle {
  /// Returns a new [TypeStyle] instance.
  TypeStyle({

     this.fontFamily,

     this.fontSize,

     this.fontWeight,

     this.textAlignHorizontal,

     this.textCase,

     this.textAlignVertical,

     this.letterSpacing,

     this.lineHeightPx,

     this.italic,

     this.fills,
  });

  @JsonKey(
    
    name: r'fontFamily',
    required: false,
    includeIfNull: false,
  )


  final String? fontFamily;



  @JsonKey(
    
    name: r'fontSize',
    required: false,
    includeIfNull: false,
  )


  final num? fontSize;



  @JsonKey(
    
    name: r'fontWeight',
    required: false,
    includeIfNull: false,
  )


  final num? fontWeight;



  @JsonKey(
    
    name: r'textAlignHorizontal',
    required: false,
    includeIfNull: false,
  )


  final TypeStyleTextAlignHorizontalEnum? textAlignHorizontal;



  @JsonKey(
    
    name: r'textCase',
    required: false,
    includeIfNull: false,
  )


  final TypeStyleTextCaseEnum? textCase;



  @JsonKey(
    
    name: r'textAlignVertical',
    required: false,
    includeIfNull: false,
  )


  final TypeStyleTextAlignVerticalEnum? textAlignVertical;



  @JsonKey(
    
    name: r'letterSpacing',
    required: false,
    includeIfNull: false,
  )


  final num? letterSpacing;



  @JsonKey(
    
    name: r'lineHeightPx',
    required: false,
    includeIfNull: false,
  )


  final num? lineHeightPx;



  @JsonKey(
    
    name: r'italic',
    required: false,
    includeIfNull: false,
  )


  final bool? italic;



  @JsonKey(
    
    name: r'fills',
    required: false,
    includeIfNull: false,
  )


  final List<Paint>? fills;





    @override
    bool operator ==(Object other) => identical(this, other) || other is TypeStyle &&
      other.fontFamily == fontFamily &&
      other.fontSize == fontSize &&
      other.fontWeight == fontWeight &&
      other.textAlignHorizontal == textAlignHorizontal &&
      other.textCase == textCase &&
      other.textAlignVertical == textAlignVertical &&
      other.letterSpacing == letterSpacing &&
      other.lineHeightPx == lineHeightPx &&
      other.italic == italic &&
      other.fills == fills;

    @override
    int get hashCode =>
        fontFamily.hashCode +
        fontSize.hashCode +
        fontWeight.hashCode +
        textAlignHorizontal.hashCode +
        textCase.hashCode +
        textAlignVertical.hashCode +
        letterSpacing.hashCode +
        lineHeightPx.hashCode +
        italic.hashCode +
        fills.hashCode;

  factory TypeStyle.fromJson(Map<String, dynamic> json) => _$TypeStyleFromJson(json);

  Map<String, dynamic> toJson() => _$TypeStyleToJson(this);

  @override
  String toString() {
    return toJson().toString();
  }

}


enum TypeStyleTextAlignHorizontalEnum {
@JsonValue(r'LEFT')
LEFT(r'LEFT'),
@JsonValue(r'RIGHT')
RIGHT(r'RIGHT'),
@JsonValue(r'CENTER')
CENTER(r'CENTER'),
@JsonValue(r'JUSTIFIED')
JUSTIFIED(r'JUSTIFIED');

const TypeStyleTextAlignHorizontalEnum(this.value);

final String value;

@override
String toString() => value;
}



enum TypeStyleTextCaseEnum {
@JsonValue(r'UPPER')
UPPER(r'UPPER'),
@JsonValue(r'LOWER')
LOWER(r'LOWER'),
@JsonValue(r'TITLE')
TITLE(r'TITLE'),
@JsonValue(r'SMALL_CAPS')
SMALL_CAPS(r'SMALL_CAPS');

const TypeStyleTextCaseEnum(this.value);

final String value;

@override
String toString() => value;
}



enum TypeStyleTextAlignVerticalEnum {
@JsonValue(r'TOP')
TOP(r'TOP'),
@JsonValue(r'CENTER')
CENTER(r'CENTER'),
@JsonValue(r'BOTTOM')
BOTTOM(r'BOTTOM');

const TypeStyleTextAlignVerticalEnum(this.value);

final String value;

@override
String toString() => value;
}


