import 'package:flutter/material.dart';
import 'package:morphr/adapters/figma_decoration_adapter.dart';
import 'package:morphr/morphr_service.dart';
import 'package:morphr_figma/morphr_figma.dart' as figma;

extension MorphrTooltipThemeDataX on TooltipThemeData {
  TooltipThemeData morph(String componentName) {
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

      final BorderRadius? borderRadius =
          decoration.borderRadius as BorderRadius?;
      BoxDecoration? tooltipDecoration;
      if (borderRadius != null || backgroundColor != null) {
        tooltipDecoration = BoxDecoration(
          color: backgroundColor,
          borderRadius: borderRadius,
        );
      }

      EdgeInsetsGeometry? padding;
      double? verticalOffset;
      if (node is figma.Frame) {
        padding = EdgeInsets.symmetric(
          horizontal: node.paddingLeft.toDouble(),
          vertical: node.paddingTop.toDouble(),
        );
        verticalOffset = node.paddingBottom.toDouble() * 2;
      } else if (node is figma.Instance) {
        padding = EdgeInsets.symmetric(
          horizontal: node.paddingLeft.toDouble(),
          vertical: node.paddingTop.toDouble(),
        );
        verticalOffset = node.paddingBottom.toDouble() * 2;
      }

      double? height;
      if (node is figma.Frame) {
        height = node.absoluteBoundingBox?.height?.toDouble();
      } else if (node is figma.Instance) {
        height = node.absoluteBoundingBox?.height?.toDouble();
      } else if (node is figma.Rectangle) {
        height = node.absoluteBoundingBox?.height?.toDouble();
      }

      return copyWith(
        height: this.height ?? height,
        padding: this.padding ?? padding,
        verticalOffset: this.verticalOffset ?? verticalOffset,
        decoration: this.decoration ?? tooltipDecoration,
      );
    } catch (_) {
      return this;
    }
  }
}
