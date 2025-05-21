import 'package:flutter/material.dart';
import 'package:morphr/adapters/figma_decoration_adapter.dart';
import 'package:morphr/morphr_service.dart';
import 'package:morphr_figma/morphr_figma.dart' as figma;

extension MorphrListTileThemeDataX on ListTileThemeData {
  ListTileThemeData morph(String componentName) {
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

      final Color? tileColor = decoration.color;

      Color? textColor;
      Color? iconColor;
      if (tileColor != null) {
        final brightness = ThemeData.estimateBrightnessForColor(tileColor);
        textColor = brightness == Brightness.dark ? Colors.white : Colors.black;
        iconColor = textColor;
      }

      final BorderRadius? borderRadius =
          decoration.borderRadius as BorderRadius?;
      ShapeBorder? shape;
      if (borderRadius != null) {
        shape = RoundedRectangleBorder(borderRadius: borderRadius);
      }

      VisualDensity? density;
      EdgeInsetsGeometry? contentPadding;
      if (node is figma.Frame) {
        contentPadding = EdgeInsets.fromLTRB(
          node.paddingLeft.toDouble(),
          node.paddingTop.toDouble(),
          node.paddingRight.toDouble(),
          node.paddingBottom.toDouble(),
        );

        final verticalPadding =
            node.paddingTop.toDouble() + node.paddingBottom.toDouble();
        if (verticalPadding < 8) {
          density = VisualDensity.compact;
        } else if (verticalPadding > 16) {
          density = VisualDensity.comfortable;
        } else {
          density = VisualDensity.standard;
        }
      } else if (node is figma.Instance) {
        contentPadding = EdgeInsets.fromLTRB(
          node.paddingLeft.toDouble(),
          node.paddingTop.toDouble(),
          node.paddingRight.toDouble(),
          node.paddingBottom.toDouble(),
        );

        final verticalPadding =
            node.paddingTop.toDouble() + node.paddingBottom.toDouble();
        if (verticalPadding < 8) {
          density = VisualDensity.compact;
        } else if (verticalPadding > 16) {
          density = VisualDensity.comfortable;
        } else {
          density = VisualDensity.standard;
        }
      }

      return copyWith(
        shape: this.shape ?? shape,
        iconColor: this.iconColor ?? iconColor,
        textColor: this.textColor ?? textColor,
        contentPadding: this.contentPadding ?? contentPadding,
        tileColor: this.tileColor ?? tileColor,
        visualDensity: visualDensity ?? density,
      );
    } catch (_) {
      return this;
    }
  }
}
