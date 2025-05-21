import 'package:flutter/material.dart';
import 'package:morphr/adapters/figma_component_adapter.dart';
import 'package:morphr/extensions/morphr_border_x.dart';
import 'package:morphr/morphr_service.dart';

extension MorphrChipThemeDataX on ChipThemeData {
  ChipThemeData morph(String componentName) {
    if (componentName.isEmpty) {
      return this;
    }

    final node = MorphrService.instance.getComponent(componentName);
    if (node == null) return this;

    final component = FigmaComponentAdapter(node);

    try {
      final backgroundColor = component.colors.first;
      final side = Border().morph(componentName).top;

      Color? labelColor;
      Color? iconColor;
      Color? deleteIconColor;
      final brightness = ThemeData.estimateBrightnessForColor(backgroundColor);
      labelColor = brightness == Brightness.dark ? Colors.white : Colors.black;
      iconColor = labelColor;
      deleteIconColor =
          brightness == Brightness.dark
              ? Colors.white.withValues(alpha: 0.7)
              : Colors.black.withValues(alpha: 0.7);

      final borderRadius = component.borderRadius;
      final shape = RoundedRectangleBorder(
        borderRadius: borderRadius,
        side: side,
      );

      final padding = component.padding;

      final shadows = component.shadows;
      double? elevation;
      if (shadows.isNotEmpty) {
        elevation = shadows.first.blurRadius / 4;
      }

      return copyWith(
        backgroundColor: this.backgroundColor ?? backgroundColor,
        deleteIconColor: this.deleteIconColor ?? deleteIconColor,
        selectedColor: selectedColor ?? backgroundColor.withValues(alpha: 0.85),
        shadowColor:
            shadowColor ??
            (shadows.isNotEmpty == true ? shadows.first.color : null),
        labelStyle: labelStyle ?? TextStyle(color: labelColor),
        elevation: this.elevation ?? elevation,
        shape: this.shape ?? shape,
        side: this.side ?? side,
        padding: this.padding ?? padding,
        iconTheme: iconTheme ?? IconThemeData(color: iconColor, size: 18),
      );
    } catch (_) {
      return this;
    }
  }
}
