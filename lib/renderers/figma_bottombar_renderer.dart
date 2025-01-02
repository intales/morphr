import 'package:flutter/material.dart';
import 'package:figma/figma.dart' as figma;
import 'package:morphr/renderers/figma_flex_renderer.dart';
import 'package:morphr/renderers/figma_frame_decoration_renderer.dart';

class FigmaBottomBarRenderer with FigmaFrameDecorationRenderer {
  const FigmaBottomBarRenderer();

  Widget render({
    required final figma.Node node,
    required final EdgeInsets mediaQueryPadding,
    required final List<Widget> children,
  }) {
    if (node is! figma.Frame) {
      throw ArgumentError("Node must be a FRAME node");
    }

    final totalHeight =
        (node.absoluteBoundingBox?.height ?? kBottomNavigationBarHeight) +
            mediaQueryPadding.bottom;

    return Stack(
      children: [
        Container(
          height: totalHeight,
          decoration: getDecoration(node),
        ),
        Positioned(
          top: 0,
          left: 0,
          right: 0,
          height:
              node.absoluteBoundingBox?.height ?? kBottomNavigationBarHeight,
          child: const FigmaFlexRenderer().render(
            node: node,
            children: children,
          ),
        ),
      ],
    );
  }
}
