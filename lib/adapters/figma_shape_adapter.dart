// Copyright (c) 2025 Intales Srl. All rights reserved.
// Use of this source code is governed by a MIT license that can be found
// in the LICENSE file.

import 'package:figma/figma.dart' as figma;
import 'package:flutter/material.dart';

/// An adapter that provides shape capabilities for Figma nodes.
/// This adapter handles basic shapes (Rectangle, Ellipse), frames that can
/// behave as shapes, and components that can behave as shapes.
class FigmaShapeAdapter {
  final figma.Node node;

  const FigmaShapeAdapter(this.node);

  /// Whether the node supports shape capabilities
  bool get supportsShape {
    return node is figma.Rectangle ||
        node is figma.Ellipse ||
        node is figma.Instance ||
        node is figma.Frame ||
        (node is figma.Vector && _hasShapeProperties(node as figma.Vector));
  }

  /// The shape type of the node
  BoxShape get shape {
    if (node is figma.Ellipse) {
      return BoxShape.circle;
    }
    if (_isSquare && cornerRadius == null) {
      return BoxShape.circle;
    }
    return BoxShape.rectangle;
  }

  /// The corner radius of the shape (if applicable)
  BorderRadius? get cornerRadius {
    if (node is figma.Rectangle) {
      final radius = (node as figma.Rectangle).cornerRadius?.toDouble() ?? 0.0;
      if (radius <= 0) return null;
      return BorderRadius.circular(radius);
    }
    if (node is figma.Instance) {
      final radius = (node as figma.Instance).cornerRadius?.toDouble() ?? 0.0;
      if (radius <= 0) return null;
      return BorderRadius.circular(radius);
    }
    if (node is figma.Frame) {
      final radius = (node as figma.Frame).cornerRadius?.toDouble() ?? 0.0;
      if (radius <= 0) return null;
      return BorderRadius.circular(radius);
    }
    return null;
  }

  /// The fill properties of the shape
  List<figma.Paint>? get fills {
    if (node is figma.Rectangle) return (node as figma.Rectangle).fills;
    if (node is figma.Ellipse) return (node as figma.Ellipse).fills;
    if (node is figma.Instance) return (node as figma.Instance).fills;
    if (node is figma.Vector) return (node as figma.Vector).fills;
    if (node is figma.Frame) return (node as figma.Frame).fills;
    return null;
  }

  /// The stroke properties of the shape
  List<figma.Paint>? get strokes {
    if (node is figma.Rectangle) return (node as figma.Rectangle).strokes;
    if (node is figma.Ellipse) return (node as figma.Ellipse).strokes;
    if (node is figma.Instance) return (node as figma.Instance).strokes;
    if (node is figma.Vector) return (node as figma.Vector).strokes;
    if (node is figma.Frame) return (node as figma.Frame).strokes;
    return null;
  }

  /// The stroke weight of the shape
  double? get strokeWeight {
    if (node is figma.Rectangle) {
      return (node as figma.Rectangle).strokeWeight?.toDouble();
    }
    if (node is figma.Ellipse) {
      return (node as figma.Ellipse).strokeWeight?.toDouble();
    }
    if (node is figma.Instance) {
      return (node as figma.Instance).strokeWeight?.toDouble();
    }
    if (node is figma.Vector) {
      return (node as figma.Vector).strokeWeight?.toDouble();
    }
    if (node is figma.Frame) {
      return (node as figma.Frame).strokeWeight?.toDouble();
    }
    return null;
  }

  /// The visual effects applied to the shape
  List<figma.Effect>? get effects {
    if (node is figma.Rectangle) return (node as figma.Rectangle).effects;
    if (node is figma.Ellipse) return (node as figma.Ellipse).effects;
    if (node is figma.Instance) return (node as figma.Instance).effects;
    if (node is figma.Vector) return (node as figma.Vector).effects;
    if (node is figma.Frame) return (node as figma.Frame).effects;
    return null;
  }

  /// The size of the shape
  Size? get size {
    final box = _getBoundingBox();
    if (box == null) return null;

    return Size(
      box.width?.toDouble() ?? 0.0,
      box.height?.toDouble() ?? 0.0,
    );
  }

  /// Whether the shape is a square (width equals height)
  bool get _isSquare {
    final currentSize = size;
    if (currentSize == null) return false;
    return currentSize.width == currentSize.height;
  }

  figma.SizeRectangle? _getBoundingBox() {
    if (node is figma.Rectangle) {
      return (node as figma.Rectangle).absoluteBoundingBox;
    }
    if (node is figma.Ellipse) {
      return (node as figma.Ellipse).absoluteBoundingBox;
    }
    if (node is figma.Instance) {
      return (node as figma.Instance).absoluteBoundingBox;
    }
    if (node is figma.Vector) {
      return (node as figma.Vector).absoluteBoundingBox;
    }
    if (node is figma.Frame) {
      return (node as figma.Frame).absoluteBoundingBox;
    }
    return null;
  }

  /// Checks if a Vector node has properties that make it behave like a shape
  bool _hasShapeProperties(figma.Vector vector) {
    return (vector.fills.isNotEmpty == true ||
            vector.strokes.isNotEmpty == true) &&
        vector.fillGeometry.isNotEmpty == true;
  }

  /// Validates that the node supports shape capabilities and throws
  /// a descriptive error if it doesn't.
  void validateShape() {
    if (!supportsShape) {
      throw ArgumentError(
        'Node of type ${node.runtimeType} does not support shape capabilities. '
        'The node must be a Rectangle, Ellipse, Frame with shape properties, '
        'Component, Instance, or Vector with shape properties.',
      );
    }
  }
}
