import 'package:flutter/material.dart';
import 'package:morphr/adapters/figma_component_adapter.dart';
import 'package:morphr/morphr_service.dart';

extension MorphrCardThemeX on CardTheme {
  CardTheme morph(String componentName) {
    if (componentName.isEmpty) {
      return this;
    }

    final node = MorphrService.instance.getComponent(componentName);
    if (node == null) return this;

    final component = FigmaComponentAdapter(node);

    try {
      final color = component.colors.first;
      final borderRadius = component.borderRadius;
      final shadows = component.shadows;

      ShapeBorder? shape;
      if (component.shape == BoxShape.circle) {
        shape = const CircleBorder();
      } else {
        shape = RoundedRectangleBorder(borderRadius: borderRadius);
      }

      final margin = component.padding;

      double? elevation;
      if (shadows.isNotEmpty) {
        elevation = shadows.first.blurRadius / 2;
      }

      return copyWith(
        color: this.color ?? color,
        shadowColor:
            shadowColor ?? (shadows.isNotEmpty ? shadows.first.color : null),
        elevation: this.elevation ?? elevation,
        margin: this.margin ?? margin,
        shape: this.shape ?? shape,
      );
    } catch (_) {
      return this;
    }
  }
}
