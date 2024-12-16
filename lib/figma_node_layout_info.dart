import 'dart:math';

import 'package:figma/figma.dart' as figma;
import 'package:flutter/material.dart';

class NodeLayoutInfo {
  final figma.Node node;
  final Widget widget;
  final bool isInput;
  final figma.Node? parentNode;

  const NodeLayoutInfo({
    required this.node,
    required this.widget,
    this.isInput = false,
    this.parentNode,
  });

  Point<double>? getPosition() {
    final transform = _getTransform();
    if (transform != null && transform.length >= 2) {
      return Point(transform[0][2], transform[1][2]);
    }
    return null;
  }

  Size? getSize() {
    if (isInput && node is figma.Text && parentNode != null) {
      final parentBox = _getBoundingBox(parentNode!);
      if (parentBox?.width != null && parentBox?.height != null) {
        return Size(
          parentBox!.width!.toDouble(),
          parentBox.height!.toDouble(),
        );
      }
    }

    final boundingBox = _getBoundingBox(node);
    if (boundingBox?.width != null && boundingBox?.height != null) {
      return Size(
        boundingBox!.width!.toDouble(),
        boundingBox.height!.toDouble(),
      );
    }
    return null;
  }

  List<List<double>>? _getTransform() {
    return switch (node) {
      figma.Frame frame => frame.relativeTransform,
      figma.Rectangle rect => rect.relativeTransform,
      figma.Vector vector => vector.relativeTransform,
      _ => null,
    };
  }

  figma.SizeRectangle? _getBoundingBox(figma.Node node) {
    return switch (node) {
      figma.Frame frame => frame.absoluteBoundingBox,
      figma.Rectangle rect => rect.absoluteBoundingBox,
      figma.Vector vector => vector.absoluteBoundingBox,
      _ => null,
    };
  }
}
