// Copyright (c) 2025 Intales Srl. All rights reserved.
// Use of this source code is governed by a MIT license that can be found
// in the LICENSE file.

import 'dart:ui' as ui;
import 'package:morphr_figma/morphr_figma.dart' as figma;
import 'package:flutter/material.dart';
import 'package:morphr/mixins/cacheable_mixin.dart';

/// An adapter that provides decoration capabilities for Figma nodes.
/// This adapter centralizes all decorative properties that are common
/// across different types of Figma nodes.
class FigmaDecorationAdapter with CacheableMixin {
  final figma.Node node;

  FigmaDecorationAdapter(this.node);

  @override
  String getCacheId() => node.id;

  /// Whether the node supports decoration capabilities
  bool get supportsDecoration {
    return getCached(
      "supportsDecoration",
      () =>
          _getFills() != null || _getStrokes() != null || _getEffects() != null,
    );
  }

  /// Creates a BoxDecoration from the node's properties
  BoxDecoration createBoxDecoration() {
    return BoxDecoration(
      color: getCached("_getSolidColor", _getSolidColor),
      gradient: getCached("_getGradient", _getGradient),
      border: getCached("_createBorder", _createBorder),
      borderRadius: getCached("_getBorderRadius", _getBorderRadius),
      boxShadow: getCached("_createBoxShadows", _createBoxShadows),
      shape: getCached("_shape", () => _shape),
    );
  }

  /// The shape type of the node
  BoxShape get _shape {
    if (node is figma.Ellipse) {
      return BoxShape.circle;
    }
    return BoxShape.rectangle;
  }

  /// The fill properties of the node
  List<figma.Paint>? _getFills() {
    List<figma.Paint>? fills;
    if (node is figma.Frame) fills = (node as figma.Frame).fills;
    if (node is figma.Rectangle) fills = (node as figma.Rectangle).fills;
    if (node is figma.Ellipse) fills = (node as figma.Ellipse).fills;
    if (node is figma.Vector) fills = (node as figma.Vector).fills;
    if (node is figma.Text) fills = (node as figma.Text).fills;
    if (node is figma.Instance) fills = (node as figma.Instance).fills;
    return fills?.where((fill) => fill.visible).toList();
  }

  /// The stroke properties of the node
  List<figma.Paint>? _getStrokes() {
    List<figma.Paint>? strokes;
    if (node is figma.Frame) strokes = (node as figma.Frame).strokes;
    if (node is figma.Rectangle) strokes = (node as figma.Rectangle).strokes;
    if (node is figma.Ellipse) strokes = (node as figma.Ellipse).strokes;
    if (node is figma.Vector) strokes = (node as figma.Vector).strokes;
    if (node is figma.Text) strokes = (node as figma.Text).strokes;
    if (node is figma.Instance) strokes = (node as figma.Instance).strokes;
    return strokes?.where((stroke) => stroke.visible).toList();
  }

  /// The visual effects of the node
  List<figma.Effect>? _getEffects() {
    List<figma.Effect>? effects;
    if (node is figma.Frame) effects = (node as figma.Frame).effects;
    if (node is figma.Rectangle) effects = (node as figma.Rectangle).effects;
    if (node is figma.Ellipse) effects = (node as figma.Ellipse).effects;
    if (node is figma.Vector) effects = (node as figma.Vector).effects;
    if (node is figma.Text) effects = (node as figma.Text).effects;
    if (node is figma.Instance) effects = (node as figma.Instance).effects;
    return effects?.where((effect) => effect.visible).toList();
  }

  /// The stroke weight of the node
  double? _getStrokeWeight() {
    if (node is figma.Frame) {
      return (node as figma.Frame).strokeWeight?.toDouble();
    }
    if (node is figma.Rectangle) {
      return (node as figma.Rectangle).strokeWeight?.toDouble();
    }
    if (node is figma.Ellipse) {
      return (node as figma.Ellipse).strokeWeight?.toDouble();
    }
    if (node is figma.Vector) {
      return (node as figma.Vector).strokeWeight?.toDouble();
    }
    if (node is figma.Text) {
      return (node as figma.Text).strokeWeight?.toDouble();
    }
    if (node is figma.Instance) {
      return (node as figma.Instance).strokeWeight?.toDouble();
    }
    return null;
  }

  /// Gets the corner radius if applicable
  BorderRadius? _getBorderRadius() {
    double? radius;

    if (node is figma.Rectangle) {
      radius = (node as figma.Rectangle).cornerRadius?.toDouble();
    } else if (node is figma.Instance) {
      radius = (node as figma.Instance).cornerRadius?.toDouble();
    } else if (node is figma.Frame) {
      radius = (node as figma.Frame).cornerRadius?.toDouble();
    }

    if (radius != null && radius > 0) {
      return BorderRadius.circular(radius);
    }
    return null;
  }

