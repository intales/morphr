import 'package:flutter/material.dart';
import 'package:figma/figma.dart' as figma;
import 'package:morphr/renderers/figma_shape_decoration_renderer.dart';

class FigmaShapeRenderer with FigmaShapeDecorationRenderer {
  const FigmaShapeRenderer();

  Widget render({
    required final figma.Node node,
    final Widget? child,
    final AlignmentGeometry? alignment = Alignment.center,
  }) {
    if (node is! figma.Rectangle && node is! figma.Ellipse) {
      throw ArgumentError('Node must be a RECTANGLE or ELLIPSE node');
    }

    final container = Container(
      width: _getWidth(node),
      height: _getHeight(node),
      decoration: getDecoration(node),
      alignment: alignment,
      child: child,
    );

    return container;
  }

  double? _getWidth(figma.Node node) {
    if (node is figma.Rectangle) {
      return node.absoluteBoundingBox?.width?.toDouble();
    }
    if (node is figma.Ellipse) {
      return node.absoluteBoundingBox?.width?.toDouble();
    }
    return null;
  }

  double? _getHeight(figma.Node node) {
    if (node is figma.Rectangle) {
      return node.absoluteBoundingBox?.height?.toDouble();
    }
    if (node is figma.Ellipse) {
      return node.absoluteBoundingBox?.height?.toDouble();
    }
    return null;
  }
}
