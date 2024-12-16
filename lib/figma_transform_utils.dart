import 'dart:math' as math;

import 'package:flutter/widgets.dart';
import 'package:figma/figma.dart' as figma;

class FigmaTransformUtils {
  const FigmaTransformUtils._();

  static List<List<num>>? getRelativeTransform(figma.Node node) {
    if (node is figma.Rectangle) return node.relativeTransform;
    if (node is figma.Ellipse) return node.relativeTransform;
    if (node is figma.Vector) return node.relativeTransform;
    if (node is figma.Text) return node.relativeTransform;
    if (node is figma.Frame) return node.relativeTransform;
    return null;
  }

  static Widget applyRotation(Widget child, figma.Node node) {
    final transform = getRelativeTransform(node);
    if (transform == null) return child;

    final a = transform[0][0].toDouble();
    final b = transform[0][1].toDouble();

    final rotation = b != 0 || a != 0 ? math.atan2(b, a) : 0;
    if (rotation == 0) return child;

    return Transform.rotate(
      angle: -rotation.toDouble(),
      alignment: Alignment.center,
      child: child,
    );
  }

  static Widget wrapWithRotation(Widget child, figma.Node node) {
    return applyRotation(child, node);
  }

  static bool hasRotation(figma.Node node) {
    final transform = getRelativeTransform(node);
    if (transform == null) return false;

    final a = transform[0][0].toDouble();
    final b = transform[0][1].toDouble();

    return b != 0 || a != 1;
  }
}
