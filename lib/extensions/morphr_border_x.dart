import 'package:flutter/material.dart';
import 'package:morphr/adapters/figma_component_adapter.dart';
import 'package:morphr/morphr_service.dart';

extension MorphrBorderX on Border {
  Border morph(String componentName) {
    if (componentName.isEmpty) {
      return this;
    }

    final node = MorphrService.instance.getComponent(componentName);
    if (node == null) return this;

    final component = FigmaComponentAdapter(node);

    try {
      final borderColor = component.strokes.first;

      return Border(
        top:
            top.width > 0
                ? top
                : BorderSide(
                  width: component.topBorderWidth,
                  color: borderColor,
                ),
        right:
            right.width > 0
                ? right
                : BorderSide(
                  width: component.rightBorderWidth,
                  color: borderColor,
                ),
        bottom:
            bottom.width > 0
                ? bottom
                : BorderSide(
                  width: component.bottomBorderWidth,
                  color: borderColor,
                ),
        left:
            left.width > 0
                ? left
                : BorderSide(
                  width: component.leftBorderWidth,
                  color: borderColor,
                ),
      );
    } catch (_) {
      return this;
    }
  }
}
