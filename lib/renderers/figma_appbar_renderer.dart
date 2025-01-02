import 'package:flutter/material.dart';
import 'package:figma/figma.dart' as figma;
import 'package:morphr/renderers/figma_flex_renderer.dart';
import 'package:morphr/renderers/figma_frame_decoration_renderer.dart';

class FigmaAppbarRenderer with FigmaFrameDecorationRenderer {
  const FigmaAppbarRenderer();

  Widget render({
    required final figma.Node node,
    required final EdgeInsets mediaQueryPadding,
    required final List<Widget> children,
  }) {
    if (node is! figma.Frame) {
      throw ArgumentError("Node must be a FRAME node");
    }

    final totalHeight = (node.absoluteBoundingBox?.height ?? kToolbarHeight) +
        mediaQueryPadding.top;

    return Stack(
      children: [
        Container(
          height: totalHeight,
          decoration: getDecoration(node),
        ),
        Positioned(
          top: mediaQueryPadding.top,
          left: 0,
          right: 0,
          height: node.absoluteBoundingBox?.height ?? kToolbarHeight,
          child: const FigmaFlexRenderer().render(
            node: node,
            children: children,
          ),
        ),
      ],
    );
  }

  Size getPreferredSize({
    required final figma.Node node,
    required final EdgeInsets mediaQueryPadding,
  }) {
    if (node is! figma.Frame) {
      throw ArgumentError("Node must be a FRAME node");
    }

    return Size.fromHeight(
      (node.absoluteBoundingBox?.height ?? kToolbarHeight) +
          mediaQueryPadding.top,
    );
  }
}
