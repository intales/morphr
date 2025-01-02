import 'package:flutter/material.dart';
import 'package:figma/figma.dart' as figma;
import 'package:morphr/utils/figma_style_utils.dart';

mixin FigmaShapeDecorationRenderer {
  BoxDecoration getDecoration(figma.Node node) {
    if (node is! figma.Rectangle && node is! figma.Ellipse) {
      throw ArgumentError('Node must be a RECTANGLE or ELLIPSE node');
    }

    final decoration = BoxDecoration(
      shape: _getShape(node),
      borderRadius: _getBorderRadius(node),
      color: _getSolidColor(node),
      gradient: _getGradient(node),
      border: _getBorder(node),
      boxShadow: _getBoxShadow(node),
    );

    return decoration;
  }

  BoxShape _getShape(figma.Node node) {
    return node is figma.Rectangle ? BoxShape.rectangle : BoxShape.circle;
  }

  BorderRadius? _getBorderRadius(figma.Node node) {
    if (node is! figma.Rectangle) return null;
    final radius = node.cornerRadius?.toDouble() ?? 0.0;
    return radius > 0 ? BorderRadius.circular(radius) : null;
  }

  Color? _getSolidColor(figma.Node node) {
    final fills = _getFills(node);
    return !_hasGradient(node) ? FigmaStyleUtils.getColor(fills) : null;
  }

  Gradient? _getGradient(figma.Node node) {
    if (!_hasGradient(node)) return null;

    final fills = _getFills(node);
    if (fills == null) return null;

    return FigmaStyleUtils.getGradient(fills.firstWhere(
      (f) =>
          f.type == figma.PaintType.gradientLinear ||
          f.type == figma.PaintType.gradientRadial,
    ));
  }

  Border? _getBorder(figma.Node node) {
    final strokes = _getStrokes(node);
    if (strokes == null || strokes.isEmpty) return null;

    return Border.all(
      color: FigmaStyleUtils.getColor(strokes) ?? Colors.black,
      width: _getStrokeWeight(node) ?? 1.0,
    );
  }

  List<BoxShadow>? _getBoxShadow(figma.Node node) {
    final effects = _getEffects(node);
    return FigmaStyleUtils.getEffects(effects);
  }

  List<figma.Paint>? _getFills(figma.Node node) {
    if (node is figma.Rectangle) return node.fills;
    if (node is figma.Ellipse) return node.fills;
    return null;
  }

  List<figma.Paint>? _getStrokes(figma.Node node) {
    if (node is figma.Rectangle) return node.strokes;
    if (node is figma.Ellipse) return node.strokes;
    return null;
  }

  double? _getStrokeWeight(figma.Node node) {
    if (node is figma.Rectangle) return node.strokeWeight?.toDouble();
    if (node is figma.Ellipse) return node.strokeWeight?.toDouble();
    return null;
  }

  List<figma.Effect>? _getEffects(figma.Node node) {
    if (node is figma.Rectangle) return node.effects;
    if (node is figma.Ellipse) return node.effects;
    return null;
  }

  bool _hasGradient(figma.Node node) {
    final fills = _getFills(node);
    return fills?.any((f) =>
            f.type == figma.PaintType.gradientLinear ||
            f.type == figma.PaintType.gradientRadial) ??
        false;
  }
}
