import 'package:figflow/figma_component_context.dart';
import 'package:figflow/figma_properties.dart';
import 'package:figflow/figma_renderer.dart';
import 'package:flutter/material.dart';
import 'package:figma/figma.dart' as figma;

class FigmaFrameRenderer extends FigmaRenderer {
  const FigmaFrameRenderer();

  @override
  Widget render({
    required final FigmaComponentContext rendererContext,
    required final figma.Node node,
  }) {
    if (node is! figma.Frame) {
      throw ArgumentError('Node must be a FRAME node');
    }

    final children = rendererContext.get<List<Widget>>(
          FigmaProperties.children,
          nodeId: node.name!,
        ) ??
        [];

    if (node.layoutMode != null && node.layoutMode != figma.LayoutMode.none) {
      return _buildAutoLayout(node, children);
    }

    return Stack(
      alignment: Alignment.center,
      children: children,
    );
  }

  Widget _buildAutoLayout(figma.Frame frame, List<Widget> children) {
    final direction = frame.layoutMode == figma.LayoutMode.horizontal
        ? Axis.horizontal
        : Axis.vertical;

    final mainAxisAlignment =
        _getMainAxisAlignment(frame.primaryAxisAlignItems);
    final crossAxisAlignment =
        _getCrossAxisAlignment(frame.counterAxisAlignItems);

    final spacing = frame.itemSpacing.toDouble();
    final spacedChildren = _addSpacing(children, spacing, direction);

    return Flex(
      direction: direction,
      mainAxisAlignment: mainAxisAlignment,
      crossAxisAlignment: crossAxisAlignment,
      mainAxisSize: MainAxisSize.min,
      children: spacedChildren,
    );
  }

  MainAxisAlignment _getMainAxisAlignment(figma.PrimaryAxisAlignItems? align) {
    return switch (align) {
      figma.PrimaryAxisAlignItems.min => MainAxisAlignment.start,
      figma.PrimaryAxisAlignItems.center => MainAxisAlignment.center,
      figma.PrimaryAxisAlignItems.max => MainAxisAlignment.end,
      figma.PrimaryAxisAlignItems.spaceBetween =>
        MainAxisAlignment.spaceBetween,
      null => MainAxisAlignment.start,
    };
  }

  CrossAxisAlignment _getCrossAxisAlignment(
      figma.CounterAxisAlignItems? align) {
    return switch (align) {
      figma.CounterAxisAlignItems.min => CrossAxisAlignment.start,
      figma.CounterAxisAlignItems.center => CrossAxisAlignment.center,
      figma.CounterAxisAlignItems.max => CrossAxisAlignment.end,
      figma.CounterAxisAlignItems.baseline => CrossAxisAlignment.baseline,
      null => CrossAxisAlignment.start,
    };
  }

  List<Widget> _addSpacing(
      List<Widget> widgets, double spacing, Axis direction) {
    if (spacing == 0 || widgets.length < 2) return widgets;

    return widgets
        .expand((widget) sync* {
          yield widget;
          yield SizedBox(
            width: direction == Axis.horizontal ? spacing : 0,
            height: direction == Axis.vertical ? spacing : 0,
          );
        })
        .take(widgets.length * 2 - 1)
        .toList();
  }
}
