import 'package:flutter/material.dart';
import 'package:morphr/adapters/figma_decoration_adapter.dart';
import 'package:morphr/morphr_service.dart';
import 'package:morphr_figma/morphr_figma.dart' as figma;

extension MorphrSliderThemeDataX on SliderThemeData {
  SliderThemeData morph(String componentName) {
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

      final Color? primaryColor = decoration.color;

      Color? inactiveTrackColor;
      double? trackHeight;
      if (decoration.border != null) {
        inactiveTrackColor = decoration.border!.top.color.withValues(
          alpha: 0.3,
        );
        trackHeight = decoration.border!.top.width * 2;
      }

      double? thumbRadius;
      double? overlayRadius;
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
          thumbRadius = height / 2;
          overlayRadius = thumbRadius * 2.5;
        }
      }

      RangeSliderThumbShape? rangeThumbShape;
      SliderComponentShape? thumbShape;
      final BorderRadius? borderRadius =
          decoration.borderRadius as BorderRadius?;
      if (borderRadius != null && thumbRadius != null) {
        thumbShape = RoundSliderThumbShape(
          enabledThumbRadius: thumbRadius,
          elevation: 1.0,
        );

        rangeThumbShape = RoundRangeSliderThumbShape(
          enabledThumbRadius: thumbRadius,
          elevation: 1.0,
        );
      } else if (thumbRadius != null) {
        thumbShape = RoundSliderThumbShape(
          enabledThumbRadius: thumbRadius,
          elevation: 1.0,
        );

        rangeThumbShape = RoundRangeSliderThumbShape(
          enabledThumbRadius: thumbRadius,
          elevation: 1.0,
        );
      }

      SliderComponentShape? overlayShape;
      if (overlayRadius != null) {
        overlayShape = RoundSliderOverlayShape(overlayRadius: overlayRadius);
      }

      SliderTrackShape? trackShape;
      if (trackHeight != null) {
        trackShape = RoundedRectSliderTrackShape();
      }

      return copyWith(
        trackHeight: this.trackHeight ?? trackHeight,
        activeTrackColor: activeTrackColor ?? primaryColor,
        inactiveTrackColor: this.inactiveTrackColor ?? inactiveTrackColor,
        overlayColor: overlayColor ?? primaryColor?.withValues(alpha: 0.2),
        valueIndicatorColor: valueIndicatorColor ?? primaryColor,
        overlayShape: this.overlayShape ?? overlayShape,
        thumbShape: this.thumbShape ?? thumbShape,
        trackShape: this.trackShape ?? trackShape,
        rangeThumbShape: this.rangeThumbShape ?? rangeThumbShape,
      );
    } catch (_) {
      return this;
    }
  }
}
