import 'package:flutter/widgets.dart';
import 'package:morphr/morphr_service.dart';
import 'package:morphr_figma/morphr_figma.dart' as figma;

extension MorphrEdgeInsetsX on EdgeInsets {
  EdgeInsets morph(String componentName, {Axis? direction}) {
    if (componentName.isEmpty) {
      return this;
    }

    final node = MorphrService.instance.getComponent(componentName);
    if (node == null) return this;

    try {
      double left = 0;
      double top = 0;
      double right = 0;
      double bottom = 0;

      if (node is figma.Frame) {
        left = node.paddingLeft.toDouble();
        top = node.paddingTop.toDouble();
        right = node.paddingRight.toDouble();
        bottom = node.paddingBottom.toDouble();
      } else if (node is figma.Instance) {
        left = node.paddingLeft.toDouble();
        top = node.paddingTop.toDouble();
        right = node.paddingRight.toDouble();
        bottom = node.paddingBottom.toDouble();
      } else {
        return this;
      }

      if (direction == Axis.horizontal) {
        top = 0;
        bottom = 0;
      } else if (direction == Axis.vertical) {
        left = 0;
        right = 0;
      }

      return EdgeInsets.fromLTRB(
        this.left > 0 ? this.left : left,
        this.top > 0 ? this.top : top,
        this.right > 0 ? this.right : right,
        this.bottom > 0 ? this.bottom : bottom,
      );
    } catch (_) {
      return this;
    }
  }
}
