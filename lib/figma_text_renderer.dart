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

    String text = rendererContext.get<String>(
          FigmaProperties.text,
          nodeId: node.name!,
        ) ??
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
            maxLines: rendererContext.get<int>(
              FigmaProperties.maxLines,
              nodeId: node.name!,
            ),
            overflow: rendererContext.get<TextOverflow>(
              FigmaProperties.overflow,
              nodeId: node.name!,
            ),
            softWrap: rendererContext.get<bool>(
                  FigmaProperties.softWrap,
                  nodeId: node.name!,
                ) ??
                true,
          ),
        );
      } else {
        textWidget = Text(
          text,
          style: baseStyle,
          textAlign: textAlign,
          maxLines: rendererContext.get<int>(
            FigmaProperties.maxLines,
            nodeId: node.name!,
          ),
          overflow: rendererContext.get<TextOverflow>(
            FigmaProperties.overflow,
            nodeId: node.name!,
          ),
          softWrap: rendererContext.get<bool>(
                FigmaProperties.softWrap,
                nodeId: node.name!,
              ) ??
              true,
        );
      }
    } else {
      textWidget = Text(
        text,
        style: baseStyle,
        textAlign: textAlign,
        maxLines: rendererContext.get<int>(
          FigmaProperties.maxLines,
          nodeId: node.name!,
        ),
        overflow: rendererContext.get<TextOverflow>(
          FigmaProperties.overflow,
          nodeId: node.name!,
        ),
        softWrap: rendererContext.get<bool>(
              FigmaProperties.softWrap,
              nodeId: node.name!,
            ) ??
            true,
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
            maxLines: rendererContext.get<int>(
              FigmaProperties.maxLines,
              nodeId: node.name!,
            ),
            overflow: rendererContext.get<TextOverflow>(
              FigmaProperties.overflow,
              nodeId: node.name!,
            ),
            softWrap: rendererContext.get<bool>(
                  FigmaProperties.softWrap,
                  nodeId: node.name!,
                ) ??
                true,
          ),
        ],
      );
    }

    return FigmaStyleUtils.wrapWithBlur(textWidget, node.effects);
  }
}
