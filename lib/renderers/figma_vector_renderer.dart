// Copyright (c) 2025 Intales Srl. All rights reserved.
// Use of this source code is governed by a MIT license that can be found
// in the LICENSE file.

import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:figma/figma.dart' as figma;
import 'package:morphr/adapters/figma_constraints_adapter.dart';
import 'package:path_parsing/path_parsing.dart';

class FigmaVectorRenderer {
  const FigmaVectorRenderer();

  Widget render({
    required final figma.Node node,
    required final Size parentSize,
  }) {
    if (node is! figma.Vector) {
      throw ArgumentError('Node must be a VECTOR node');
    }
    final constraintsAdapter = FigmaConstraintsAdapter(node, parentSize);
    final shadowPadding = _calculateShadowPadding(node);

    final baseWidth = _getWidth(node);
    final baseHeight = _getHeight(node);

    if (baseWidth == null || baseHeight == null) {
      return const SizedBox.shrink();
    }

    final width = baseWidth + shadowPadding.left + shadowPadding.right;
    final height = baseHeight + shadowPadding.top + shadowPadding.bottom;

    final result = CustomPaint(
      size: Size(width, height),
      painter: _VectorPainter(
        fills: _getFills(node),
        strokes: _getStrokes(node),
        strokeWeight: _getStrokeWeight(node),
        fillGeometry: _getFillGeometry(node),
        strokeGeometry: _getStrokeGeometry(node),
        effects: _getEffects(node),
        shadowPadding: shadowPadding,
      ),
    );

    return constraintsAdapter.applyConstraints(result);
  }

  EdgeInsets _calculateShadowPadding(figma.Node node) {
    if (node is! figma.Vector) return EdgeInsets.zero;

    var left = 0.0;
    var top = 0.0;
    var right = 0.0;
    var bottom = 0.0;

    final effects = node.effects;
    if (effects != null) {
      for (final effect in effects) {
        if (effect.type == figma.EffectType.dropShadow) {
          final blurRadius = effect.radius ?? 0;
          final offsetX = effect.offset?.x ?? 0;
          final offsetY = effect.offset?.y ?? 0;

          left = math.max(left, blurRadius - math.min(offsetX.toDouble(), 0));
          top = math.max(top, blurRadius - math.min(offsetY.toDouble(), 0));
          right = math.max(right, blurRadius + math.max(offsetX.toDouble(), 0));
          bottom =
              math.max(bottom, blurRadius + math.max(offsetY.toDouble(), 0));
        }
      }
    }

    return EdgeInsets.fromLTRB(left, top, right, bottom);
  }

  List<figma.Paint>? _getFills(figma.Node node) {
    return node is figma.Vector ? node.fills : null;
  }

  List<figma.Paint>? _getStrokes(figma.Node node) {
    return node is figma.Vector ? node.strokes : null;
  }

  double? _getStrokeWeight(figma.Node node) {
    return node is figma.Vector ? node.strokeWeight?.toDouble() : null;
  }

  List<figma.Effect>? _getEffects(figma.Node node) {
    return node is figma.Vector ? node.effects : null;
  }

  double? _getWidth(figma.Node node) {
    return node is figma.Vector
        ? node.absoluteBoundingBox?.width?.toDouble()
        : null;
  }

  double? _getHeight(figma.Node node) {
    return node is figma.Vector
        ? node.absoluteBoundingBox?.height?.toDouble()
        : null;
  }

  List<figma.Path>? _getFillGeometry(figma.Node node) {
    return node is figma.Vector ? node.fillGeometry : null;
  }

  List<Map<String, dynamic>>? _getStrokeGeometry(figma.Node node) {
    if (node is! figma.Vector) return null;
    final geometry = node.strokeGeometry;
    if (geometry == null) return null;

    return geometry.map((item) {
      if (item is Map<String, dynamic>) {
        return item;
      }
      return Map<String, dynamic>.from(item as dynamic);
    }).toList();
  }
}

class _VectorPainter extends CustomPainter {
  final List<figma.Paint>? fills;
  final List<figma.Paint>? strokes;
  final double? strokeWeight;
  final List<figma.Path>? fillGeometry;
  final List<Map<String, dynamic>>? strokeGeometry;
  final List<figma.Effect>? effects;
  final EdgeInsets shadowPadding;

  _VectorPainter({
    this.fills,
    this.strokes,
    this.strokeWeight,
    this.fillGeometry,
    this.strokeGeometry,
    this.effects,
    this.shadowPadding = EdgeInsets.zero,
  });