  /// Creates solid color from fills
  Color? _getSolidColor() {
    final fills = _getFills();
    if (fills == null || fills.isEmpty) return null;

    if (_hasGradient()) return null;

    final solidFill = fills.firstWhere(
      (fill) => fill.type == figma.PaintType.solid,
      orElse: () => fills.first,
    );

    if (solidFill.type != figma.PaintType.solid) return null;

    final color = solidFill.color;
    if (color == null) return null;

    return Color.fromRGBO(
      ((color.r ?? 0) * 255).round(),
      ((color.g ?? 0) * 255).round(),
      ((color.b ?? 0) * 255).round(),
      solidFill.opacity ?? 1,
    );
  }

  /// Creates gradient from fills if present
  Gradient? _getGradient() {
    if (!_hasGradient()) return null;

    final fills = _getFills();
    if (fills == null) return null;

    final gradientFill = fills.firstWhere(
      (f) =>
          f.type == figma.PaintType.gradientLinear ||
          f.type == figma.PaintType.gradientRadial,
    );

    return _createGradient(gradientFill);
  }

  bool _hasGradient() {
    final fills = _getFills();
    return fills?.any(
          (f) =>
              f.type == figma.PaintType.gradientLinear ||
              f.type == figma.PaintType.gradientRadial,
        ) ??
        false;
  }

  /// Creates a gradient from a paint fill
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

  /// Creates border from strokes
  Border? _createBorder() {
    final strokes = _getStrokes();
    if (strokes == null || strokes.isEmpty) return null;

    final strokeWeight = _getStrokeWeight() ?? 1.0;
    final strokeColor = _getStrokeColor();

    return Border.all(
      color: strokeColor ?? Colors.transparent,
      width: strokeWeight,
    );
  }

  Color? _getStrokeColor() {
    final strokes = _getStrokes();
    if (strokes == null || strokes.isEmpty) return null;

    final stroke = strokes.first;
    if (stroke.type != figma.PaintType.solid) return null;

    final color = stroke.color;
    if (color == null) return null;

    return Color.fromRGBO(
      ((color.r ?? 0) * 255).round(),
      ((color.g ?? 0) * 255).round(),
      ((color.b ?? 0) * 255).round(),
      stroke.opacity ?? 1,
    );
  }

  /// Creates box shadows from effects
  List<BoxShadow>? _createBoxShadows() {
    final effects = _getEffects();
    if (effects == null || effects.isEmpty) return null;

    final shadows = <BoxShadow>[];

    for (final effect in effects) {
      if (effect.type == figma.EffectType.dropShadow ||
          effect.type == figma.EffectType.innerShadow) {
        shadows.add(
          BoxShadow(
            color: Color.fromRGBO(
              ((effect.color?.r ?? 0) * 255).round(),
              ((effect.color?.g ?? 0) * 255).round(),
              ((effect.color?.b ?? 0) * 255).round(),
              effect.color?.a ?? 1,
            ),
            offset: Offset(
              effect.offset?.x.toDouble() ?? 0,
              effect.offset?.y.toDouble() ?? 0,
            ),
            blurRadius: effect.radius?.toDouble() ?? 0,
            spreadRadius: effect.spread?.toDouble() ?? 0,
            blurStyle:
                effect.type == figma.EffectType.innerShadow
                    ? BlurStyle.inner
                    : BlurStyle.normal,
          ),
        );
      }
    }

    return shadows.isEmpty ? null : shadows;
  }

  /// Creates a widget wrapped with appropriate blur effects
  Widget wrapWithBlurEffects(Widget child) {
    final effects = _getEffects();
    if (effects == null || effects.isEmpty) return child;

    Widget result = child;

    for (final effect in effects) {
      if (effect.type == figma.EffectType.layerBlur) {
        result = ImageFiltered(
          imageFilter: ui.ImageFilter.blur(
            sigmaX: effect.radius?.toDouble() ?? 0,
            sigmaY: effect.radius?.toDouble() ?? 0,
          ),
          child: result,
        );
      } else if (effect.type == figma.EffectType.backgroundBlur) {
        result = BackdropFilter(
          filter: ui.ImageFilter.blur(
            sigmaX: effect.radius?.toDouble() ?? 0,
            sigmaY: effect.radius?.toDouble() ?? 0,
          ),
          child: result,
        );
      }
    }

    return result;
  }

  /// Validates that the node supports decoration capabilities
  void validateDecoration() {
    if (!supportsDecoration) {
      throw ArgumentError(
        'Node of type ${node.runtimeType} does not support decoration capabilities. '
        'The node must have fills, strokes, or effects properties.',
      );
    }
  }
}
