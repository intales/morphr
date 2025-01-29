import 'package:flutter/material.dart';
import 'package:figma/figma.dart' as figma;
import 'package:morphr/adapters/figma_layout_adapter.dart';
import 'package:morphr/adapters/figma_decoration_adapter.dart';

class FigmaListRenderer {
  const FigmaListRenderer();

  Widget render({
    required final figma.Node node,
    required final int itemCount,
    required final IndexedWidgetBuilder itemBuilder,
    final Axis scrollDirection = Axis.vertical,
  }) {
    final layoutAdapter = FigmaLayoutAdapter(node);
    final decorationAdapter = FigmaDecorationAdapter(node);

    layoutAdapter.validateLayout();

    final result = ListView.separated(
      padding: layoutAdapter.padding,
      scrollDirection: scrollDirection,
      itemCount: itemCount,
      separatorBuilder: (context, index) => SizedBox(
        width:
            scrollDirection == Axis.horizontal ? layoutAdapter.itemSpacing : 0,
        height:
            scrollDirection == Axis.vertical ? layoutAdapter.itemSpacing : 0,
      ),
      itemBuilder: itemBuilder,
    );

    return Container(
      decoration: decorationAdapter.createBoxDecoration(),
      child: decorationAdapter.wrapWithBlurEffects(result),
    );
  }
}
