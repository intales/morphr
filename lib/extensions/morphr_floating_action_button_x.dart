import 'package:flutter/material.dart';
import 'package:morphr/adapters/figma_decoration_adapter.dart';
import 'package:morphr/morphr_service.dart';

extension MorphrFloatingActionButtonThemeDataX
    on FloatingActionButtonThemeData {
  FloatingActionButtonThemeData morph(String componentName) {
    if (componentName.isEmpty) {
      return this;
    }

    final node = MorphrService.instance.getComponent(componentName);
    if (node == null) return this;

    final decorationAdapter = FigmaDecorationAdapter(node);

    if (!decorationAdapter.supportsDecoration) {
      return this;
    }

    try {
      final decoration = decorationAdapter.createBoxDecoration();

      final Color? backgroundColor = decoration.color;

      Color? foregroundColor;
      if (backgroundColor != null) {
        final brightness = ThemeData.estimateBrightnessForColor(
          backgroundColor,
        );
        foregroundColor =
            brightness == Brightness.dark ? Colors.white : Colors.black;
      }

      final List<BoxShadow>? shadows = decoration.boxShadow;
      double? elevation;
      if (shadows != null && shadows.isNotEmpty) {
        elevation = shadows.first.blurRadius / 2;
      }

      ShapeBorder? shape;
      if (decoration.shape == BoxShape.circle) {
        shape = const CircleBorder();
      } else {
        final BorderRadius? borderRadius =
            decoration.borderRadius as BorderRadius?;
        if (borderRadius != null) {
          shape = RoundedRectangleBorder(borderRadius: borderRadius);
        }
      }

      return copyWith(
        foregroundColor: this.foregroundColor ?? foregroundColor,
        backgroundColor: this.backgroundColor ?? backgroundColor,
        elevation: this.elevation ?? elevation,
        shape: this.shape ?? shape,
      );
    } catch (_) {
      return this;
    }
  }
}
