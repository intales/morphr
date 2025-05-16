import 'package:flutter/material.dart';
import 'package:morphr/adapters/figma_decoration_adapter.dart';
import 'package:morphr/morphr_service.dart';
import 'package:morphr_figma/morphr_figma.dart' as figma;

extension MorphrSwitchThemeDataX on SwitchThemeData {
  SwitchThemeData morph(String componentName) {
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

      Color? thumbColor;
      Color? trackColor;
      Color? trackOutlineColor;

      if (decoration.border != null) {
        trackOutlineColor = decoration.border?.top.color;
      }

      if (backgroundColor != null) {
        trackColor = backgroundColor;

        final brightness = ThemeData.estimateBrightnessForColor(
          backgroundColor,
        );
        thumbColor =
            brightness == Brightness.dark ? Colors.white : Colors.black;
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
          splashRadius = width / 4;
        }
      }

      return copyWith(
        thumbColor:
            this.thumbColor ??
            WidgetStateProperty.resolveWith((states) {
              if (states.contains(WidgetState.selected)) {
                return thumbColor;
              }
              return null;
            }),
        trackColor:
            this.trackColor ??
            WidgetStateProperty.resolveWith((states) {
              if (states.contains(WidgetState.selected)) {
                return trackColor;
              }
              return null;
            }),
        trackOutlineColor:
            this.trackOutlineColor ??
            WidgetStateProperty.resolveWith((states) {
              if (!states.contains(WidgetState.selected)) {
                return trackOutlineColor;
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
