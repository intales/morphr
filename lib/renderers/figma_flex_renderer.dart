import 'package:figma/figma.dart' as figma;
import 'package:flutter/material.dart';
import 'package:morphr/adapters/figma_constraints_adapter.dart';
import 'package:morphr/adapters/figma_layout_adapter.dart';
import 'package:morphr/adapters/figma_decoration_adapter.dart';

class FigmaFlexRenderer {
  const FigmaFlexRenderer();

  Widget render({
    required final figma.Node node,
    required final Size parentSize,
    required final List<Widget> children,
  }) {
    final layoutAdapter = FigmaLayoutAdapter(node);
    final decorationAdapter = FigmaDecorationAdapter(node);
    final constraintsAdapter = FigmaConstraintsAdapter(node, parentSize);

    layoutAdapter.validateLayout();

    final isRow = layoutAdapter.layoutMode == figma.LayoutMode.horizontal;

    Widget flex = Flex(
      direction: isRow ? Axis.horizontal : Axis.vertical,
      mainAxisAlignment:
          _getMainAxisAlignment(layoutAdapter.primaryAxisAlignItems),
      crossAxisAlignment:
          _getCrossAxisAlignment(layoutAdapter.counterAxisAlignItems),
      mainAxisSize: MainAxisSize.max,
      children: _addSpacing(children, layoutAdapter),
    );

    flex = Container(
      decoration: decorationAdapter.createBoxDecoration(),
      padding: layoutAdapter.padding,
      child: decorationAdapter.wrapWithBlurEffects(flex),
    );

    return constraintsAdapter.applyConstraints(flex);
  }

  List<Widget> _addSpacing(List<Widget> children, FigmaLayoutAdapter adapter) {
    final spacing = adapter.itemSpacing;
    if (spacing == 0 || children.isEmpty) {
      return children;
    }

    final isRow = adapter.layoutMode == figma.LayoutMode.horizontal;
    final spacedChildren = <Widget>[];

    for (var i = 0; i < children.length; i++) {
      spacedChildren.add(children[i]);
      if (i < children.length - 1) {
        spacedChildren.add(SizedBox(
          width: isRow ? spacing : 0,
          height: !isRow ? spacing : 0,
        ));
      }
    }

    return spacedChildren;
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
      _ => CrossAxisAlignment.center,
    };
  }
}
