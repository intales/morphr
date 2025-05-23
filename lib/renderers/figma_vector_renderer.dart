// Copyright (c) 2025 Intales Srl. All rights reserved.
// Use of this source code is governed by a MIT license that can be found
// in the LICENSE file.

import 'package:flutter/material.dart';
import 'package:morphr_figma/morphr_figma.dart' as figma;
import 'package:morphr/adapters/figma_constraints_adapter.dart';
import 'package:path_parsing/path_parsing.dart';

class FigmaVectorRenderer {
  const FigmaVectorRenderer();

  Widget render({
    required final figma.Node node,
    required final Size parentSize,
  }) {
    if (!node.visible) return const SizedBox.shrink();

    if (node is! figma.Vector) {
      throw ArgumentError('Node must be a VECTOR node');
    }

    final constraintsAdapter = FigmaConstraintsAdapter(node, parentSize);

    // Get base dimensions
    final baseWidth = _getWidth(node);
    final baseHeight = _getHeight(node);

    if (baseWidth == null || baseHeight == null) {
      return const SizedBox.shrink();
    }

    // Get stroke properties
    final strokeWeight = _getStrokeWeight(node) ?? 0.0;
    final strokeAlign = _getStrokeAlign(node) ?? figma.StrokeAlign.center;

    // Calculate stroke padding (how much the stroke extends beyond the path)
    double strokeOutsidePadding = 0.0;
    switch (strokeAlign) {
      case figma.StrokeAlign.inside:
        strokeOutsidePadding = 0.0; // Stroke is fully inside the path
        break;
      case figma.StrokeAlign.center:
        strokeOutsidePadding = strokeWeight / 2.0; // Half of stroke is outside
        break;
      case figma.StrokeAlign.outside:
        strokeOutsidePadding = strokeWeight; // Stroke is fully outside the path
        break;
    }

    // Calculate final dimensions including stroke
    final width = baseWidth + strokeOutsidePadding * 2;
    final height = baseHeight + strokeOutsidePadding * 2;

    final result = RepaintBoundary(
      child: CustomPaint(
        isComplex: true,
        painter: _VectorPainter(
          fills: _getFills(node),
          strokes: _getStrokes(node),
          strokeWeight: strokeWeight,
          strokeAlign: strokeAlign,
          fillGeometry: _getFillGeometry(node),
          strokeGeometry: _getStrokeGeometry(node),
          strokeCap: _getStrokeCap(node),
          strokeJoin: _getStrokeJoin(node),
        ),
        size: Size(width, height),
      ),
    );

    return constraintsAdapter.applyConstraints(result);
  }

  List<figma.Paint>? _getFills(figma.Node node) {
    return node is figma.Vector
        ? node.fills.where((e) => e.visible).toList()
        : null;
  }

  List<figma.Paint>? _getStrokes(figma.Node node) {
    return node is figma.Vector
        ? node.strokes.where((e) => e.visible).toList()
        : null;
  }

  double? _getStrokeWeight(figma.Node node) {
    return node is figma.Vector ? node.strokeWeight?.toDouble() : null;
  }

  figma.StrokeAlign? _getStrokeAlign(figma.Node node) {
    return node is figma.Vector ? node.strokeAlign : null;
  }

  StrokeCap _getStrokeCap(figma.Node node) {
    if (node is figma.Vector) {
      switch (node.strokeCap) {
        case figma.StrokeCap.round:
          return StrokeCap.round;
        case figma.StrokeCap.square:
          return StrokeCap.square;
        default:
          return StrokeCap.butt;
      }
    }
    return StrokeCap.butt; // Default
  }

