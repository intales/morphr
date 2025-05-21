import 'package:flutter/material.dart';
import 'package:morphr/adapters/figma_component_adapter.dart';
import 'package:morphr/morphr_service.dart';

extension MorphrDialogThemeX on DialogTheme {
  DialogTheme morph(String componentName) {
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
        elevation = shadows.first.blurRadius;
      }

      final borderRadius = component.borderRadius;
      final shape = RoundedRectangleBorder(borderRadius: borderRadius);

      return copyWith(
        backgroundColor: this.backgroundColor ?? backgroundColor,
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
