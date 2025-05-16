import 'package:flutter/material.dart';
import 'package:morphr/adapters/figma_decoration_adapter.dart';
import 'package:morphr/morphr_service.dart';

extension MorphrTextSelectionThemeDataX on TextSelectionThemeData {
  TextSelectionThemeData morph(String componentName) {
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

      Color? cursorColor;
      if (decoration.border != null) {
        cursorColor = decoration.border!.top.color;
      } else if (primaryColor != null) {
        cursorColor = primaryColor;
      }

      Color? selectionHandleColor;
      if (primaryColor != null) {
        selectionHandleColor = primaryColor;
      }

      Color? selectionColor;
      if (primaryColor != null) {
        selectionColor = primaryColor.withValues(alpha: 0.3);
      }

      return copyWith(
        cursorColor: this.cursorColor ?? cursorColor,
        selectionColor: this.selectionColor ?? selectionColor,
        selectionHandleColor: this.selectionHandleColor ?? selectionHandleColor,
      );
    } catch (_) {
      return this;
    }
  }
}
