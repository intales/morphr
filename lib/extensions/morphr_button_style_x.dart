import 'package:flutter/material.dart';
import 'package:morphr/adapters/figma_decoration_adapter.dart';
import 'package:morphr/morphr_service.dart';
import 'package:morphr_figma/morphr_figma.dart' as figma;

extension MorphrButtonStyleX on ButtonStyle {
  ButtonStyle morph(String componentName) {
    if (componentName.isEmpty) {
      return this;
    }

    final node = MorphrService.instance.getComponent(componentName);
    if (node == null) return this;

    final decorationAdapter = FigmaDecorationAdapter(node);

    if (!decorationAdapter.supportsDecoration) return this;

    try {
      final decoration = decorationAdapter.createBoxDecoration();

      final Color? backgroundColor = decoration.color;
      final BorderRadius? borderRadius =
          decoration.borderRadius as BorderRadius?;
      final BorderSide? borderSide = decoration.border?.top;
      final List<BoxShadow>? shadows = decoration.boxShadow;

      OutlinedBorder? shape;
      if (decoration.shape == BoxShape.circle) {
        shape = const CircleBorder();
      } else if (borderRadius != null) {
        shape = RoundedRectangleBorder(
          borderRadius: borderRadius,
          side: borderSide ?? BorderSide.none,
        );
      } else if (borderSide != null) {
        shape = RoundedRectangleBorder(side: borderSide);
      }

      double? elevation;
      if (shadows != null && shadows.isNotEmpty) {
        elevation = shadows.first.blurRadius;
      }

      EdgeInsetsGeometry? padding;
      if (node is figma.Frame) {
        padding = EdgeInsets.fromLTRB(
          node.paddingLeft.toDouble(),
          node.paddingTop.toDouble(),
          node.paddingRight.toDouble(),
          node.paddingBottom.toDouble(),
        );
      } else if (node is figma.Instance) {
        padding = EdgeInsets.fromLTRB(
          node.paddingLeft.toDouble(),
          node.paddingTop.toDouble(),
          node.paddingRight.toDouble(),
          node.paddingBottom.toDouble(),
        );
      }

      Color? overlayColor;
      if (backgroundColor != null) {
        overlayColor = backgroundColor.withValues(alpha: 0.1);
      }

      return copyWith(
        backgroundColor:
            this.backgroundColor ??
            (backgroundColor != null
                ? WidgetStatePropertyAll<Color>(backgroundColor)
                : this.backgroundColor),
        overlayColor:
            this.overlayColor ??
            (overlayColor != null
                ? WidgetStatePropertyAll<Color>(overlayColor)
                : this.overlayColor),
        shadowColor:
            shadowColor ??
            (shadows != null && shadows.isNotEmpty
                ? WidgetStatePropertyAll<Color>(shadows.first.color)
                : shadowColor),
        elevation:
            this.elevation ??
            (elevation != null
                ? WidgetStatePropertyAll<double>(elevation)
                : this.elevation),
        padding:
            this.padding ??
            (padding != null
                ? WidgetStatePropertyAll<EdgeInsetsGeometry>(padding)
                : this.padding),
        shape:
            this.shape ??
            (shape != null
                ? WidgetStatePropertyAll<OutlinedBorder>(shape)
                : this.shape),
      );
    } catch (_) {
      return this;
    }
  }
}
