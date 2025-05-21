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

  /// The shape type of the node
  BoxShape get shape {
    if (node is figma.Ellipse) {
      return BoxShape.circle;
    }
    return BoxShape.rectangle;
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

  /// Returns the component's left border width.
  double get leftBorderWidth {
    final strokeWeights = _strokeWeights;
    if (strokeWeights != null) {
      return strokeWeights.left;
    }
    final strokeWeight = _strokeWeight;
    if (strokeWeight != null) {
      return strokeWeight;
    }
    return 0;
  }

  /// Returns the component's right border width.
  double get rightBorderWidth {
    final strokeWeights = _strokeWeights;
    if (strokeWeights != null) {
      return strokeWeights.right;
    }
    final strokeWeight = _strokeWeight;
    if (strokeWeight != null) {
      return strokeWeight;
    }
    return 0;
  }

  /// Returns the component's top border width.
  double get topBorderWidth {
    final strokeWeights = _strokeWeights;
    if (strokeWeights != null) {
      return strokeWeights.top;
    }
    final strokeWeight = _strokeWeight;
    if (strokeWeight != null) {
      return strokeWeight;
    }
    return 0;
  }

  /// Returns the component's bottom border width.
  double get bottomBorderWidth {
    final strokeWeights = _strokeWeights;
    if (strokeWeights != null) {
      return strokeWeights.bottom;
    }
    final strokeWeight = _strokeWeight;
    if (strokeWeight != null) {
      return strokeWeight;
    }
    return 0;
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

  /// Returns the component's [Gradient]s.
  List<Gradient> get gradients {
    final fills = _fills.where(
      (fill) =>
          fill.type == figma.PaintType.gradientLinear ||
          fill.type == figma.PaintType.gradientRadial,
    );
    if (fills.isEmpty) return [];

    final gradients = fills.map(_createGradient).nonNulls.toList();
    if (gradients.isEmpty) return [];

    return gradients;
  }

  /// Creates a [Gradient] from a paint fill.
  Gradient? _createGradient(figma.Paint fill) {
    if (fill.gradientStops == null || fill.gradientStops!.isEmpty) return null;

    final stops = fill.gradientStops!.map((stop) => stop.position!).toList();
    final colors =
        fill.gradientStops!
            .map(
              (stop) => Color.fromRGBO(
                ((stop.color?.r ?? 0) * 255).round(),
                ((stop.color?.g ?? 0) * 255).round(),
                ((stop.color?.b ?? 0) * 255).round(),
                fill.opacity ?? 1,
              ),
            )
            .toList();

    if (fill.type == figma.PaintType.gradientLinear) {
      return _createLinearGradient(fill, colors, stops);
    } else if (fill.type == figma.PaintType.gradientRadial) {
      return _createRadialGradient(fill, colors, stops);
    }

    return null;
  }

  /// Converts a Figma [figma.Paint] to a Flutter [LinearGradient].
  LinearGradient? _createLinearGradient(
    figma.Paint fill,
    List<Color> colors,
    List<double> stops,
  ) {
    if (fill.gradientHandlePositions == null ||
        fill.gradientHandlePositions!.length < 2) {
      return null;
    }

    final handles = fill.gradientHandlePositions!;
    final start = handles[0];
    final end = handles[1];

    return LinearGradient(
      begin: Alignment(start.x * 2 - 1, start.y * 2 - 1),
      end: Alignment(end.x * 2 - 1, end.y * 2 - 1),
      colors: colors,
      stops: stops,
    );
  }

  /// Converts a Figma [figma.Paint] to a Flutter [RadialGradient].
  RadialGradient? _createRadialGradient(
    figma.Paint fill,
    List<Color> colors,
    List<double> stops,
  ) {
    final transforms = fill.imageTransform;
    Alignment center = Alignment.center;
    double radius = 0.75;

    if (transforms != null && transforms.isNotEmpty) {
      try {
        final translateX = transforms[4][0].toDouble();
        final translateY = transforms[5][0].toDouble();
        final scaleX = transforms[0][0].toDouble();
        final scaleY = transforms[3][0].toDouble();

        center = Alignment((translateX * 2.0) - 1.0, (translateY * 2.0) - 1.0);
        radius = (scaleX.abs() + scaleY.abs()) / 2 * 0.7;
      } catch (e) {
        debugPrint('Error processing gradient transform: $e');
      }
    }

    return RadialGradient(
      center: center,
      radius: radius,
      colors: colors,
      stops: stops,
      focal: center,
      focalRadius: 0.0,
    );
  }

  /// Returns the component's font size.
  double? get fontSize {
    if (node is figma.Text) {
      return (node as figma.Text).style?.fontSize?.toDouble();
    }

    return null;
  }

  /// Returns the component's font family.
  String? get fontFamily {
    if (node is figma.Text) {
      return (node as figma.Text).style?.fontFamily;
    }

    return null;
  }

  /// Returns the component's [FontWeight].
  FontWeight? get fontWeight {
    if (this.node is! figma.Text) {
      return null;
    }

    final node = this.node as figma.Text;
    final weight = node.style?.fontWeight?.toInt();
    if (weight == null) return FontWeight.normal;

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

  /// Returns the component's text [FontStyle].
  FontStyle? get fontStyle {
    if (this.node is! figma.Text) {
      return null;
    }

    final node = this.node as figma.Text;
    return switch (node.style?.italic) {
      true => FontStyle.italic,
      _ => FontStyle.normal,
    };
  }

  /// Returns the component's letter spacing.
  double? get letterSpacing {
    if (this.node is! figma.Text) {
      return null;
    }

    final node = this.node as figma.Text;
    return node.style?.letterSpacing?.toDouble();
  }

  /// Returns the component's line height.
  double? get lineHeight {
    if (this.node is! figma.Text) {
      return null;
    }

    final node = this.node as figma.Text;

    final heightPx = node.style?.lineHeightPx;
    final size = node.style?.fontSize;

    if (heightPx == null || size == null || size == 0) return null;
    return heightPx / size;
  }
}
