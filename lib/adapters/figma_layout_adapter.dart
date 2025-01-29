import 'package:figma/figma.dart' as figma;
import 'package:flutter/material.dart';

/// An adapter that provides layout capabilities for Figma nodes.
/// This adapter abstracts the layout properties of various Figma node types
/// that can act as containers (Frame, Component, Instance, etc.).
class FigmaLayoutAdapter {
  final figma.Node node;

  const FigmaLayoutAdapter(this.node);

  /// Whether the node supports layout capabilities
  bool get supportsLayout {
    return node is figma.Frame ||
        node is figma.Instance ||
        (node is figma.Group && (node as figma.Group).children != null);
  }

  /// The layout mode (horizontal/vertical) of the node
  figma.LayoutMode? get layoutMode {
    if (node is figma.Frame) return (node as figma.Frame).layoutMode;
    if (node is figma.Instance) return (node as figma.Instance).layoutMode;
    return null;
  }

  /// The primary axis alignment of children
  figma.PrimaryAxisAlignItems? get primaryAxisAlignItems {
    if (node is figma.Frame) return (node as figma.Frame).primaryAxisAlignItems;
    if (node is figma.Instance) {
      return (node as figma.Instance).primaryAxisAlignItems;
    }
    return null;
  }

  /// The counter axis alignment of children
  figma.CounterAxisAlignItems? get counterAxisAlignItems {
    if (node is figma.Frame) return (node as figma.Frame).counterAxisAlignItems;
    if (node is figma.Instance) {
      return (node as figma.Instance).counterAxisAlignItems;
    }
    return null;
  }

  /// The spacing between children
  double get itemSpacing {
    if (node is figma.Frame) {
      return (node as figma.Frame).itemSpacing.toDouble();
    }
    if (node is figma.Instance) {
      return (node as figma.Instance).itemSpacing.toDouble();
    }
    return 0.0;
  }

  /// The padding of the container
  EdgeInsets get padding {
    if (node is figma.Frame) {
      final frame = node as figma.Frame;
      return EdgeInsets.fromLTRB(
        frame.paddingLeft.toDouble(),
        frame.paddingTop.toDouble(),
        frame.paddingRight.toDouble(),
        frame.paddingBottom.toDouble(),
      );
    }
    if (node is figma.Instance) {
      final instance = node as figma.Instance;
      return EdgeInsets.fromLTRB(
        instance.paddingLeft.toDouble(),
        instance.paddingTop.toDouble(),
        instance.paddingRight.toDouble(),
        instance.paddingBottom.toDouble(),
      );
    }
    return EdgeInsets.zero;
  }

  /// The children of the container
  List<figma.Node?>? get children {
    if (node is figma.Frame) return (node as figma.Frame).children;
    if (node is figma.Instance) return (node as figma.Instance).children;
    if (node is figma.Group) return (node as figma.Group).children;
    return null;
  }

  /// The size constraints of the container
  Size? get size {
    final box = _getBoundingBox();
    if (box == null) return null;

    return Size(
      box.width?.toDouble() ?? 0.0,
      box.height?.toDouble() ?? 0.0,
    );
  }

  figma.SizeRectangle? _getBoundingBox() {
    if (node is figma.Frame) return (node as figma.Frame).absoluteBoundingBox;
    if (node is figma.Instance) {
      return (node as figma.Instance).absoluteBoundingBox;
    }
    if (node is figma.Group) return (node as figma.Group).absoluteBoundingBox;
    return null;
  }

  /// Validates that the node supports layout capabilities and throws
  /// a descriptive error if it doesn't.
  void validateLayout() {
    if (!supportsLayout) {
      throw ArgumentError(
        'Node of type ${node.runtimeType} does not support layout capabilities. '
        'The node must be a Frame, Instance, or Group with children.',
      );
    }
  }
}
