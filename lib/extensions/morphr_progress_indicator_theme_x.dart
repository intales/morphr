import 'package:flutter/material.dart';
import 'package:morphr/adapters/figma_decoration_adapter.dart';
import 'package:morphr/morphr_service.dart';
import 'package:morphr_figma/morphr_figma.dart' as figma;

extension MorphrProgressIndicatorThemeDataX on ProgressIndicatorThemeData {
  ProgressIndicatorThemeData morph(String componentName) {
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

      final Color? color = decoration.color;

      Color? trackColor;
      if (decoration.border != null) {
        trackColor = decoration.border!.top.color;
      } else if (color != null) {
        trackColor = color.withValues(alpha: 0.2);
      }

      double? linearTrackHeight;
      double? circularTrackWidth;

      if (node is figma.Frame ||
          node is figma.Instance ||
          node is figma.Rectangle) {
        double? height;

        if (node is figma.Frame) {
          height = node.absoluteBoundingBox?.height?.toDouble();
        } else if (node is figma.Rectangle) {
          height = node.absoluteBoundingBox?.height?.toDouble();
        } else if (node is figma.Instance) {
          height = node.absoluteBoundingBox?.height?.toDouble();
        }

        if (height != null && height > 0) {
          linearTrackHeight = height;
          circularTrackWidth = height / 10;
        }
      }

      final BorderRadius? borderRadius =
          decoration.borderRadius as BorderRadius?;

      Color? refreshBackgroundColor;
      if (color != null) {
        refreshBackgroundColor = color.withValues(alpha: 0.1);
      }

      return copyWith(
        borderRadius: this.borderRadius ?? borderRadius,
        color: this.color ?? color,
        linearTrackColor: linearTrackColor ?? trackColor,
        linearMinHeight: linearMinHeight ?? linearTrackHeight,
        circularTrackColor: circularTrackColor ?? trackColor,
        refreshBackgroundColor:
            this.refreshBackgroundColor ?? refreshBackgroundColor,
        circularTrackPadding:
            circularTrackPadding ?? EdgeInsets.all(circularTrackWidth!),
      );
    } catch (_) {
      return this;
    }
  }
}
