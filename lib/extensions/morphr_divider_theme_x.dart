import 'package:flutter/material.dart';
import 'package:morphr/adapters/figma_decoration_adapter.dart';
import 'package:morphr/morphr_service.dart';
import 'package:morphr_figma/morphr_figma.dart' as figma;

extension MorphrDividerThemeDataX on DividerThemeData {
  DividerThemeData morph(String componentName) {
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

      Color? color;
      if (decoration.border != null && decoration.border!.isUniform) {
        color = decoration.border!.top.color;
      } else if (decoration.color != null) {
        color = decoration.color;
      }

      double? thickness;
      if (decoration.border != null && decoration.border!.isUniform) {
        thickness = decoration.border!.top.width;
      } else if (node is figma.Frame ||
          node is figma.Rectangle ||
          node is figma.Instance) {
        double? height;

        if (node is figma.Frame) {
          height = node.absoluteBoundingBox?.height?.toDouble();
        } else if (node is figma.Rectangle) {
          height = node.absoluteBoundingBox?.height?.toDouble();
        } else if (node is figma.Instance) {
          height = node.absoluteBoundingBox?.height?.toDouble();
        }

        if (height != null && height > 0) {
          thickness = height;
        }
      }

      double? indent;
      double? endIndent;
      if (node is figma.Frame) {
        indent = node.paddingLeft.toDouble();
        endIndent = node.paddingRight.toDouble();
      } else if (node is figma.Instance) {
        indent = node.paddingLeft.toDouble();
        endIndent = node.paddingRight.toDouble();
      }

      double? space;
      if (node is figma.Frame) {
        final verticalPadding =
            node.paddingTop.toDouble() + node.paddingBottom.toDouble();
        if (verticalPadding > 0) {
          space = verticalPadding;
        }
      } else if (node is figma.Instance) {
        final verticalPadding =
            node.paddingTop.toDouble() + node.paddingBottom.toDouble();
        if (verticalPadding > 0) {
          space = verticalPadding;
        }
      }

      return copyWith(
        color: this.color ?? color,
        space: this.space ?? space,
        thickness: this.thickness ?? thickness,
        indent: this.indent ?? indent,
        endIndent: this.endIndent ?? endIndent,
      );
    } catch (_) {
      return this;
    }
  }
}
