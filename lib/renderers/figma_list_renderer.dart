import 'package:flutter/material.dart';
import 'package:figma/figma.dart' as figma;

class FigmaListRenderer {
  const FigmaListRenderer();

  Widget render({
    required final figma.Node node,
    required final int itemCount,
    required final IndexedWidgetBuilder itemBuilder,
    final Axis scrollDirection = Axis.vertical,
  }) {
    if (node is! figma.Frame) {
      throw ArgumentError("Node should be a FRAME node");
    }

    final spacing = node.itemSpacing;
    final padding = EdgeInsets.only(
      top: node.paddingTop,
      bottom: node.paddingBottom,
      right: node.paddingRight,
      left: node.paddingLeft,
    );

    return ListView.separated(
      padding: padding,
      scrollDirection: scrollDirection,
      itemCount: itemCount,
      separatorBuilder: (context, index) => SizedBox(
        width: scrollDirection == Axis.horizontal ? spacing : 0,
        height: scrollDirection == Axis.vertical ? spacing : 0,
      ),
      itemBuilder: itemBuilder,
    );
  }
}
