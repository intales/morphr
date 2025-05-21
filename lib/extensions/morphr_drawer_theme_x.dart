import 'package:flutter/material.dart';
import 'package:morphr/adapters/figma_decoration_adapter.dart';
import 'package:morphr/morphr_service.dart';
import 'package:morphr_figma/morphr_figma.dart' as figma;

extension MorphrDrawerThemeDataX on DrawerThemeData {
  DrawerThemeData morph(String componentName) {
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

      double? width;
      if (node is figma.Frame) {
        width = node.absoluteBoundingBox?.width?.toDouble();
      } else if (node is figma.Instance) {
        width = node.absoluteBoundingBox?.width?.toDouble();
      } else if (node is figma.Rectangle) {
        width = node.absoluteBoundingBox?.width?.toDouble();
      }

      final List<BoxShadow>? shadows = decoration.boxShadow;
      double? elevation;
      Color? shadowColor;
      if (shadows != null && shadows.isNotEmpty) {
        elevation = shadows.first.blurRadius;
        shadowColor = shadows.first.color;
      }

      final BorderRadius? borderRadius =
          decoration.borderRadius as BorderRadius?;
      ShapeBorder? shape;
      if (borderRadius != null) {
        shape = RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            topRight: borderRadius.topRight,
            bottomRight: borderRadius.bottomRight,
          ),
        );
      }

      Color? scrimColor;
      if (backgroundColor != null) {
        final isDark =
            ThemeData.estimateBrightnessForColor(backgroundColor) ==
            Brightness.dark;
        scrimColor =
            isDark
                ? Colors.white.withValues(alpha: 0.1)
                : Colors.black.withValues(alpha: 0.2);
      }

      return copyWith(
        backgroundColor: this.backgroundColor ?? backgroundColor,
        scrimColor: this.scrimColor ?? scrimColor,
        elevation: this.elevation ?? elevation,
        shadowColor: this.shadowColor ?? shadowColor,
        shape: this.shape ?? shape,
        width: this.width ?? width,
      );
    } catch (_) {
      return this;
    }
  }
}
