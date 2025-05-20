import 'package:flutter/material.dart';
import 'package:morphr/adapters/figma_component_adapter.dart';
import 'package:morphr/morphr_service.dart';

extension MorphrAppBarThemeX on AppBarTheme {
  AppBarTheme morph(String componentName) {
    if (componentName.isEmpty) {
      return this;
    }

    final node = MorphrService.instance.getComponent(componentName);
    if (node == null) return this;

    final component = FigmaComponentAdapter(node);

    try {
      final backgroundColor = component.colors.first;

      final shadows = component.shadows;
      double? elevation;
      if (shadows.isNotEmpty) {
        elevation = shadows.first.blurRadius / 2;
      }

      final borderRadius = component.borderRadius;
      final shape = RoundedRectangleBorder(borderRadius: borderRadius);

      final brightness = ThemeData.estimateBrightnessForColor(backgroundColor);
      final foregroundColor =
          brightness == Brightness.dark ? Colors.white : Colors.black;

      return copyWith(
        backgroundColor: this.backgroundColor ?? backgroundColor,
        foregroundColor: this.foregroundColor ?? foregroundColor,
        elevation: this.elevation ?? elevation,
        shadowColor:
            shadowColor ?? (shadows.isNotEmpty ? shadows.first.color : null),
        shape: this.shape ?? shape,
      );
    } catch (_) {
      return this;
    }
  }
}
