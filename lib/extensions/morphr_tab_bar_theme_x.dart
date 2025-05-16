import 'package:flutter/material.dart';
import 'package:morphr/adapters/figma_decoration_adapter.dart';
import 'package:morphr/morphr_service.dart';
import 'package:morphr_figma/morphr_figma.dart' as figma;

extension MorphrTabBarThemeX on TabBarTheme {
  TabBarTheme morph(String componentName) {
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

      Color? labelColor;
      Color? unselectedLabelColor;
      if (backgroundColor != null) {
        final brightness = ThemeData.estimateBrightnessForColor(
          backgroundColor,
        );
        labelColor =
            brightness == Brightness.dark ? Colors.white : Colors.black;
        unselectedLabelColor =
            brightness == Brightness.dark
                ? Colors.white.withValues(alpha: 0.7)
                : Colors.black.withValues(alpha: 0.7);
      }

      Color? indicatorColor;
      if (decoration.border != null) {
        indicatorColor = decoration.border?.bottom.color;
      } else {
        indicatorColor = labelColor;
      }

      EdgeInsetsGeometry? labelPadding;
      if (node is figma.Frame) {
        labelPadding = EdgeInsets.symmetric(
          horizontal: node.paddingLeft.toDouble(),
          vertical: node.paddingTop.toDouble(),
        );
      } else if (node is figma.Instance) {
        labelPadding = EdgeInsets.symmetric(
          horizontal: node.paddingLeft.toDouble(),
          vertical: node.paddingTop.toDouble(),
        );
      }

      BorderRadius? borderRadius = decoration.borderRadius as BorderRadius?;
      Decoration? indicatorDecoration;
      if (borderRadius != null) {
        indicatorDecoration = BoxDecoration(
          color: indicatorColor,
          borderRadius: BorderRadius.only(
            bottomLeft: borderRadius.bottomLeft,
            bottomRight: borderRadius.bottomRight,
          ),
        );
      }

      return copyWith(
        labelColor: this.labelColor ?? labelColor,
        unselectedLabelColor: this.unselectedLabelColor ?? unselectedLabelColor,
        indicatorColor: this.indicatorColor ?? indicatorColor,
        indicator: indicator ?? indicatorDecoration,
        labelPadding: this.labelPadding ?? labelPadding,
      );
    } catch (_) {
      return this;
    }
  }
}
