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

    final isInput = rendererContext.get<bool>(
          FigmaProperties.isInput,
          nodeId: node.name!,
        ) ??
        false;

    if (isInput) {
      return _renderInput(node, rendererContext);
    }

    return _renderText(node, rendererContext);
  }

  Widget _renderInput(figma.Text node, FigmaComponentContext rendererContext) {
    final baseStyle = FigmaStyleUtils.getTextStyle(node);
    final textAlign =
        FigmaStyleUtils.getTextAlign(node.style?.textAlignHorizontal);
    final hasStroke = node.strokes.isNotEmpty == true;
    final hasFill = node.fills.isNotEmpty == true;
    final hasGradient = hasFill &&
        node.fills.any((f) =>
            f.type == figma.PaintType.gradientLinear ||
            f.type == figma.PaintType.gradientRadial);

    final controller = rendererContext.get<TextEditingController>(
          FigmaProperties.controller,
          nodeId: node.name!,
        ) ??
        TextEditingController();
    final onChanged = rendererContext.get<ValueChanged<String>>(
      FigmaProperties.onChanged,
      nodeId: node.name!,
    );
    final onSubmitted = rendererContext.get<ValueChanged<String>>(
      FigmaProperties.onSubmitted,
      nodeId: node.name!,
    );
    final hint = rendererContext.get<String>(
          FigmaProperties.hint,
          nodeId: node.name!,
        ) ??
        node.characters ??
        '';

    Widget inputWidget = SizedBox.expand(
      child: TextFormField(
        controller: controller,
        onChanged: onChanged,
        onFieldSubmitted: onSubmitted,
        style: baseStyle,
        textAlign: textAlign,
        maxLines: rendererContext.get<int>(
          FigmaProperties.maxLines,
          nodeId: node.name!,
        ),
        decoration: InputDecoration(
          hintText: hint,
          hintStyle: baseStyle?.copyWith(
            color: baseStyle.color?.withOpacity(0.5),
          ),
          border: InputBorder.none,
          enabledBorder: InputBorder.none,
          focusedBorder: InputBorder.none,
          contentPadding: EdgeInsets.zero,
          isDense: true,
          isCollapsed: true,
        ),
        expands: true,
      ),
    );

    if (hasGradient) {
      final gradientFill = node.fills.firstWhere((f) =>
          f.type == figma.PaintType.gradientLinear ||
          f.type == figma.PaintType.gradientRadial);

      final gradient = FigmaStyleUtils.getGradient(gradientFill);
      if (gradient != null) {
        inputWidget = ShaderMask(
          blendMode: BlendMode.srcIn,
          shaderCallback: (bounds) => gradient.createShader(
            Rect.fromLTWH(0, 0, bounds.width, bounds.height),
          ),
          child: inputWidget,
        );
      }
    }

    if (hasStroke) {
      inputWidget = Stack(
        fit: StackFit.expand,
        children: [
          SizedBox.expand(
            child: TextFormField(
              enabled: false,
              controller: controller,
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
              decoration: InputDecoration(
                hintText: hint,
                hintStyle: baseStyle?.copyWith(
                  foreground: Paint()
                    ..style = PaintingStyle.stroke
                    ..strokeWidth = node.strokeWeight?.toDouble() ?? 1.0
                    ..color =
                        FigmaStyleUtils.getColor(node.strokes) ?? Colors.black,
                ),
                border: InputBorder.none,
                enabledBorder: InputBorder.none,
                focusedBorder: InputBorder.none,
                contentPadding: EdgeInsets.zero,
                isDense: true,
                isCollapsed: true,
              ),
              expands: true,
            ),
          ),
          inputWidget,
        ],
      );
    }

    return FigmaStyleUtils.wrapWithBlur(inputWidget, node.effects);
  }

  Widget _renderText(figma.Text node, FigmaComponentContext rendererContext) {
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
