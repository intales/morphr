// Copyright (c) 2025 Intales Srl. All rights reserved.
// Use of this source code is governed by a MIT license that can be found
// in the LICENSE file.

import 'package:flutter/material.dart';
import 'package:morphr_figma/morphr_figma.dart' as figma;
import 'package:morphr/adapters/figma_constraints_adapter.dart';

class FigmaTextRenderer {
  const FigmaTextRenderer();

  Widget render({
    required final figma.Node node,
    required final Size parentSize,
    required final String content,
  }) {
    if (node is! figma.Text) {
      throw ArgumentError('Node must be a TEXT node');
    }

    final constraintsAdapter = FigmaConstraintsAdapter(node, parentSize);
    Widget text = _renderText(node, content);

    return constraintsAdapter.applyConstraints(text);
  }

  Widget _renderText(figma.Text node, String text) {
    final baseStyle = _createTextStyle(node);
    final textAlign = _getTextAlign(node.style?.textAlignHorizontal);
    final hasStroke = node.strokes.isNotEmpty == true;
    final hasFill = node.fills.isNotEmpty == true;
    final hasGradient =
        hasFill &&
        node.fills.any(
          (f) =>
              f.type == figma.PaintType.gradientLinear ||
              f.type == figma.PaintType.gradientRadial,
        );

    Widget textWidget;

    if (hasGradient) {
      final gradientFill = node.fills.firstWhere(
        (f) =>
            f.type == figma.PaintType.gradientLinear ||
            f.type == figma.PaintType.gradientRadial,
      );

      final gradient = _createGradient(gradientFill);
      if (gradient != null) {
        textWidget = ShaderMask(
          blendMode: BlendMode.srcIn,
          shaderCallback:
              (bounds) => gradient.createShader(
                Rect.fromLTWH(0, 0, bounds.width, bounds.height),
              ),
          child: Text(text, style: baseStyle, textAlign: textAlign),
        );
      } else {
        textWidget = Text(text, style: baseStyle, textAlign: textAlign);
      }
    } else {
      textWidget = Text(text, style: baseStyle, textAlign: textAlign);
    }

    if (hasStroke) {
      textWidget = Stack(
        children: [
          textWidget,
          Text(
            text,
            style: baseStyle?.copyWith(
              foreground:
                  Paint()
                    ..style = PaintingStyle.stroke
                    ..strokeWidth = node.strokeWeight?.toDouble() ?? 1.0
                    ..color = _getColor(node.strokes),
            ),
            textAlign: textAlign,
          ),
        ],
      );
    }

    return textWidget;
  }

  TextStyle? _createTextStyle(figma.Text node) {
    if (node.style == null) return null;

    return TextStyle(
      fontSize: node.style?.fontSize?.toDouble(),
      fontWeight: _getFontWeight(node.style?.fontWeight?.toInt()),
      fontStyle:
          node.style?.italic == true ? FontStyle.italic : FontStyle.normal,
      letterSpacing: node.style?.letterSpacing?.toDouble(),
      height: _getLineHeight(node),
      decoration: _getTextDecoration(node.style?.textDecoration),
      color: _getColor(node.fills),
    );
  }

  TextAlign _getTextAlign(figma.TextAlignHorizontal? align) {
    return switch (align) {
      figma.TextAlignHorizontal.left => TextAlign.left,
      figma.TextAlignHorizontal.center => TextAlign.center,
      figma.TextAlignHorizontal.right => TextAlign.right,
      figma.TextAlignHorizontal.justified => TextAlign.justify,
      _ => TextAlign.left,
    };
  }

  FontWeight _getFontWeight(int? weight) {
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
      _ => FontWeight.w400,
    };
  }

  double? _getLineHeight(figma.Text node) {
    final heightPx = node.style?.lineHeightPx;
    final size = node.style?.fontSize;
    if (heightPx == null || size == null || size == 0) return null;
    return heightPx / size;
  }

  TextDecoration? _getTextDecoration(figma.TextDecoration? decoration) {
    return switch (decoration) {
      figma.TextDecoration.underline => TextDecoration.underline,
      figma.TextDecoration.strikeThrough => TextDecoration.lineThrough,
      _ => null,
    };
  }

  Color _getColor(List<figma.Paint>? paints) {
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
}
