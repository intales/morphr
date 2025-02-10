import 'package:figma/figma.dart' as figma;
import 'package:flutter/widgets.dart';

/// Adapter that handles Figma constraints and converts them to Flutter constraints
class FigmaConstraintsAdapter {
  final figma.Node node;
  final Size parentSize;

  const FigmaConstraintsAdapter(this.node, this.parentSize);

  /// Whether the node supports constraints
  bool get supportsConstraints {
    return node is figma.Frame ||
        node is figma.Rectangle ||
        node is figma.Instance ||
        node is figma.Group;
  }

  /// Get the constraints for this node
  figma.LayoutConstraint? get constraints {
    if (node is figma.Frame) return (node as figma.Frame).constraints;
    if (node is figma.Rectangle) return (node as figma.Rectangle).constraints;
    if (node is figma.Instance) return (node as figma.Instance).constraints;
    if (node is figma.Group) return (node as figma.Group).constraints;
    return null;
  }

  /// Get the bounding box for this node
  figma.SizeRectangle? get boundingBox {
    if (node is figma.Frame) {
      return (node as figma.Frame).absoluteBoundingBox;
    }
    if (node is figma.Rectangle) {
      return (node as figma.Rectangle).absoluteBoundingBox;
    }
    if (node is figma.Instance) {
      return (node as figma.Instance).absoluteBoundingBox;
    }
    if (node is figma.Group) {
      return (node as figma.Group).absoluteBoundingBox;
    }
    return null;
  }

  /// Convert Figma constraints to Flutter widget with proper positioning
  Widget applyConstraints(Widget child) {
    if (!supportsConstraints || constraints == null || boundingBox == null) {
      return child;
    }

    final horizontalConstraint = constraints!.horizontal;
    final verticalConstraint = constraints!.vertical;

    // Calculate position and size based on constraints
    final position = _calculatePosition();
    final size = _calculateSize();

    // If we have center constraints, wrap in Center
    if (horizontalConstraint == figma.HorizontalConstraint.center ||
        verticalConstraint == figma.VerticalConstraint.center) {
      child = Center(child: child);
    }

    // If we need specific positioning, wrap in Positioned
    if (position != null) {
      child = Positioned(
        left: position.left,
        top: position.top,
        right: position.right,
        bottom: position.bottom,
        width: size?.width,
        height: size?.height,
        child: child,
      );
    }

    // If we have scale constraints, wrap in FractionallySizedBox
    if (horizontalConstraint == figma.HorizontalConstraint.scale ||
        verticalConstraint == figma.VerticalConstraint.scale) {
      final widthFactor = boundingBox!.width! / parentSize.width;
      final heightFactor = boundingBox!.height! / parentSize.height;

      child = FractionallySizedBox(
        widthFactor: horizontalConstraint == figma.HorizontalConstraint.scale
            ? widthFactor
            : null,
        heightFactor: verticalConstraint == figma.VerticalConstraint.scale
            ? heightFactor
            : null,
        child: child,
      );
    }

    return child;
  }

  /// Calculate position based on constraints
  _PositionConstraints? _calculatePosition() {
    if (constraints == null || boundingBox == null) return null;

    double? left, top, right, bottom;

    // Handle horizontal constraints
    switch (constraints!.horizontal) {
      case figma.HorizontalConstraint.left:
        left = boundingBox!.x!.toDouble();
        break;
      case figma.HorizontalConstraint.right:
        right = parentSize.width - (boundingBox!.x! + boundingBox!.width!);
        break;
      case figma.HorizontalConstraint.leftRight:
        left = boundingBox!.x!.toDouble();
        right = parentSize.width - (boundingBox!.x! + boundingBox!.width!);
        break;
      default:
        break;
    }

    // Handle vertical constraints
    switch (constraints!.vertical) {
      case figma.VerticalConstraint.top:
        top = boundingBox!.y!.toDouble();
        break;
      case figma.VerticalConstraint.bottom:
        bottom = parentSize.height - (boundingBox!.y! + boundingBox!.height!);
        break;
      case figma.VerticalConstraint.topBottom:
        top = boundingBox!.y!.toDouble();
        bottom = parentSize.height - (boundingBox!.y! + boundingBox!.height!);
        break;
      default:
        break;
    }

    if (left == null && right == null && top == null && bottom == null) {
      return null;
    }

    return _PositionConstraints(
      left: left,
      top: top,
      right: right,
      bottom: bottom,
    );
  }

  /// Calculate size based on constraints
  Size? _calculateSize() {
    if (boundingBox == null) return null;

    final horizontal = constraints?.horizontal;
    final vertical = constraints?.vertical;

    // Only set fixed dimensions for non-scaling constraints
    final width = horizontal == figma.HorizontalConstraint.scale
        ? null
        : boundingBox!.width!.toDouble();
    final height = vertical == figma.VerticalConstraint.scale
        ? null
        : boundingBox!.height!.toDouble();

    if (width == null && height == null) return null;
    return Size(width ?? 0, height ?? 0);
  }

  /// Validates that the node supports constraints
  void validateConstraints() {
    if (!supportsConstraints) {
      throw ArgumentError(
        'Node of type ${node.runtimeType} does not support constraints. '
        'The node must be a Frame, Rectangle, Instance, or Group.',
      );
    }
  }
}

/// Helper class to store position constraints
class _PositionConstraints {
  final double? left;
  final double? top;
  final double? right;
  final double? bottom;

  const _PositionConstraints({
    this.left,
    this.top,
    this.right,
    this.bottom,
  });
}
