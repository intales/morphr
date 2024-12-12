import 'package:figflow/figma_component_context.dart';
import 'package:figflow/figma_renderer.dart';
import 'package:figflow/figma_properties.dart';
import 'package:figflow/figma_style_utils.dart';
import 'package:flutter/material.dart';
import 'package:figma/figma.dart' as figma;

class FigmaTextRenderer extends FigmaRenderer {
  const FigmaTextRenderer();

  @override
  Widget render({
    required final FigmaComponentContext rendererContext,
    required final figma.Node node,
  }) {
    if (node is! figma.Text) {
      throw ArgumentError('Node must be a TEXT node');
    }

    String text = rendererContext.get<String>(FigmaProperties.text) ??
        node.characters ??
        'Text value not provided.';

    if (node.style?.textCase != null) {
      text = switch (node.style!.textCase) {
        figma.TextCase.upper => text.toUpperCase(),
        figma.TextCase.lower => text.toLowerCase(),
        _ => text,
      };
    }

    final baseStyle = FigmaStyleUtils.getTextStyle(node);
    final textAlign =
        FigmaStyleUtils.getTextAlign(node.style?.textAlignHorizontal);
    final hasStroke = node.strokes.isNotEmpty == true;
    final hasFill = node.fills.isNotEmpty == true;
    final hasGradient = hasFill &&
        node.fills.any((f) =>
            f.type == figma.PaintType.gradientLinear ||
            f.type == figma.PaintType.gradientRadial);

    if (hasGradient || (hasFill && hasStroke)) {
      return LayoutBuilder(
        builder: (context, constraints) {
          final textSpan = TextSpan(
            text: text,
            style: baseStyle?.copyWith(
              color: Colors.white,
            ),
          );

          final textPainter = TextPainter(
            text: textSpan,
            textDirection: TextDirection.ltr,
            textAlign: textAlign,
          );
          textPainter.layout(maxWidth: constraints.maxWidth);

          final textSize = textPainter.size;
          final textRect = Rect.fromLTWH(0, 0, textSize.width, textSize.height);

          final children = <Widget>[];

          if (hasFill) {
            final fillPaint = Paint();
            if (hasGradient) {
              final gradientFill = node.fills.firstWhere((f) =>
                  f.type == figma.PaintType.gradientLinear ||
                  f.type == figma.PaintType.gradientRadial);
              final gradient = FigmaStyleUtils.getGradient(gradientFill);
              if (gradient != null) {
                fillPaint.shader = gradient.createShader(textRect);
              }
            } else {
              fillPaint.color =
                  FigmaStyleUtils.getColor(node.fills) ?? Colors.black;
            }

            children.add(
              Text(
                text,
                style: baseStyle?.copyWith(foreground: fillPaint),
                textAlign: textAlign,
                maxLines: rendererContext.get<int>(FigmaProperties.maxLines),
                overflow:
                    rendererContext.get<TextOverflow>(FigmaProperties.overflow),
                softWrap:
                    rendererContext.get<bool>(FigmaProperties.softWrap) ?? true,
              ),
            );
          }

          if (hasStroke) {
            children.add(
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
                maxLines: rendererContext.get<int>(FigmaProperties.maxLines),
                overflow:
                    rendererContext.get<TextOverflow>(FigmaProperties.overflow),
                softWrap:
                    rendererContext.get<bool>(FigmaProperties.softWrap) ?? true,
              ),
            );
          }

          return FigmaStyleUtils.wrapWithBlur(
            Stack(children: children),
            node.effects,
          );
        },
      );
    }

    return FigmaStyleUtils.wrapWithBlur(
      Text(
        text,
        style: baseStyle,
        textAlign: textAlign,
        maxLines: rendererContext.get<int>(FigmaProperties.maxLines),
        overflow: rendererContext.get<TextOverflow>(FigmaProperties.overflow),
        softWrap: rendererContext.get<bool>(FigmaProperties.softWrap) ?? true,
      ),
      node.effects,
    );
  }
}