  StrokeJoin _getStrokeJoin(figma.Node node) {
    if (node is figma.Vector) {
      switch (node.strokeJoin) {
        case figma.StrokeJoin.round:
          return StrokeJoin.round;
        case figma.StrokeJoin.bevel:
          return StrokeJoin.bevel;
        default:
          return StrokeJoin.miter;
      }
    }
    return StrokeJoin.miter; // Default
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
  final double strokeWeight;
  final figma.StrokeAlign strokeAlign;
  final List<figma.Path>? fillGeometry;
  final List<Map<String, dynamic>>? strokeGeometry;
  final StrokeCap strokeCap;
  final StrokeJoin strokeJoin;

  _VectorPainter({
    this.fills,
    this.strokes,
    this.strokeWeight = 0.0,
    this.strokeAlign = figma.StrokeAlign.center,
    this.fillGeometry,
    this.strokeGeometry,
    this.strokeCap = StrokeCap.butt,
    this.strokeJoin = StrokeJoin.miter,
  });

  @override
  void paint(Canvas canvas, Size size) {
    // Calculate translation based on stroke alignment
    double strokeOutsidePadding = 0.0;
    switch (strokeAlign) {
      case figma.StrokeAlign.inside:
        strokeOutsidePadding = 0.0;
        break;
      case figma.StrokeAlign.center:
        strokeOutsidePadding = strokeWeight / 2.0;
        break;
      case figma.StrokeAlign.outside:
        strokeOutsidePadding = strokeWeight;
        break;
    }

    canvas.translate(strokeOutsidePadding, strokeOutsidePadding);

    final paths = <Path>[];

    // Parse fill paths
    if (fillGeometry != null) {
      for (final pathData in fillGeometry!) {
        paths.add(_parseSvgPath(pathData.path));
      }
    }

    // Parse stroke paths
    if (strokeGeometry != null) {
      for (final pathData in strokeGeometry!) {
        final pathStr = pathData['path'] as String?;
        if (pathStr != null) {
          paths.add(_parseSvgPath(pathStr));
        }
      }
    }

    if (paths.isEmpty) return;

    // Draw fills
    if (fills != null && fills!.isNotEmpty) {
      for (final fill in fills!) {
        final paint = Paint()..style = PaintingStyle.fill;

        if (fill.type == figma.PaintType.solid) {
          paint.color = _createColor(fill);
        } else if (fill.type == figma.PaintType.gradientLinear ||
            fill.type == figma.PaintType.gradientRadial) {
          final gradient = _createGradient(fill, paths[0].getBounds());
          if (gradient != null) {
            paint.shader = gradient;
          }
        }

        for (final path in paths) {
          canvas.drawPath(path, paint);
        }
      }
    }

    // Draw strokes
    if (strokes != null && strokes!.isNotEmpty) {
      for (final stroke in strokes!) {
        final paint =
            Paint()
              ..style = PaintingStyle.stroke
              ..strokeWidth = strokeWeight
              ..strokeCap = strokeCap
              ..strokeJoin = strokeJoin;

        if (stroke.type == figma.PaintType.solid) {
          paint.color = _createColor(stroke);
        } else if (stroke.type == figma.PaintType.gradientLinear ||
            stroke.type == figma.PaintType.gradientRadial) {
          final gradient = _createGradient(stroke, paths[0].getBounds());
          if (gradient != null) {
            paint.shader = gradient;
          }
        }

        for (final path in paths) {
          canvas.drawPath(path, paint);
        }
      }
    }
  }

  Color _createColor(figma.Paint paint) {
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

  Shader? _createGradient(figma.Paint fill, Rect bounds) {
    if (fill.gradientStops == null || fill.gradientStops!.isEmpty) return null;

    final stops = fill.gradientStops!.map((stop) => stop.position!).toList();
    final colors =
        fill.gradientStops!.map((stop) {
          final color = stop.color;
          return Color.fromRGBO(
            ((color?.r ?? 0) * 255).round(),
            ((color?.g ?? 0) * 255).round(),
            ((color?.b ?? 0) * 255).round(),
            fill.opacity ?? 1,
          );
        }).toList();

    if (fill.type == figma.PaintType.gradientLinear) {
      return _createLinearGradient(fill, colors, stops, bounds);
    } else if (fill.type == figma.PaintType.gradientRadial) {
      return _createRadialGradient(fill, colors, stops, bounds);
    }

    return null;
  }

  Shader? _createLinearGradient(
    figma.Paint fill,
    List<Color> colors,
    List<double> stops,
    Rect bounds,
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
    ).createShader(bounds);
  }

  Shader? _createRadialGradient(
    figma.Paint fill,
    List<Color> colors,
    List<double> stops,
    Rect bounds,
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
    ).createShader(bounds);
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
        strokeAlign != oldDelegate.strokeAlign ||
        fillGeometry != oldDelegate.fillGeometry ||
        strokeGeometry != oldDelegate.strokeGeometry ||
        strokeCap != oldDelegate.strokeCap ||
        strokeJoin != oldDelegate.strokeJoin;
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
  ) => path.cubicTo(x1, y1, x2, y2, x3, y3);

  @override
  void close() => path.close();
}
