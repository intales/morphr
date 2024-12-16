import 'package:figflow/figma_component_context.dart';
import 'package:figflow/figma_properties.dart';
import 'package:flutter/widgets.dart';
import 'package:figma/figma.dart' as figma;

abstract class FigmaRenderer {
  const FigmaRenderer();

  Widget render({
    required final FigmaComponentContext rendererContext,
    required final figma.Node node,
  });

  Widget wrapWithTap(
    Widget content,
    FigmaComponentContext context,
    figma.Node node,
  ) {
    final onTap = context.get<VoidCallback>(
      FigmaProperties.onTap,
      nodeId: node.name!,
    );

    if (onTap == null) {
      return content;
    }

    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: content,
    );
  }
}
