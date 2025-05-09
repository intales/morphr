// Copyright (c) 2025 Intales Srl. All rights reserved.
// Use of this source code is governed by a MIT license that can be found
// in the LICENSE file.

import 'package:morphr_figma/morphr_figma.dart' as figma;
import 'package:flutter/material.dart';
import 'package:morphr/mixins/cacheable_mixin.dart';

/// An adapter that provides layout capabilities for Figma nodes.
/// This adapter abstracts the layout properties of various Figma node types
/// that can act as containers (Frame, Component, Instance, etc.).
class FigmaLayoutAdapter with CacheableMixin {
  final figma.Node node;

  FigmaLayoutAdapter(this.node);

  @override
  String getCacheId() => node.id;

  /// Whether the node supports layout capabilities
  bool get supportsLayout {
    return getCached(
      "supportsMixin",
      () =>
          node is figma.Frame ||
          node is figma.Instance ||
          (node is figma.Group && (node as figma.Group).children != null),
    );
  }

  /// The layout mode (horizontal/vertical) of the node
  figma.LayoutMode? get layoutMode {
    return getCached("layoutMode", () {
      if (node is figma.Frame) return (node as figma.Frame).layoutMode;
      if (node is figma.Instance) return (node as figma.Instance).layoutMode;
      return null;
    });
  }

  figma.LayoutWrap? get layoutWrap {
    return getCached("layoutWrap", () {
      if (node is figma.Frame) return (node as figma.Frame).layoutWrap;
      if (node is figma.Instance) return (node as figma.Instance).layoutWrap;
      return null;
    });
  }

  bool get isWrapLayout {
    return getCached(
      "isWrapLayout",
      () => layoutWrap == figma.LayoutWrap.wrap && layoutMode != null,
    );
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

  /// Primary axis sizing mode
  figma.PrimaryAxisSizingMode? get primaryAxisSizingMode {
    return getCached("primaryAxisSizingMode", () {
      if (node is figma.Frame) {
        return (node as figma.Frame).primaryAxisSizingMode;
      }
      if (node is figma.Instance) {
        return (node as figma.Instance).primaryAxisSizingMode;
      }
      return null;
    });
  }

  /// Counter axis sizing mode
  figma.CounterAxisSizingMode? get counterAxisSizingMode {
    return getCached("counterAxisSizingMode", () {
      if (node is figma.Frame) {
        return (node as figma.Frame).counterAxisSizingMode;
      }
      if (node is figma.Instance) {
        return (node as figma.Instance).counterAxisSizingMode;
      }
      return null;
    });
  }

  /// The spacing between children
  double get itemSpacing {
    return getCached("itemSpacing", () {
      if (node is figma.Frame) {
        return (node as figma.Frame).itemSpacing.toDouble();
      }
      if (node is figma.Instance) {
        return (node as figma.Instance).itemSpacing.toDouble();
      }
      return 0.0;
    });
  }

  /// The padding of the container
  EdgeInsets get padding {
    return getCached("padding", () {
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
    });
  }

  /// The children of the container
  List<figma.Node?>? get children {
    return getCached("children", () {
      if (node is figma.Frame) return (node as figma.Frame).children;
      if (node is figma.Instance) return (node as figma.Instance).children;
      if (node is figma.Group) return (node as figma.Group).children;
      return null;
    });
  }

  /// The size constraints of the container
  Size? get size {
    return getCached("size", () {
      final box = _getBoundingBox();
      if (box == null) return null;

      return Size(box.width?.toDouble() ?? 0.0, box.height?.toDouble() ?? 0.0);
    });
  }

  /// Whether the container should hug its content in the primary axis
  bool get shouldHugContentInPrimaryAxis {
    return getCached("shouldHugContentInPrimaryAxis", () {
      return primaryAxisSizingMode == figma.PrimaryAxisSizingMode.auto;
    });
  }

  /// Whether the container should hug its content in the counter axis
  bool get shouldHugContentInCounterAxis {
    return getCached("shouldHugContentInCounterAxis", () {
      return counterAxisSizingMode == figma.CounterAxisSizingMode.auto;
    });
  }

  /// Whether the container should fill available space in the primary axis
  bool get shouldFillInPrimaryAxis {
    return getCached("shouldFillInPrimaryAxis", () {
      return primaryAxisSizingMode == figma.PrimaryAxisSizingMode.fixed;
    });
  }

  /// Whether the container should fill available space in the counter axis
  bool get shouldFillInCounterAxis {
    return getCached("shouldFillInCounterAxis", () {
      return counterAxisSizingMode == figma.CounterAxisSizingMode.fixed;
    });
  }

  /// Creates appropriate main axis size for the layout
  MainAxisSize get mainAxisSize {
    return getCached("mainAxisSize", () {
      if (layoutMode == null) return MainAxisSize.max;
      return shouldHugContentInPrimaryAxis
          ? MainAxisSize.min
          : MainAxisSize.max;
    });
  }

  /// Creates appropriate cross axis alignment for the layout
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

  /// Creates appropriate main axis alignment for the layout
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
