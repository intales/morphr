//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:json_annotation/json_annotation.dart';


enum BlendMode {
      @JsonValue(r'PASS_THROUGH')
      PASS_THROUGH(r'PASS_THROUGH'),
      @JsonValue(r'NORMAL')
      NORMAL(r'NORMAL'),
      @JsonValue(r'DARKEN')
      DARKEN(r'DARKEN'),
      @JsonValue(r'MULTIPLY')
      MULTIPLY(r'MULTIPLY'),
      @JsonValue(r'LINEAR_BURN')
      LINEAR_BURN(r'LINEAR_BURN'),
      @JsonValue(r'COLOR_BURN')
      COLOR_BURN(r'COLOR_BURN'),
      @JsonValue(r'LIGHTEN')
      LIGHTEN(r'LIGHTEN'),
      @JsonValue(r'SCREEN')
      SCREEN(r'SCREEN'),
      @JsonValue(r'LINEAR_DODGE')
      LINEAR_DODGE(r'LINEAR_DODGE'),
      @JsonValue(r'COLOR_DODGE')
      COLOR_DODGE(r'COLOR_DODGE'),
      @JsonValue(r'OVERLAY')
      OVERLAY(r'OVERLAY'),
      @JsonValue(r'SOFT_LIGHT')
      SOFT_LIGHT(r'SOFT_LIGHT'),
      @JsonValue(r'HARD_LIGHT')
      HARD_LIGHT(r'HARD_LIGHT'),
      @JsonValue(r'DIFFERENCE')
      DIFFERENCE(r'DIFFERENCE'),
      @JsonValue(r'EXCLUSION')
      EXCLUSION(r'EXCLUSION'),
      @JsonValue(r'HUE')
      HUE(r'HUE'),
      @JsonValue(r'SATURATION')
      SATURATION(r'SATURATION'),
      @JsonValue(r'COLOR')
      COLOR(r'COLOR'),
      @JsonValue(r'LUMINOSITY')
      LUMINOSITY(r'LUMINOSITY');

  const BlendMode(this.value);

  final String value;

  @override
  String toString() => value;
}
