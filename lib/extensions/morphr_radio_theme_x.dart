import 'package:flutter/material.dart';
import 'package:morphr/adapters/figma_decoration_adapter.dart';
import 'package:morphr/morphr_service.dart';
import 'package:morphr_figma/morphr_figma.dart' as figma;

extension MorphrRadioThemeDataX on RadioThemeData {
  RadioThemeData morph(String componentName) {
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

      double? splashRadius;
      if (node is figma.Frame ||
          node is figma.Instance ||
          node is figma.Rectangle) {
        double? width;

        if (node is figma.Frame) {
          width = node.absoluteBoundingBox?.width?.toDouble();
        } else if (node is figma.Instance) {
          width = node.absoluteBoundingBox?.width?.toDouble();
        } else if (node is figma.Rectangle) {
          width = node.absoluteBoundingBox?.width?.toDouble();
        }

        if (width != null) {
          splashRadius = width * 1.2;
        }
      }

      return copyWith(
        fillColor:
            fillColor ??
            WidgetStateProperty.resolveWith((states) {
              if (states.contains(WidgetState.selected)) {
                return backgroundColor;
              }
              return null;
            }),
        splashRadius: this.splashRadius ?? splashRadius,
      );
    } catch (_) {
      return this;
    }
  }
}
