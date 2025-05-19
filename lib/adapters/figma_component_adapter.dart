// Copyright (c) 2025 Intales Srl. All rights reserved.
// Use of this source code is governed by a MIT license that can be found
// in the LICENSE file.

import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:morphr_figma/morphr_figma.dart' as figma;

/// A class that adapts a Figma component node to a more usable format.
class FigmaComponentAdapter {
  /// The Figma node representing the component.
  final figma.Node node;

  /// Creates an instance of [FigmaComponentAdapter].
  const FigmaComponentAdapter(this.node);

  /// Returns the component ID.
  String get id => node.id;

  /// Returns the component name.
  String get name => node.name!;

  /// Returns the component type.
  String get type => node.type!;

  /// Returns [true] when the component is visible.
  bool get isVisible => node.visible;

  /// Returns the component's size.
  Size get size {
    final boundingBox = _boundingBox;
    if (boundingBox != null) {
      return Size(boundingBox.width ?? 0, boundingBox.height ?? 0);
    }
    return Size.zero;
  }

  /// Returns the component's bounding box.
  figma.SizeRectangle? get _boundingBox {
    figma.SizeRectangle? boundingBox;
    if (node is figma.Frame) {
      boundingBox = (node as figma.Frame).absoluteBoundingBox;
    }
    if (node is figma.Rectangle) {
      boundingBox = (node as figma.Rectangle).absoluteBoundingBox;
    }
    if (node is figma.Ellipse) {
      boundingBox = (node as figma.Ellipse).absoluteBoundingBox;
    }
    if (node is figma.Vector) {
      boundingBox = (node as figma.Vector).absoluteBoundingBox;
    }
    if (node is figma.Text) {
      boundingBox = (node as figma.Text).absoluteBoundingBox;
    }
    if (node is figma.Instance) {
      boundingBox = (node as figma.Instance).absoluteBoundingBox;
    }
    return boundingBox;
  }

  /// Returns a list of [Color]s representing the component's fills.
  List<Color> get colors => _fills.map(_paintToColor).toList();

  /// Returns a list of [figma.Paint] objects representing the component's fills.
  List<figma.Paint> get _fills {
    List<figma.Paint>? fills;
    if (node is figma.Frame) fills = (node as figma.Frame).fills;
    if (node is figma.Rectangle) fills = (node as figma.Rectangle).fills;
    if (node is figma.Ellipse) fills = (node as figma.Ellipse).fills;
    if (node is figma.Vector) fills = (node as figma.Vector).fills;
    if (node is figma.Text) fills = (node as figma.Text).fills;
    if (node is figma.Instance) fills = (node as figma.Instance).fills;
    return fills?.where((fill) => fill.visible).toList() ?? [];
  }

  /// Converts a Figma [figma.Paint] to a Flutter [Color].
  Color _paintToColor(figma.Paint paint) => Color.fromRGBO(
    ((paint.color?.r ?? 0) * 255).round(),
    ((paint.color?.g ?? 0) * 255).round(),
    ((paint.color?.b ?? 0) * 255).round(),
    paint.opacity ?? 1,
  );

  /// Returns the [BorderRadius] of the component.
  BorderRadius get borderRadius {
    final cornerRadius = _cornerRadius;
    if ((cornerRadius ?? 0) > 0) {
      return BorderRadius.circular(cornerRadius!);
    }

    final cornerRadii = _cornerRadii;
    if (cornerRadii != null && cornerRadii.isNotEmpty) {
      return BorderRadius.only(
        topLeft: Radius.circular(cornerRadii[0]),
        topRight: Radius.circular(cornerRadii[1]),
        bottomLeft: Radius.circular(cornerRadii[2]),
        bottomRight: Radius.circular(cornerRadii[3]),
      );
    }

    return BorderRadius.zero;
  }

  /// Returns the component's corner radius.
  double? get _cornerRadius {
    double? borderRadius;
    if (node is figma.Frame) borderRadius = (node as figma.Frame).cornerRadius;
    if (node is figma.Rectangle) {
      borderRadius = (node as figma.Rectangle).cornerRadius;
    }
    if (node is figma.Instance) {
      borderRadius = (node as figma.Instance).cornerRadius;
    }
    return borderRadius;
  }

