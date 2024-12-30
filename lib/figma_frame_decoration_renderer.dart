import 'package:flutter/material.dart';
import 'package:figma/figma.dart' as figma;
import 'package:morphr/figma_style_utils.dart';

mixin FigmaFrameDecorationRenderer {
  BoxDecoration getDecoration(figma.Frame node) {
    return BoxDecoration(
      color: _getSolidColor(node),
      gradient: _getGradient(node),
      borderRadius: _getBorderRadius(node),
      border: _getBorder(node),
      boxShadow: _getBoxShadow(node),
    );
  }

  Color? _getSolidColor(figma.Frame node) {
    return !_hasGradient(node) ? FigmaStyleUtils.getColor(node.fills) : null;
  }

  Gradient? _getGradient(figma.Frame node) {
    if (!_hasGradient(node)) return null;

    return FigmaStyleUtils.getGradient(node.fills.firstWhere(
      (f) =>
          f.type == figma.PaintType.gradientLinear ||
          f.type == figma.PaintType.gradientRadial,
    ));
  }

  bool _hasGradient(figma.Frame node) {
    return node.fills.any((f) =>
        f.type == figma.PaintType.gradientLinear ||
        f.type == figma.PaintType.gradientRadial);
  }

  BorderRadius? _getBorderRadius(figma.Frame node) {
    final radius = node.cornerRadius?.toDouble() ?? 0.0;
    return radius > 0 ? BorderRadius.circular(radius) : null;
  }

  Border? _getBorder(figma.Frame node) {
    if (node.strokes.isEmpty) return null;

    return Border.all(
      color: FigmaStyleUtils.getColor(node.strokes) ?? Colors.black,
      width: node.strokeWeight?.toDouble() ?? 1.0,
    );
  }

  List<BoxShadow>? _getBoxShadow(figma.Frame node) {
    return FigmaStyleUtils.getEffects(node.effects);
  }
}
