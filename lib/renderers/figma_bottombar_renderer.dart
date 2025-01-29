import 'package:flutter/material.dart';
import 'package:figma/figma.dart' as figma;
import 'package:morphr/renderers/figma_flex_renderer.dart';
import 'package:morphr/adapters/figma_bar_adapter.dart';
import 'package:morphr/adapters/figma_decoration_adapter.dart';

class FigmaBottomBarRenderer {
  const FigmaBottomBarRenderer();

  Widget render({
    required final figma.Node node,
    required final EdgeInsets mediaQueryPadding,
    required final List<Widget> children,
  }) {
    final barAdapter = FigmaBarAdapter(node, FigmaBarType.bottom);
    final decorationAdapter = FigmaDecorationAdapter(node);

    barAdapter.validateBar();

    final totalHeight = barAdapter.getAdjustedHeight(mediaQueryPadding);

    return Stack(
      children: [
        Container(
          height: totalHeight,
          decoration: decorationAdapter.createBoxDecoration(),
        ),
        barAdapter.getContentPosition(
          mediaQueryPadding: mediaQueryPadding,
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
    final barAdapter = FigmaBarAdapter(node, FigmaBarType.bottom);
    barAdapter.validateBar();
    
    return Size.fromHeight(barAdapter.getAdjustedHeight(mediaQueryPadding));
  }
}
