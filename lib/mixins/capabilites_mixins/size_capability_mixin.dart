import 'package:flutter/material.dart';
import 'package:morphr/archetypes/widget_archetype.dart';
import 'package:morphr_figma/morphr_figma.dart' as figma;

mixin SizeCapability {
  Capability get supportsSize => (Widget widget) {
    return widget is Container ||
        widget is SizedBox ||
        widget is ConstrainedBox;
  };

  double? extractWidth(figma.Node node) {
    if (node is figma.Rectangle) {
      return node.absoluteBoundingBox?.width?.toDouble();
    } else if (node is figma.Frame) {
      return node.absoluteBoundingBox?.width?.toDouble();
    }
    return null;
  }

  double? extractHeight(figma.Node node) {
    if (node is figma.Rectangle) {
      return node.absoluteBoundingBox?.height?.toDouble();
    } else if (node is figma.Frame) {
      return node.absoluteBoundingBox?.height?.toDouble();
    }
    return null;
  }

  Widget buildFromSizedBox(SizedBox sizedBox, figma.Node node) {
    return SizedBox(
      key: sizedBox.key,
      width: extractWidth(node) ?? sizedBox.width,
      height: extractHeight(node) ?? sizedBox.height,
      child: sizedBox.child,
    );
  }

  BoxConstraints? extractConstraints(Widget widget) {
    if (widget is Container) return widget.constraints;
    if (widget is ConstrainedBox) return widget.constraints;
    return null;
  }
}
