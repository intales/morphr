import 'package:flutter/material.dart';
import 'package:figma/figma.dart' as figma;
import 'package:morphr/adapters/figma_constraints_adapter.dart';
import 'package:morphr/renderers/figma_flex_renderer.dart';
import 'package:morphr/adapters/figma_bar_adapter.dart';
import 'package:morphr/adapters/figma_decoration_adapter.dart';

class FigmaBottomBarRenderer {
  const FigmaBottomBarRenderer();

  Widget render({
    required final figma.Node node,
    required final EdgeInsets mediaQueryPadding,
    required final Size parentSize,
    required final List<Widget> children,
  }) {
    final barAdapter = FigmaBarAdapter(node, FigmaBarType.bottom);
    final decorationAdapter = FigmaDecorationAdapter(node);
    final constraintsAdapter = FigmaConstraintsAdapter(node, parentSize);

    barAdapter.validateBar();

    final totalHeight = barAdapter.getAdjustedHeight(mediaQueryPadding);

    Widget content = Stack(
      children: [
        Container(
          height: totalHeight,
          decoration: decorationAdapter.createBoxDecoration(),
        ),
        barAdapter.getContentPosition(
          mediaQueryPadding: mediaQueryPadding,
          child: const FigmaFlexRenderer().render(
            node: node,
            parentSize: Size(parentSize.width, barAdapter.height),
            children: children,
          ),
        ),
      ],
    );

    return constraintsAdapter.applyConstraints(content);
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
