// Copyright (c) 2025 Intales Srl. All rights reserved.
// Use of this source code is governed by a MIT license that can be found
// in the LICENSE file.

import 'package:figma/figma.dart' as figma;
import 'package:flutter/material.dart';

/// An adapter that provides text capabilities for Figma nodes.
/// This adapter handles both direct text nodes and components that can behave as text.
class FigmaTextAdapter {
  final figma.Node node;

  const FigmaTextAdapter(this.node);

  /// Whether the node supports text capabilities
  bool get supportsText {
    return node is figma.Text ||
        (node is figma.Instance && _isTextComponent(node as figma.Instance));
  }

  /// The text style properties
  figma.TypeStyle? get style {
    if (node is figma.Text) return (node as figma.Text).style;
    // Per Component e Instance, potrebbero avere un riferimento a uno stile text
    return null;
  }

  /// The fill properties affecting text color and gradients
  List<figma.Paint>? get fills {
    if (node is figma.Text) return (node as figma.Text).fills;
    if (node is figma.Instance) return (node as figma.Instance).fills;
    return null;
  }

  /// The stroke properties for outlined text
  List<figma.Paint>? get strokes {
    if (node is figma.Text) return (node as figma.Text).strokes;
    if (node is figma.Instance) return (node as figma.Instance).strokes;
    return null;
  }

  /// The stroke weight for outlined text
  double? get strokeWeight {
    if (node is figma.Text) {
      return (node as figma.Text).strokeWeight?.toDouble();
    }
    if (node is figma.Instance) {
      return (node as figma.Instance).strokeWeight?.toDouble();
    }
    return null;
  }

  /// The visual effects applied to the text
  List<figma.Effect>? get effects {
    if (node is figma.Text) return (node as figma.Text).effects;
    if (node is figma.Instance) return (node as figma.Instance).effects;
    return null;
  }

  /// The font size of the text
  double? get fontSize => style?.fontSize?.toDouble();

  /// The font weight of the text
  FontWeight getFontWeight() {
    final weight = style?.fontWeight?.toInt();
    if (weight == null) return FontWeight.normal;

    // Mappa i pesi font di Figma ai FontWeight di Flutter
    return switch (weight) {
      100 => FontWeight.w100,
      200 => FontWeight.w200,
      300 => FontWeight.w300,
      400 => FontWeight.w400,
      500 => FontWeight.w500,
      600 => FontWeight.w600,
      700 => FontWeight.w700,
      800 => FontWeight.w800,
      900 => FontWeight.w900,
      _ => FontWeight.normal,
    };
  }

  /// Whether the text is italic
  bool get isItalic => style?.italic == true;

  /// The letter spacing of the text
  double? get letterSpacing => style?.letterSpacing?.toDouble();

  /// The line height of the text
  double? get lineHeight {
    final heightPx = style?.lineHeightPx;
    final size = style?.fontSize;
    if (heightPx == null || size == null || size == 0) return null;
    return heightPx / size;
  }

  /// The text alignment
  TextAlign getTextAlign() {
    return switch (style?.textAlignHorizontal) {
      figma.TextAlignHorizontal.left => TextAlign.left,
      figma.TextAlignHorizontal.center => TextAlign.center,
      figma.TextAlignHorizontal.right => TextAlign.right,
      figma.TextAlignHorizontal.justified => TextAlign.justify,
      _ => TextAlign.left,
    };
  }

  /// The text decoration (underline, strikethrough)
  TextDecoration? getTextDecoration() {
    return switch (style?.textDecoration) {
      figma.TextDecoration.underline => TextDecoration.underline,
      figma.TextDecoration.strikeThrough => TextDecoration.lineThrough,
      _ => null,
    };
  }

  /// The size of the text box
  Size? get size {
    final box = _getBoundingBox();
    if (box == null) return null;

    return Size(
      box.width?.toDouble() ?? 0.0,
      box.height?.toDouble() ?? 0.0,
    );
  }

  figma.SizeRectangle? _getBoundingBox() {
    if (node is figma.Text) return (node as figma.Text).absoluteBoundingBox;
    if (node is figma.Instance) {
      return (node as figma.Instance).absoluteBoundingBox;
    }
    return null;
  }

  /// Checks if a Component or Instance is meant to be a text component
  bool _isTextComponent(figma.Node node) {
    return node is figma.Text;
  }

  /// Validates that the node supports text capabilities and throws
  /// a descriptive error if it doesn't.
  void validateText() {
    if (!supportsText) {
      throw ArgumentError(
        'Node of type ${node.runtimeType} does not support text capabilities. '
        'The node must be a Text node.',
      );
    }
  }

  /// Creates a Flutter TextStyle from the Figma text properties
  TextStyle? createTextStyle() {
    if (!supportsText) return null;

    return TextStyle(
      fontSize: fontSize,
      fontWeight: getFontWeight(),
      fontStyle: isItalic ? FontStyle.italic : FontStyle.normal,
      letterSpacing: letterSpacing,
      height: lineHeight,
      decoration: getTextDecoration(),
    );
  }
}
