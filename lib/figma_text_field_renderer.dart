import 'package:flutter/material.dart';
import 'package:figma/figma.dart' as figma;
import 'package:morphr/figma_style_utils.dart';

class FigmaTextFieldRenderer {
  const FigmaTextFieldRenderer();

  Widget render(
    figma.Node node, {
    TextEditingController? controller,
    ValueChanged<String>? onChanged,
    ValueChanged<String>? onSubmitted,
    String? hint,
  }) {
    if (node is! figma.Text) {
      throw ArgumentError('Node must be a TEXT node');
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

    final textField = TextField(
      controller: controller,
      onChanged: onChanged,
      onSubmitted: onSubmitted,
      style: baseStyle,
      textAlign: textAlign,
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
    );

    Widget result = textField;

    if (hasGradient) {
      final gradientFill = node.fills.firstWhere((f) =>
          f.type == figma.PaintType.gradientLinear ||
          f.type == figma.PaintType.gradientRadial);

      final gradient = FigmaStyleUtils.getGradient(gradientFill);
      if (gradient != null) {
        result = ShaderMask(
          blendMode: BlendMode.srcIn,
          shaderCallback: (bounds) => gradient.createShader(
            Rect.fromLTWH(0, 0, bounds.width, bounds.height),
          ),
          child: result,
        );
      }
    }

    if (hasStroke) {
      result = Stack(
        children: [
          TextField(
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
          ),
          result,
        ],
      );
    }

    return FigmaStyleUtils.wrapWithBlur(result, node.effects);
  }
}
