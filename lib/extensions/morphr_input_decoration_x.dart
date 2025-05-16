import 'package:flutter/material.dart';
import 'package:morphr/adapters/figma_decoration_adapter.dart';
import 'package:morphr/morphr_service.dart';
import 'package:morphr_figma/morphr_figma.dart' as figma;

extension MorphrInputDecorationX on InputDecoration {
  InputDecoration morph(String componentName) {
    if (componentName.isEmpty) {
      return this;
    }

    final node = MorphrService.instance.getComponent(componentName);
    if (node == null) return this;

    final decorationAdapter = FigmaDecorationAdapter(node);
    if (!decorationAdapter.supportsDecoration) return this;

    try {
      final decoration = decorationAdapter.createBoxDecoration();

      final Color? fillColor = decoration.color;
      final BorderRadius? borderRadius =
          decoration.borderRadius as BorderRadius?;
      final BorderSide? borderSide = decoration.border?.top;

      InputBorder? border;
      InputBorder? focusedBorder;
      InputBorder? enabledBorder;

      if (borderRadius != null && borderSide != null) {
        border = OutlineInputBorder(
          borderRadius: borderRadius,
          borderSide: borderSide,
        );

        focusedBorder = OutlineInputBorder(
          borderRadius: borderRadius,
          borderSide: borderSide.copyWith(width: borderSide.width + 1),
        );

        enabledBorder = OutlineInputBorder(
          borderRadius: borderRadius,
          borderSide: borderSide,
        );
      } else if (borderSide != null) {
        border = UnderlineInputBorder(borderSide: borderSide);

        focusedBorder = UnderlineInputBorder(
          borderSide: borderSide.copyWith(width: borderSide.width + 1),
        );

        enabledBorder = UnderlineInputBorder(borderSide: borderSide);
      }

      EdgeInsetsGeometry? contentPadding;
      if (node is figma.Frame) {
        contentPadding = EdgeInsets.fromLTRB(
          node.paddingLeft.toDouble(),
          node.paddingTop.toDouble(),
          node.paddingRight.toDouble(),
          node.paddingBottom.toDouble(),
        );
      } else if (node is figma.Instance) {
        contentPadding = EdgeInsets.fromLTRB(
          node.paddingLeft.toDouble(),
          node.paddingTop.toDouble(),
          node.paddingRight.toDouble(),
          node.paddingBottom.toDouble(),
        );
      }

      return copyWith(
        filled: fillColor != null ? true : filled,
        fillColor: fillColor ?? this.fillColor,
        border: border ?? this.border,
        focusedBorder: focusedBorder ?? this.focusedBorder,
        enabledBorder: enabledBorder ?? this.enabledBorder,
        contentPadding: contentPadding ?? this.contentPadding,
      );
    } catch (_) {
      return this;
    }
  }
}
