import 'package:flutter/material.dart';
import 'package:morphr/figma_component_context.dart';
import 'package:morphr/figma_node_layout_info.dart';
import 'package:morphr/figma_properties.dart';
import 'package:morphr/figma_renderer.dart';
import 'package:figma/figma.dart' as figma;

class FigmaGroupRenderer extends FigmaRenderer {
  const FigmaGroupRenderer();

  @override
  Widget render({
    required FigmaComponentContext rendererContext,
    required figma.Node node,
  }) {
    if (node is! figma.Group) {
      throw ArgumentError('Node must be a GROUP node');
    }

    return LayoutBuilder(
      builder: (context, constraints) {
        final children = rendererContext.get<List<Widget>>(
              FigmaProperties.children,
              nodeId: node.name!,
            ) ??
            [];

        final layoutInfos = rendererContext.get<List<NodeLayoutInfo>>(
              FigmaProperties.layoutInfo,
              nodeId: node.name!,
            ) ??
            [];

        // Calcoliamo le dimensioni del gruppo in base ai suoi children
        double maxRight = 0;
        double maxBottom = 0;

        for (final info in layoutInfos) {
          if (info.getPosition() != null && info.getSize() != null) {
            final right = info.getPosition()!.x + info.getSize()!.width;
            final bottom = info.getPosition()!.y + info.getSize()!.height;

            maxRight = maxRight > right ? maxRight : right;
            maxBottom = maxBottom > bottom ? maxBottom : bottom;
          }
        }

        // Usiamo le dimensioni del boundingBox se disponibili, altrimenti quelle calcolate
        final width = node.absoluteBoundingBox?.width?.toDouble() ?? maxRight;
        final height =
            node.absoluteBoundingBox?.height?.toDouble() ?? maxBottom;

        assert(children.length == layoutInfos.length,
            'Mismatch between children (${children.length}) and layoutInfos (${layoutInfos.length})');

        final positionedChildren = List<Widget>.generate(
          children.length,
          (index) {
            final child = children[index];
            final info = layoutInfos[index];

            if (info.getPosition() == null || info.getSize() == null) {
              return Positioned(
                left: 0,
                top: 0,
                child: child,
              );
            }

            return Positioned(
              left: info.getPosition()!.x,
              top: info.getPosition()!.y,
              width: info.getSize()!.width,
              height: info.getSize()!.height,
              child: child,
            );
          },
        );

        return SizedBox(
          width: width,
          height: height,
          child: Stack(
            clipBehavior: Clip.none,
            children: positionedChildren,
          ),
        );
      },
    );
  }
}