  /// Returns the component's corner radii.
  List<double>? get _cornerRadii {
    List<double>? borderRadius;
    if (node is figma.Frame) {
      borderRadius = (node as figma.Frame).rectangleCornerRadii;
    }
    if (node is figma.Rectangle) {
      borderRadius = (node as figma.Rectangle).rectangleCornerRadii;
    }
    if (node is figma.Instance) {
      borderRadius = (node as figma.Instance).rectangleCornerRadii;
    }
    return borderRadius;
  }

  /// Returns the opacity of the component.
  double get opacity {
    double opacity = 1;
    if (node is figma.Frame) opacity = (node as figma.Frame).opacity;
    if (node is figma.Rectangle) opacity = (node as figma.Rectangle).opacity;
    if (node is figma.Ellipse) opacity = (node as figma.Ellipse).opacity;
    if (node is figma.Vector) opacity = (node as figma.Vector).opacity;
    if (node is figma.Text) opacity = (node as figma.Text).opacity;
    if (node is figma.Instance) opacity = (node as figma.Instance).opacity;
    return opacity;
  }

  /// Returns the component's padding.
  EdgeInsets get padding {
    final padding = _padding;
    if (padding != null) {
      return EdgeInsets.only(
        left: padding[0],
        top: padding[1],
        right: padding[2],
        bottom: padding[3],
      );
    }
    return EdgeInsets.zero;
  }

  /// Returns the component's padding values.
  List<double>? get _padding {
    List<double>? padding;
    if (node is figma.Frame) {
      padding = [];
      padding.add((node as figma.Frame).paddingLeft);
      padding.add((node as figma.Frame).paddingTop);
      padding.add((node as figma.Frame).paddingRight);
      padding.add((node as figma.Frame).paddingBottom);
    }
    if (node is figma.Instance) {
      padding = [];
      padding.add((node as figma.Instance).paddingLeft);
      padding.add((node as figma.Instance).paddingTop);
      padding.add((node as figma.Instance).paddingRight);
      padding.add((node as figma.Instance).paddingBottom);
    }
    return padding;
  }

  /// Returns a list of [Color]s representing the component's strokes.
  List<Color> get strokes => _strokes.map(_paintToColor).toList();

  /// Returns the component's strokes.
  List<figma.Paint> get _strokes {
    List<figma.Paint>? strokes;
    if (node is figma.Frame) strokes = (node as figma.Frame).strokes;
    if (node is figma.Rectangle) strokes = (node as figma.Rectangle).strokes;
    if (node is figma.Ellipse) strokes = (node as figma.Ellipse).strokes;
    if (node is figma.Vector) strokes = (node as figma.Vector).strokes;
    if (node is figma.Text) strokes = (node as figma.Text).strokes;
    if (node is figma.Instance) strokes = (node as figma.Instance).strokes;
    return strokes?.where((stroke) => stroke.visible).toList() ?? [];
  }

  /// Returns the component's stroke alignment.
  double get strokeAlignment {
    final strokeAlign = _strokeAlign;
    return switch (strokeAlign) {
      figma.StrokeAlign.inside => -1,
      figma.StrokeAlign.outside => 1,
      _ => 0,
    };
  }

  /// Returns the stroke alignment of the component.
  figma.StrokeAlign? get _strokeAlign {
    figma.StrokeAlign? strokeAlign;
    if (node is figma.Frame) strokeAlign = (node as figma.Frame).strokeAlign;
    if (node is figma.Rectangle) {
      strokeAlign = (node as figma.Rectangle).strokeAlign;
    }
    if (node is figma.Ellipse) {
      strokeAlign = (node as figma.Ellipse).strokeAlign;
    }
    if (node is figma.Vector) strokeAlign = (node as figma.Vector).strokeAlign;
    if (node is figma.Text) strokeAlign = (node as figma.Text).strokeAlign;
    if (node is figma.Instance) {
      strokeAlign = (node as figma.Instance).strokeAlign;
    }
    return strokeAlign;
  }

  /// Returns the [Border] of the component.
  Border? get border {
    final strokeWeights = _strokeWeights;
    if (strokeWeights == null) {
      final strokeWeight = _strokeWeight;
      if (strokeWeight == null) return null;

      return Border.all(width: strokeWeight, color: strokes.first);
    }

    final color = strokes.first;
    return Border(
      top: BorderSide(width: strokeWeights.top, color: color),
      right: BorderSide(width: strokeWeights.right, color: color),
      bottom: BorderSide(width: strokeWeights.bottom, color: color),
      left: BorderSide(width: strokeWeights.left, color: color),
    );
  }

