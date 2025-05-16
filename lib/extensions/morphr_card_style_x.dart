import 'package:flutter/material.dart';
import 'package:morphr/adapters/figma_decoration_adapter.dart';
import 'package:morphr/morphr_service.dart';
import 'package:morphr_figma/morphr_figma.dart' as figma;

extension MorphrCardThemeX on CardTheme {
  CardTheme morph(String componentName) {
    if (componentName.isEmpty) {
      return this;
    }

    final node = MorphrService.instance.getComponent(componentName);
    if (node == null) return this;

    final decorationAdapter = FigmaDecorationAdapter(node);

    if (!decorationAdapter.supportsDecoration) return this;

    try {
      final decoration = decorationAdapter.createBoxDecoration();

      final Color? color = decoration.color;
      final BorderRadius? borderRadius =
          decoration.borderRadius as BorderRadius?;
      final List<BoxShadow>? shadows = decoration.boxShadow;

      ShapeBorder? shape;
      if (decoration.shape == BoxShape.circle) {
        shape = const CircleBorder();
      } else if (borderRadius != null) {
        shape = RoundedRectangleBorder(borderRadius: borderRadius);
      }

      EdgeInsetsGeometry? margin;
      if (node is figma.Frame) {
        margin = EdgeInsets.fromLTRB(
          node.paddingLeft.toDouble(),
          node.paddingTop.toDouble(),
          node.paddingRight.toDouble(),
          node.paddingBottom.toDouble(),
        );
      } else if (node is figma.Instance) {
        margin = EdgeInsets.fromLTRB(
          node.paddingLeft.toDouble(),
          node.paddingTop.toDouble(),
          node.paddingRight.toDouble(),
          node.paddingBottom.toDouble(),
        );
      }

      double? elevation;
      if (shadows != null && shadows.isNotEmpty) {
        elevation = shadows.first.blurRadius / 2;
      }

      return copyWith(
        color: this.color ?? color,
        shadowColor:
            shadowColor ??
            (shadows != null && shadows.isNotEmpty
                ? shadows.first.color
                : null),
        elevation: this.elevation ?? elevation,
        margin: this.margin ?? margin,
        shape: this.shape ?? shape,
      );
    } catch (_) {
      return this;
    }
  }
}
