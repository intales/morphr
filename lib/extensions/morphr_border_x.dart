import 'package:flutter/material.dart';
import 'package:morphr/adapters/figma_decoration_adapter.dart';
import 'package:morphr/morphr_service.dart';

extension MorphrBorderX on Border {
  Border morph(String componentName) {
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

      final Border? border = decoration.border as Border?;
      if (border == null) return this;

      return Border(
        top: top.width > 0 ? top : border.top,
        right: right.width > 0 ? right : border.right,
        bottom: bottom.width > 0 ? bottom : border.bottom,
        left: left.width > 0 ? left : border.left,
      );
    } catch (_) {
      return this;
    }
  }
}
