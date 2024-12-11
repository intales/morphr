import 'package:figflow/figma_component_context.dart';
import 'package:figflow/figma_renderer.dart';
import 'package:figflow/figma_properties.dart';
import 'package:figflow/figma_style_utils.dart';
import 'package:flutter/widgets.dart';
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

    final text = rendererContext.get<String>(FigmaProperties.text) ??
        node.characters ??
        'Text value not provided.';

    TextStyle? textStyle = FigmaStyleUtils.getTextStyle(node);

    final textAlign =
        FigmaStyleUtils.getTextAlign(node.style?.textAlignHorizontal);

    return Text(
      text,
      style: textStyle,
      textAlign: textAlign,
      maxLines: rendererContext.get<int>(FigmaProperties.maxLines),
      overflow: rendererContext.get<TextOverflow>(FigmaProperties.overflow),
      softWrap: rendererContext.get<bool>(FigmaProperties.softWrap) ?? true,
    );
  }
}
