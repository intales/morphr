import 'package:figma/figma.dart' as figma;
import 'package:flutter/material.dart';

/// Type of navigation bar
enum FigmaBarType {
  top, // AppBar
  bottom // BottomBar
}

/// An adapter that provides navigation bar capabilities for Figma nodes.
/// This adapter handles both top (AppBar) and bottom (BottomBar) navigation bars.
class FigmaBarAdapter {
  final figma.Node node;
  final FigmaBarType barType;

  const FigmaBarAdapter(this.node, this.barType);

  /// Whether the node supports navigation bar capabilities
  bool get supportsBar {
    return node is figma.Frame ||
        (node is figma.Instance && _hasBarProperties(node));
  }

  /// The layout mode of the bar (typically horizontal)
  figma.LayoutMode? get layoutMode {
    if (node is figma.Frame) return (node as figma.Frame).layoutMode;
    if (node is figma.Instance) return (node as figma.Instance).layoutMode;
    return null;
  }

  /// The fill properties of the bar
  List<figma.Paint>? get fills {
    if (node is figma.Frame) return (node as figma.Frame).fills;
    if (node is figma.Instance) return (node as figma.Instance).fills;
    return null;
  }

  /// The stroke properties of the bar
  List<figma.Paint>? get strokes {
    if (node is figma.Frame) return (node as figma.Frame).strokes;
    if (node is figma.Instance) return (node as figma.Instance).strokes;
    return null;
  }

  /// The stroke weight of the bar
  double? get strokeWeight {
    if (node is figma.Frame) {
      return (node as figma.Frame).strokeWeight?.toDouble();
    }
    if (node is figma.Instance) {
      return (node as figma.Instance).strokeWeight?.toDouble();
    }
    return null;
  }

  /// The visual effects applied to the bar
  List<figma.Effect>? get effects {
    if (node is figma.Frame) return (node as figma.Frame).effects;
    if (node is figma.Instance) return (node as figma.Instance).effects;
    return null;
  }

  /// The children of the bar
  List<figma.Node?>? get children {
    if (node is figma.Frame) return (node as figma.Frame).children;
    if (node is figma.Instance) return (node as figma.Instance).children;
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

  /// The height of the bar
  double get height {
    final defaultHeight = barType == FigmaBarType.top
        ? kToolbarHeight
        : kBottomNavigationBarHeight;

    return _getBoundingBox()?.height?.toDouble() ?? defaultHeight;
  }

  /// The total height including system padding
  double getAdjustedHeight(EdgeInsets mediaQueryPadding) {
    final systemPadding = barType == FigmaBarType.top
        ? mediaQueryPadding.top
        : mediaQueryPadding.bottom;

    return height + systemPadding;
  }

  /// Gets the position of the content within the bar
  Positioned getContentPosition({
    required EdgeInsets mediaQueryPadding,
    required Widget child,
  }) {
    if (barType == FigmaBarType.top) {
      return Positioned(
        top: mediaQueryPadding.top,
        left: 0,
        right: 0,
        height: height,
        child: child,
      );
    } else {
      return Positioned(
        bottom: mediaQueryPadding.bottom,
        left: 0,
        right: 0,
        height: height,
        child: child,
      );
    }
  }

  figma.SizeRectangle? _getBoundingBox() {
    if (node is figma.Frame) return (node as figma.Frame).absoluteBoundingBox;
    if (node is figma.Instance) {
      return (node as figma.Instance).absoluteBoundingBox;
    }
    return null;
  }

  /// Checks if a Component or Instance has bar properties
  bool _hasBarProperties(figma.Node node) {
    // A node is a bar when:
    // 1. Has an horizontal layout
    // 2. Has fixed height
    // 3. Has fills or effects
    final hasLayoutMode = layoutMode == figma.LayoutMode.horizontal;
    final hasFixedHeight = _getBoundingBox()?.height != null;
    final hasVisualProperties =
        fills?.isNotEmpty == true || effects?.isNotEmpty == true;

    return hasLayoutMode && hasFixedHeight && hasVisualProperties;
  }

  /// Gets the appropriate alignment for the bar content
  MainAxisAlignment getMainAxisAlignment() {
    return switch (primaryAxisAlignItems) {
      figma.PrimaryAxisAlignItems.min => MainAxisAlignment.start,
      figma.PrimaryAxisAlignItems.center => MainAxisAlignment.center,
      figma.PrimaryAxisAlignItems.max => MainAxisAlignment.end,
      figma.PrimaryAxisAlignItems.spaceBetween =>
        MainAxisAlignment.spaceBetween,
      _ => MainAxisAlignment.start,
    };
  }

  /// Gets the appropriate cross alignment for the bar content
  CrossAxisAlignment getCrossAxisAlignment() {
    return switch (counterAxisAlignItems) {
      figma.CounterAxisAlignItems.min => CrossAxisAlignment.start,
      figma.CounterAxisAlignItems.center => CrossAxisAlignment.center,
      figma.CounterAxisAlignItems.max => CrossAxisAlignment.end,
      figma.CounterAxisAlignItems.baseline => CrossAxisAlignment.baseline,
      _ => CrossAxisAlignment.center,
    };
  }

  /// Validates that the node supports bar capabilities and throws
  /// a descriptive error if it doesn't.
  void validateBar() {
    if (!supportsBar) {
      final barTypeName = barType == FigmaBarType.top ? 'AppBar' : 'BottomBar';
      throw ArgumentError(
        'Node of type ${node.runtimeType} does not support $barTypeName capabilities. '
        'The node must be a Frame or Instance with horizontal layout and fixed height.',
      );
    }
  }
}
