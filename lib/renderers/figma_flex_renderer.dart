// Copyright (c) 2025 Intales Srl. All rights reserved.
// Use of this source code is governed by a MIT license that can be found
// in the LICENSE file.

import 'package:morphr_figma/morphr_figma.dart' as figma;
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

    // Create the appropriate layout widget based on properties
    Widget layoutWidget;

    // Check if we should use Wrap or Flex
    if (layoutAdapter.isWrapLayout) {
      layoutWidget = Wrap(
        direction: isRow ? Axis.horizontal : Axis.vertical,
        alignment: _getWrapAlignment(layoutAdapter.getMainAxisAlignment()),
        crossAxisAlignment: _getWrapCrossAlignment(
          layoutAdapter.getCrossAxisAlignment(),
        ),
        spacing: layoutAdapter.itemSpacing,
        runSpacing: layoutAdapter.itemSpacing,
        children: children,
      );
    } else {
      // Use Flex widget for standard layouts
      layoutWidget = Flex(
        direction: isRow ? Axis.horizontal : Axis.vertical,
        mainAxisAlignment: layoutAdapter.getMainAxisAlignment(),
        crossAxisAlignment: layoutAdapter.getCrossAxisAlignment(),
        mainAxisSize: layoutAdapter.mainAxisSize,
        children: _addSpacing(children, layoutAdapter),
      );
    }

    // Apply padding and decoration if needed
    if (layoutAdapter.padding != EdgeInsets.zero ||
        decorationAdapter.supportsDecoration) {
      layoutWidget = Container(
        decoration: decorationAdapter.createBoxDecoration(),
        padding: layoutAdapter.padding,
        child: decorationAdapter.wrapWithBlurEffects(layoutWidget),
      );
    }

    // Apply any additional constraints
    return constraintsAdapter.applyConstraints(layoutWidget);
  }

  // Helper methods to convert MainAxisAlignment to WrapAlignment
  WrapAlignment _getWrapAlignment(MainAxisAlignment alignment) {
    return switch (alignment) {
      MainAxisAlignment.start => WrapAlignment.start,
      MainAxisAlignment.center => WrapAlignment.center,
      MainAxisAlignment.end => WrapAlignment.end,
      MainAxisAlignment.spaceBetween => WrapAlignment.spaceBetween,
      MainAxisAlignment.spaceAround => WrapAlignment.spaceAround,
      MainAxisAlignment.spaceEvenly => WrapAlignment.spaceEvenly,
    };
  }

  // Helper methods to convert CrossAxisAlignment to WrapCrossAlignment
  WrapCrossAlignment _getWrapCrossAlignment(CrossAxisAlignment alignment) {
    return switch (alignment) {
      CrossAxisAlignment.start => WrapCrossAlignment.start,
      CrossAxisAlignment.center => WrapCrossAlignment.center,
      CrossAxisAlignment.end => WrapCrossAlignment.end,
      _ => WrapCrossAlignment.start,
    };
  }

  // This is only used for non-wrap layouts since Wrap handles spacing internally
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
        spacedChildren.add(
          SizedBox(width: isRow ? spacing : 0, height: !isRow ? spacing : 0),
        );
      }
    }

    return spacedChildren;
  }
}
