import 'package:flutter/material.dart';
import 'package:morphr/adapters/figma_decoration_adapter.dart';
import 'package:morphr/morphr_service.dart';

extension MorphrBorderRadiusX on BorderRadius {
  BorderRadius morph(String componentName) {
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

      final BorderRadius? borderRadius =
          decoration.borderRadius as BorderRadius?;
      if (borderRadius == null) return this;

      return BorderRadius.only(
        topLeft: topLeft != Radius.zero ? topLeft : borderRadius.topLeft,
        topRight: topRight != Radius.zero ? topRight : borderRadius.topRight,
        bottomLeft:
            bottomLeft != Radius.zero ? bottomLeft : borderRadius.bottomLeft,
        bottomRight:
            bottomRight != Radius.zero ? bottomRight : borderRadius.bottomRight,
      );
    } catch (_) {
      return this;
    }
  }
}
