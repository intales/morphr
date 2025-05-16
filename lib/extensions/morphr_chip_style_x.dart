import 'package:flutter/material.dart';
import 'package:morphr/adapters/figma_decoration_adapter.dart';
import 'package:morphr/morphr_service.dart';
import 'package:morphr_figma/morphr_figma.dart' as figma;

extension MorphrChipThemeDataX on ChipThemeData {
  ChipThemeData morph(String componentName) {
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
      final BorderSide? side = decoration.border?.top;

      Color? labelColor;
      Color? iconColor;
      Color? deleteIconColor;
      if (backgroundColor != null) {
        final brightness = ThemeData.estimateBrightnessForColor(
          backgroundColor,
        );
        labelColor =
            brightness == Brightness.dark ? Colors.white : Colors.black;
        iconColor = labelColor;
        deleteIconColor =
            brightness == Brightness.dark
                ? Colors.white.withValues(alpha: 0.7)
                : Colors.black.withValues(alpha: 0.7);
      }

      final BorderRadius? borderRadius =
          decoration.borderRadius as BorderRadius?;
      OutlinedBorder? shape;
      if (borderRadius != null) {
        shape = RoundedRectangleBorder(
          borderRadius: borderRadius,
          side: side ?? BorderSide.none,
        );
      } else if (side != null) {
        shape = RoundedRectangleBorder(side: side);
      }

      EdgeInsetsGeometry? padding;
      double? labelPadding;
      if (node is figma.Frame) {
        padding = EdgeInsets.symmetric(
          horizontal:
              node.paddingLeft.toDouble() + node.paddingRight.toDouble(),
          vertical: node.paddingTop.toDouble() + node.paddingBottom.toDouble(),
        );
        labelPadding = node.itemSpacing.toDouble();
      } else if (node is figma.Instance) {
        padding = EdgeInsets.symmetric(
          horizontal:
              node.paddingLeft.toDouble() + node.paddingRight.toDouble(),
          vertical: node.paddingTop.toDouble() + node.paddingBottom.toDouble(),
        );
        labelPadding = node.itemSpacing.toDouble();
      }

      final List<BoxShadow>? shadows = decoration.boxShadow;
      double? elevation;
      if (shadows != null && shadows.isNotEmpty) {
        elevation = shadows.first.blurRadius / 4;
      }

      return copyWith(
        backgroundColor: this.backgroundColor ?? backgroundColor,
        deleteIconColor: this.deleteIconColor ?? deleteIconColor,
        selectedColor:
            selectedColor ?? backgroundColor?.withValues(alpha: 0.85),
        shadowColor:
            shadowColor ??
            (shadows?.isNotEmpty == true ? shadows!.first.color : null),
        labelStyle: labelStyle ?? TextStyle(color: labelColor),
        elevation: this.elevation ?? elevation,
        shape: this.shape ?? shape,
        side: this.side ?? side,
        padding: this.padding ?? padding,
        labelPadding:
            this.labelPadding ??
            (labelPadding != null
                ? EdgeInsets.symmetric(horizontal: labelPadding)
                : null),
        iconTheme:
            iconTheme ??
            (iconColor != null
                ? IconThemeData(color: iconColor, size: 18)
                : null),
      );
    } catch (_) {
      return this;
    }
  }
}
