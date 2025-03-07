// Copyright (c) 2025 Intales Srl. All rights reserved.
// Use of this source code is governed by a MIT license that can be found
// in the LICENSE file.

import 'package:figma/figma.dart' as figma;
import 'package:flutter/material.dart';
import 'package:morphr/mixins/cacheable_mixin.dart';

/// Type of navigation bar
enum FigmaBarType {
  top, // AppBar
  bottom // BottomBar
}

/// An adapter that provides navigation bar capabilities for Figma nodes.
class FigmaBarAdapter with CacheableMixin {
  final figma.Node node;
  final FigmaBarType barType;

  const FigmaBarAdapter(this.node, this.barType);

  @override
  String getCacheId() => node.id;

  /// Whether the node supports navigation bar capabilities
  bool get supportsBar {
    return getCached("supportsBar", () {
      return node is figma.Frame ||
          (node is figma.Instance && _hasBarProperties(node));
    });
  }

  /// The layout mode of the bar (typically horizontal)
  figma.LayoutMode? get layoutMode {
    return getCached("layoutMode", () {
      if (node is figma.Frame) return (node as figma.Frame).layoutMode;
      if (node is figma.Instance) return (node as figma.Instance).layoutMode;
      return null;
    });
  }

  /// The fill properties of the bar
  List<figma.Paint>? get fills {
    return getCached("fills", () {
      if (node is figma.Frame) return (node as figma.Frame).fills;
      if (node is figma.Instance) return (node as figma.Instance).fills;
      return null;
    });
  }

  /// The stroke properties of the bar
  List<figma.Paint>? get strokes {
    return getCached("strokes", () {
      if (node is figma.Frame) return (node as figma.Frame).strokes;
      if (node is figma.Instance) return (node as figma.Instance).strokes;
      return null;
    });
  }

  /// The stroke weight of the bar
  double? get strokeWeight {
    return getCached("strokeWeight", () {
      if (node is figma.Frame) {
        return (node as figma.Frame).strokeWeight?.toDouble();
      }
      if (node is figma.Instance) {
        return (node as figma.Instance).strokeWeight?.toDouble();
      }
      return null;
    });
  }

  /// The visual effects applied to the bar
  List<figma.Effect>? get effects {
    return getCached("effects", () {
      if (node is figma.Frame) return (node as figma.Frame).effects;
      if (node is figma.Instance) return (node as figma.Instance).effects;
      return null;
    });
  }

  /// The children of the bar
  List<figma.Node?>? get children {
    return getCached("children", () {
      if (node is figma.Frame) return (node as figma.Frame).children;
      if (node is figma.Instance) return (node as figma.Instance).children;
      return null;
    });
  }

  /// The primary axis alignment of children
  figma.PrimaryAxisAlignItems? get primaryAxisAlignItems {
    return getCached("primaryAxisAlignItems", () {
      if (node is figma.Frame) {
        return (node as figma.Frame).primaryAxisAlignItems;
      }
      if (node is figma.Instance) {
        return (node as figma.Instance).primaryAxisAlignItems;
      }
      return null;
    });
  }

  /// The counter axis alignment of children
  figma.CounterAxisAlignItems? get counterAxisAlignItems {
    return getCached("counterAxisAlignItems", () {
      if (node is figma.Frame) {
        return (node as figma.Frame).counterAxisAlignItems;
      }
      if (node is figma.Instance) {
        return (node as figma.Instance).counterAxisAlignItems;
      }
      return null;
    });
  }

  /// Gets the default height for this type of bar
  double get defaultHeight => getCached(
      "defaultHeight",
      () => barType == FigmaBarType.top
          ? kToolbarHeight
          : kBottomNavigationBarHeight);

  /// Gets the height from Figma design if available
  double? get figmaHeight =>
      getCached("figmaHeight", () => _getBoundingBox()?.height?.toDouble());

  /// Gets the actual height to use for the bar
  double get height {
    return getCached("height", () {
      final designHeight = figmaHeight ?? defaultHeight;
      return designHeight < defaultHeight ? defaultHeight : designHeight;
    });
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
    return getCached("getMainAxisAlignment", () {
      return switch (primaryAxisAlignItems) {
        figma.PrimaryAxisAlignItems.min => MainAxisAlignment.start,
        figma.PrimaryAxisAlignItems.center => MainAxisAlignment.center,
        figma.PrimaryAxisAlignItems.max => MainAxisAlignment.end,
        figma.PrimaryAxisAlignItems.spaceBetween =>
          MainAxisAlignment.spaceBetween,
        _ => MainAxisAlignment.start,
      };
    });
  }

  /// Gets the appropriate cross alignment for the bar content
  CrossAxisAlignment getCrossAxisAlignment() {
    return getCached("getCrossAxisAlignment", () {
      return switch (counterAxisAlignItems) {
        figma.CounterAxisAlignItems.min => CrossAxisAlignment.start,
        figma.CounterAxisAlignItems.center => CrossAxisAlignment.center,
        figma.CounterAxisAlignItems.max => CrossAxisAlignment.end,
        figma.CounterAxisAlignItems.baseline => CrossAxisAlignment.baseline,
        _ => CrossAxisAlignment.center,
      };
    });
  }

  /// Validates that the node supports bar capabilities
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
