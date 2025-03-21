// Copyright (c) 2025 Intales Srl. All rights reserved.
// Use of this source code is governed by a MIT license that can be found
// in the LICENSE file.

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

    // Create the flex content
    Widget flex = Flex(
      direction: isRow ? Axis.horizontal : Axis.vertical,
      mainAxisAlignment: layoutAdapter.getMainAxisAlignment(),
      crossAxisAlignment: layoutAdapter.getCrossAxisAlignment(),
      mainAxisSize: layoutAdapter.mainAxisSize,
      children: _addSpacing(children, layoutAdapter),
    );

    // Apply padding and decoration
    if (layoutAdapter.padding != EdgeInsets.zero ||
        decorationAdapter.supportsDecoration) {
      flex = Container(
        decoration: decorationAdapter.createBoxDecoration(),
        padding: layoutAdapter.padding,
        child: decorationAdapter.wrapWithBlurEffects(flex),
      );
    }

    // Finally apply any additional constraints
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
}
