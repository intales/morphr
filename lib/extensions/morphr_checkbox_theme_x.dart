import 'package:flutter/material.dart';
import 'package:morphr/adapters/figma_decoration_adapter.dart';
import 'package:morphr/morphr_service.dart';
import 'package:morphr_figma/morphr_figma.dart' as figma;

extension MorphrCheckboxThemeDataX on CheckboxThemeData {
  CheckboxThemeData morph(String componentName) {
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

      // Estrai colori di base
      final Color? backgroundColor = decoration.color;
      final BorderSide? side = decoration.border?.top;

      // Estrai forma dai bordi
      final BorderRadius? borderRadius =
          decoration.borderRadius as BorderRadius?;
      OutlinedBorder? shape;
      if (borderRadius != null) {
        shape = RoundedRectangleBorder(borderRadius: borderRadius);
      } else if (decoration.shape == BoxShape.circle) {
        shape = CircleBorder();
      }

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
              return null; // Default color
            }),
        splashRadius: this.splashRadius ?? splashRadius,
        shape: this.shape ?? shape,
        side: this.side ?? side,
      );
    } catch (_) {
      return this;
    }
  }
}
