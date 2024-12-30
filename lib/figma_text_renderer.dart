import 'package:morphr/figma_style_utils.dart';
import 'package:flutter/material.dart';
import 'package:figma/figma.dart' as figma;

class FigmaTextRenderer {
  const FigmaTextRenderer();

  Widget render({
    required final figma.Node node,
    required final String content,
  }) {
    if (node is! figma.Text) {
      throw ArgumentError('Node must be a TEXT node');
    }

    final text = _renderText(node, content);
    return text;
  }

  Widget _renderText(figma.Text node, String text) {
    final baseStyle = FigmaStyleUtils.getTextStyle(node);
    final textAlign =
        FigmaStyleUtils.getTextAlign(node.style?.textAlignHorizontal);
    final hasStroke = node.strokes.isNotEmpty == true;
    final hasFill = node.fills.isNotEmpty == true;
    final hasGradient = hasFill &&
        node.fills.any((f) =>
            f.type == figma.PaintType.gradientLinear ||
            f.type == figma.PaintType.gradientRadial);

    Widget textWidget;

    if (hasGradient) {
      final gradientFill = node.fills.firstWhere((f) =>
          f.type == figma.PaintType.gradientLinear ||
          f.type == figma.PaintType.gradientRadial);

      final gradient = FigmaStyleUtils.getGradient(gradientFill);
      if (gradient != null) {
        textWidget = ShaderMask(
          blendMode: BlendMode.srcIn,
          shaderCallback: (bounds) => gradient.createShader(
            Rect.fromLTWH(0, 0, bounds.width, bounds.height),
          ),
          child: Text(
            text,
            style: baseStyle,
            textAlign: textAlign,
          ),
        );
      } else {
        textWidget = Text(
          text,
          style: baseStyle,
          textAlign: textAlign,
        );
      }
    } else {
      textWidget = Text(
        text,
        style: baseStyle,
        textAlign: textAlign,
      );
    }

    if (hasStroke) {
      textWidget = Stack(
        children: [
          textWidget,
          Text(
            text,
            style: baseStyle?.copyWith(
              foreground: Paint()
                ..style = PaintingStyle.stroke
                ..strokeWidth = node.strokeWeight?.toDouble() ?? 1.0
                ..color =
                    FigmaStyleUtils.getColor(node.strokes) ?? Colors.black,
            ),
            textAlign: textAlign,
          ),
        ],
      );
    }

    return textWidget;
  }
}