  /// Returns the component's stroke weight.
  double? get _strokeWeight {
    double? strokeWeight;
    if (node is figma.Frame) {
      strokeWeight = (node as figma.Frame).strokeWeight;
    }
    if (node is figma.Rectangle) {
      strokeWeight = (node as figma.Rectangle).strokeWeight;
    }
    if (node is figma.Ellipse) {
      strokeWeight = (node as figma.Ellipse).strokeWeight;
    }
    if (node is figma.Vector) {
      strokeWeight = (node as figma.Vector).strokeWeight;
    }
    if (node is figma.Text) {
      strokeWeight = (node as figma.Text).strokeWeight;
    }
    if (node is figma.Instance) {
      strokeWeight = (node as figma.Instance).strokeWeight;
    }
    return strokeWeight;
  }

  /// Returns the component's individual stroke weights.
  figma.StrokeWeights? get _strokeWeights {
    figma.StrokeWeights? strokeWeights;
    if (node is figma.Frame) {
      strokeWeights = (node as figma.Frame).individualStrokeWeights;
    }
    if (node is figma.Rectangle) {
      strokeWeights = (node as figma.Rectangle).individualStrokeWeights;
    }
    if (node is figma.Ellipse) {
      strokeWeights = (node as figma.Ellipse).individualStrokeWeights;
    }
    if (node is figma.Vector) {
      strokeWeights = (node as figma.Vector).individualStrokeWeights;
    }
    if (node is figma.Text) {
      strokeWeights = (node as figma.Text).individualStrokeWeights;
    }
    if (node is figma.Instance) {
      strokeWeights = (node as figma.Instance).individualStrokeWeights;
    }
    return strokeWeights;
  }

  /// Returns the component's [BoxShadow]s.
  List<BoxShadow> get shadows {
    final dropShadows = _dropShadows;
    final innerShadows = _innerShadows;
    return [...dropShadows, ...innerShadows];
  }

  /// Returns the component's outer shadows.
  List<BoxShadow> get _dropShadows {
    final shadows = _effects.where(
      (effect) => effect.type == figma.EffectType.dropShadow,
    );
    return shadows.map((effect) {
      return BoxShadow(
        color: Color.fromRGBO(
          ((effect.color?.r ?? 0) * 255).round(),
          ((effect.color?.g ?? 0) * 255).round(),
          ((effect.color?.b ?? 0) * 255).round(),
          1,
        ),
        offset: Offset(
          effect.offset?.x.toDouble() ?? 0,
          effect.offset?.y.toDouble() ?? 0,
        ),
        blurRadius: effect.radius?.toDouble() ?? 0,
        spreadRadius: (effect.spread?.toDouble() ?? 0),
      );
    }).toList();
  }

  /// Returns the component's inner shadows.
  List<BoxShadow> get _innerShadows {
    final shadows = _effects.where(
      (effect) => effect.type == figma.EffectType.innerShadow,
    );
    return shadows.map((effect) {
      return BoxShadow(
        color: Color.fromRGBO(
          ((effect.color?.r ?? 0) * 255).round(),
          ((effect.color?.g ?? 0) * 255).round(),
          ((effect.color?.b ?? 0) * 255).round(),
          1,
        ),
        offset: Offset(
          effect.offset?.x.toDouble() ?? 0,
          effect.offset?.y.toDouble() ?? 0,
        ),
        blurRadius: effect.radius?.toDouble() ?? 0,
        spreadRadius: (effect.spread?.toDouble() ?? 0) * -1,
      );
    }).toList();
  }

  List<ImageFilter> get imageFilters {
    final filters = _effects.where(
      (effect) =>
          effect.type == figma.EffectType.layerBlur ||
          effect.type == figma.EffectType.backgroundBlur,
    );

    return filters.map((effect) {
      return ImageFilter.blur(
        sigmaX: effect.radius?.toDouble() ?? 0,
        sigmaY: effect.radius?.toDouble() ?? 0,
      );
    }).toList();
  }

  /// Returns the component's effects.
  List<figma.Effect> get _effects {
    List<figma.Effect>? effects;
    if (node is figma.Frame) effects = (node as figma.Frame).effects;
    if (node is figma.Rectangle) effects = (node as figma.Rectangle).effects;
    if (node is figma.Ellipse) effects = (node as figma.Ellipse).effects;
    if (node is figma.Vector) effects = (node as figma.Vector).effects;
    if (node is figma.Text) effects = (node as figma.Text).effects;
    if (node is figma.Instance) effects = (node as figma.Instance).effects;
    return effects ?? [];
  }
}
