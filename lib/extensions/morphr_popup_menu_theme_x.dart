import 'package:flutter/material.dart';
import 'package:morphr/adapters/figma_decoration_adapter.dart';
import 'package:morphr/morphr_service.dart';
import 'package:morphr_figma/morphr_figma.dart' as figma;

extension MorphrPopupMenuThemeDataX on PopupMenuThemeData {
  PopupMenuThemeData morph(String componentName) {
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

      final List<BoxShadow>? shadows = decoration.boxShadow;
      double? elevation;
      if (shadows != null && shadows.isNotEmpty) {
        elevation = shadows.first.blurRadius / 2;
      }

      final BorderRadius? borderRadius =
          decoration.borderRadius as BorderRadius?;
      ShapeBorder? shape;
      if (borderRadius != null) {
        shape = RoundedRectangleBorder(borderRadius: borderRadius);
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

      return copyWith(
        menuPadding: menuPadding ?? padding,
        color: this.color ?? color,
        elevation: this.elevation ?? elevation,
        shadowColor:
            shadowColor ??
            (shadows?.isNotEmpty == true ? shadows!.first.color : null),
        shape: this.shape ?? shape,
      );
    } catch (_) {
      return this;
    }
  }
}
