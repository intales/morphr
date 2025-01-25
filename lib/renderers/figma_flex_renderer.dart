import 'package:figma/figma.dart' as figma;
import 'package:flutter/material.dart';
import 'package:morphr/renderers/figma_frame_decoration_renderer.dart';

class FigmaFlexRenderer with FigmaFrameDecorationRenderer {
  const FigmaFlexRenderer();

  Widget render({
    required final figma.Node node,
    required final List<Widget> children,
  }) {
    if (node is! figma.Frame) {
      throw ArgumentError('Node must be a FRAME node');
    }

    final isRow = node.layoutMode == figma.LayoutMode.horizontal;

    final flex = Flex(
      direction: isRow ? Axis.horizontal : Axis.vertical,
      mainAxisAlignment: _getMainAxisAlignment(node.primaryAxisAlignItems),
      crossAxisAlignment: _getCrossAxisAlignment(node.counterAxisAlignItems),
      mainAxisSize: MainAxisSize.max,
      children: _addSpacing(children, node),
    );

    return Container(
      decoration: getDecoration(node),
      padding: getPadding(node),
      child: flex,
    );
  }

  List<Widget> _addSpacing(List<Widget> children, figma.Frame node) {
    final spacing = node.itemSpacing.toDouble();
    if (spacing == 0 || children.isEmpty) {
      return children;
    }

    final spacedChildren = <Widget>[];
    for (var i = 0; i < children.length; i++) {
      spacedChildren.add(children[i]);
      if (i < children.length - 1) {
        spacedChildren.add(SizedBox(
          width: node.layoutMode == figma.LayoutMode.horizontal ? spacing : 0,
          height: node.layoutMode == figma.LayoutMode.vertical ? spacing : 0,
        ));
      }
    }
    return spacedChildren;
  }

  EdgeInsets? getPadding(figma.Frame node) {
    return EdgeInsets.only(
      left: node.paddingLeft.toDouble(),
      top: node.paddingTop.toDouble(),
      right: node.paddingRight.toDouble(),
      bottom: node.paddingBottom.toDouble(),
    );
  }

  MainAxisAlignment _getMainAxisAlignment(figma.PrimaryAxisAlignItems? align) {
    return switch (align) {
      figma.PrimaryAxisAlignItems.min => MainAxisAlignment.start,
      figma.PrimaryAxisAlignItems.center => MainAxisAlignment.center,
      figma.PrimaryAxisAlignItems.max => MainAxisAlignment.end,
      figma.PrimaryAxisAlignItems.spaceBetween =>
        MainAxisAlignment.spaceBetween,
      _ => MainAxisAlignment.start,
    };
  }

  CrossAxisAlignment _getCrossAxisAlignment(
      figma.CounterAxisAlignItems? align) {
    return switch (align) {
      figma.CounterAxisAlignItems.min => CrossAxisAlignment.start,
      figma.CounterAxisAlignItems.center => CrossAxisAlignment.center,
      figma.CounterAxisAlignItems.max => CrossAxisAlignment.end,
      figma.CounterAxisAlignItems.baseline => CrossAxisAlignment.baseline,
      _ => CrossAxisAlignment.start,
    };
  }
}
