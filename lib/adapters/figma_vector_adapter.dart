// Copyright (c) 2025 Intales Srl. All rights reserved.
// Use of this source code is governed by a MIT license that can be found
// in the LICENSE file.

import 'dart:math' as math;
import 'package:morphr_figma/morphr_figma.dart' as figma;
import 'package:flutter/material.dart';

/// An adapter that provides vector capabilities for Figma nodes.
/// This adapter handles both vector nodes and components that can behave as vectors.
class FigmaVectorAdapter {
  final figma.Node node;

  const FigmaVectorAdapter(this.node);

  /// Whether the node supports vector capabilities
  bool get supportsVector {
    return node is figma.Vector;
  }

  /// The fill geometry of the vector
  List<figma.Path>? get fillGeometry {
    if (node is figma.Vector) return (node as figma.Vector).fillGeometry;
    return null;
  }

  /// The stroke geometry of the vector
  List<Map<String, dynamic>>? get strokeGeometry {
    if (node is figma.Vector) {
      final geometry = (node as figma.Vector).strokeGeometry;
      if (geometry == null) return null;
      return _convertStrokeGeometry(geometry);
    }
    return null;
  }

  /// The fill properties of the vector
  List<figma.Paint>? get fills {
    if (node is figma.Vector) return (node as figma.Vector).fills;
    return null;
  }

  /// The stroke properties of the vector
  List<figma.Paint>? get strokes {
    if (node is figma.Vector) return (node as figma.Vector).strokes;
    return null;
  }

  /// The stroke weight of the vector
  double? get strokeWeight {
    if (node is figma.Vector) {
      return (node as figma.Vector).strokeWeight?.toDouble();
    }
    return null;
  }

  /// The visual effects applied to the vector
  List<figma.Effect>? get effects {
    if (node is figma.Vector) return (node as figma.Vector).effects;
    return null;
  }

  /// The size of the vector
  Size get size {
    final box = _getBoundingBox();
    if (box == null) return Size.zero;

    return Size(box.width?.toDouble() ?? 0.0, box.height?.toDouble() ?? 0.0);
  }

  /// The extra padding needed for shadows
  EdgeInsets get shadowPadding {
    if (effects == null || effects!.isEmpty) return EdgeInsets.zero;

    var left = 0.0;
    var top = 0.0;
    var right = 0.0;
    var bottom = 0.0;

    for (final effect in effects!) {
      if (effect.type == figma.EffectType.dropShadow) {
        final blurRadius = effect.radius?.toDouble() ?? 0;
        final offsetX = effect.offset?.x.toDouble() ?? 0;
        final offsetY = effect.offset?.y.toDouble() ?? 0;

        left = math.max(left, blurRadius - math.min(offsetX, 0));
        top = math.max(top, blurRadius - math.min(offsetY, 0));
        right = math.max(right, blurRadius + math.max(offsetX, 0));
        bottom = math.max(bottom, blurRadius + math.max(offsetY, 0));
      }
    }

    return EdgeInsets.fromLTRB(left, top, right, bottom);
  }

  figma.SizeRectangle? _getBoundingBox() {
    if (node is figma.Vector) return (node as figma.Vector).absoluteBoundingBox;
    return null;
  }

  /// Converts stroke geometry to a consistent format
  List<Map<String, dynamic>> _convertStrokeGeometry(List<dynamic> geometry) {
    return geometry.map((item) {
      if (item is Map<String, dynamic>) {
        return item;
      }
      return Map<String, dynamic>.from(item as dynamic);
    }).toList();
  }

  /// Gets the path data for painting
  List<String> getFillPaths() {
    final paths = <String>[];
    if (fillGeometry != null) {
      for (final pathData in fillGeometry!) {
        paths.add(pathData.path);
      }
    }
    return paths;
  }

  List<String> getStrokePaths() {
    final paths = <String>[];
    if (strokeGeometry != null) {
      for (final pathData in strokeGeometry!) {
        final pathStr = pathData['path'] as String?;
        if (pathStr != null) {
          paths.add(pathStr);
        }
      }
    }
    return paths;
  }

  /// Validates that the node supports vector capabilities and throws
  /// a descriptive error if it doesn't.
  void validateVector() {
    if (!supportsVector) {
      throw ArgumentError(
        'Node of type ${node.runtimeType} does not support vector capabilities. '
        'The node must be a Vector.',
      );
    }
  }
}
