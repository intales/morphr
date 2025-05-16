import 'package:flutter/material.dart';
import 'package:morphr/adapters/figma_decoration_adapter.dart';
import 'package:morphr/morphr_service.dart';

extension MorphrDialogThemeX on DialogTheme {
  DialogTheme morph(String componentName) {
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

      final List<BoxShadow>? shadows = decoration.boxShadow;
      double? elevation;
      if (shadows != null && shadows.isNotEmpty) {
        elevation = shadows.first.blurRadius;
      }

      final BorderRadius? borderRadius =
          decoration.borderRadius as BorderRadius?;
      ShapeBorder? shape;
      if (borderRadius != null) {
        shape = RoundedRectangleBorder(borderRadius: borderRadius);
      }

      return copyWith(
        backgroundColor: this.backgroundColor ?? backgroundColor,
        elevation: this.elevation ?? elevation,
        shadowColor:
            shadowColor ??
            (shadows != null && shadows.isNotEmpty
                ? shadows.first.color
                : null),
        shape: this.shape ?? shape,
      );
    } catch (_) {
      return this;
    }
  }
}