  @override
  void paint(Canvas canvas, Size size) {
    canvas.translate(shadowPadding.left, shadowPadding.top);
    final paths = <Path>[];

    if (fillGeometry != null) {
      for (final pathData in fillGeometry!) {
        paths.add(_parseSvgPath(pathData.path));
      }
    }

    if (strokeGeometry != null) {
      for (final pathData in strokeGeometry!) {
        final pathStr = pathData['path'] as String?;
        if (pathStr != null) {
          paths.add(_parseSvgPath(pathStr));
        }
      }
    }

    if (paths.isEmpty) return;

    final Path combinedPath = Path();
    for (final path in paths) {
      combinedPath.addPath(path, Offset.zero);
    }

    if (effects != null) {
      for (final effect in effects!) {
        if (effect.type == figma.EffectType.dropShadow) {
          canvas.saveLayer(Offset.zero & size, Paint());

          final shadowPaint = Paint()
            ..color = _createColorFromEffect(effect)
            ..maskFilter = MaskFilter.blur(
              BlurStyle.normal,
              effect.radius?.toDouble() ?? 0,
            );

          final offset = Offset(
            effect.offset?.x.toDouble() ?? 0,
            effect.offset?.y.toDouble() ?? 0,
          );

          for (final path in paths) {
            final shadowPath = path.shift(offset);
            canvas.drawPath(shadowPath, shadowPaint);
          }

          canvas.save();
          canvas.clipPath(combinedPath);
          canvas.drawRect(
            combinedPath.getBounds(),
            Paint()..blendMode = BlendMode.clear,
          );
          canvas.restore();

          canvas.restore();
        }
      }
    }

    if (fills != null && fills!.isNotEmpty) {
      for (final fill in fills!) {
        final paint = Paint()..style = PaintingStyle.fill;

        if (fill.type == figma.PaintType.solid) {
          paint.color = _createColor([fill]);
        } else if (fill.type == figma.PaintType.gradientLinear ||
            fill.type == figma.PaintType.gradientRadial) {
          final gradient = _createGradient(fill);
          if (gradient != null) {
            for (final path in paths) {
              paint.shader = gradient.createShader(path.getBounds());
            }
          }
        }

        for (final path in paths) {
          canvas.drawPath(path, paint);
        }
      }
    }

    if (strokes != null) {
      for (final stroke in strokes!) {
        final paint = Paint()
          ..style = PaintingStyle.stroke
          ..strokeWidth = strokeWeight ?? 1.0;

        if (stroke.type == figma.PaintType.solid) {
          paint.color = _createColor([stroke]);
        } else if (stroke.type == figma.PaintType.gradientLinear ||
            stroke.type == figma.PaintType.gradientRadial) {
          final gradient = _createGradient(stroke);
          if (gradient != null) {
            for (final path in paths) {
              paint.shader = gradient.createShader(path.getBounds());
            }
          }
        }

        for (final path in paths) {
          canvas.drawPath(path, paint);
        }
      }
    }
  }

  Color _createColor(List<figma.Paint>? paints) {
    if (paints == null || paints.isEmpty) return Colors.black;

    final paint = paints.firstWhere(
      (p) => p.type == figma.PaintType.solid,
      orElse: () => paints.first,
    );

    if (paint.type != figma.PaintType.solid) return Colors.black;

    final color = paint.color;
    if (color == null) return Colors.black;

    return Color.fromRGBO(
      ((color.r ?? 0) * 255).round(),
      ((color.g ?? 0) * 255).round(),
      ((color.b ?? 0) * 255).round(),
      paint.opacity ?? 1,
    );
  }

  Color _createColorFromEffect(figma.Effect effect) {
    final color = effect.color;
    if (color == null) return Colors.black;

    return Color.fromRGBO(
      ((color.r ?? 0) * 255).round(),
      ((color.g ?? 0) * 255).round(),
      ((color.b ?? 0) * 255).round(),
      color.a ?? 1,
    );
  }

  Gradient? _createGradient(figma.Paint fill) {
    if (fill.gradientStops == null || fill.gradientStops!.isEmpty) return null;

    final stops = fill.gradientStops!.map((stop) => stop.position!).toList();
    final colors = fill.gradientStops!
        .map((stop) => Color.fromRGBO(
              ((stop.color?.r ?? 0) * 255).round(),
              ((stop.color?.g ?? 0) * 255).round(),
              ((stop.color?.b ?? 0) * 255).round(),
              fill.opacity ?? 1,
            ))
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

        center = Alignment(
          (translateX * 2.0) - 1.0,
          (translateY * 2.0) - 1.0,
        );
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

  Path _parseSvgPath(String pathData) {
    final Path path = Path();
    final pathProxy = _PathProxyImpl(path);
    writeSvgPathDataToPath(pathData, pathProxy);
    return path;
  }

  @override
  bool shouldRepaint(_VectorPainter oldDelegate) {
    return fills != oldDelegate.fills ||
        strokes != oldDelegate.strokes ||
        strokeWeight != oldDelegate.strokeWeight ||
        fillGeometry != oldDelegate.fillGeometry ||
        strokeGeometry != oldDelegate.strokeGeometry ||
        effects != oldDelegate.effects ||
        shadowPadding != oldDelegate.shadowPadding;
  }
}

class _PathProxyImpl extends PathProxy {
  final Path path;

  _PathProxyImpl(this.path);

  @override
  void moveTo(double x, double y) => path.moveTo(x, y);

  @override
  void lineTo(double x, double y) => path.lineTo(x, y);

  @override
  void cubicTo(
    double x1,
    double y1,
    double x2,
    double y2,
    double x3,
    double y3,
  ) =>
      path.cubicTo(x1, y1, x2, y2, x3, y3);

  @override
  void close() => path.close();
}
