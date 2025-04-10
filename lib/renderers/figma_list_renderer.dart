// Copyright (c) 2025 Intales Srl. All rights reserved.
// Use of this source code is governed by a MIT license that can be found
// in the LICENSE file.

import 'package:flutter/material.dart';
import 'package:morphr_figma/morphr_figma.dart' as figma;
import 'package:morphr/adapters/figma_constraints_adapter.dart';
import 'package:morphr/adapters/figma_layout_adapter.dart';
import 'package:morphr/adapters/figma_decoration_adapter.dart';

class FigmaListRenderer {
  const FigmaListRenderer();

  Widget render({
    required final figma.Node node,
    required final Size parentSize,
    required final int itemCount,
    required final IndexedWidgetBuilder itemBuilder,
    final Axis scrollDirection = Axis.vertical,
    final bool shrinkWrap = false,
  }) {
    final layoutAdapter = FigmaLayoutAdapter(node);
    final decorationAdapter = FigmaDecorationAdapter(node);
    final constraintsAdapter = FigmaConstraintsAdapter(node, parentSize);

    layoutAdapter.validateLayout();

    Widget list = ListView.separated(
      padding: layoutAdapter.padding,
      scrollDirection: scrollDirection,
      itemCount: itemCount,
      shrinkWrap: shrinkWrap,
      separatorBuilder:
          (context, index) => SizedBox(
            width:
                scrollDirection == Axis.horizontal
                    ? layoutAdapter.itemSpacing
                    : 0,
            height:
                scrollDirection == Axis.vertical
                    ? layoutAdapter.itemSpacing
                    : 0,
          ),
      itemBuilder: itemBuilder,
    );

    list = Container(
      decoration: decorationAdapter.createBoxDecoration(),
      child: decorationAdapter.wrapWithBlurEffects(list),
    );

    return constraintsAdapter.applyConstraints(list);
  }
}
