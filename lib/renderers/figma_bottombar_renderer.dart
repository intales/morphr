// Copyright (c) 2025 Intales Srl. All rights reserved.
// Use of this source code is governed by a MIT license that can be found
// in the LICENSE file.

import 'package:flutter/material.dart';
import 'package:morphr_figma/morphr_figma.dart' as figma;
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
    if (!node.visible) return const SizedBox.shrink();

    final barAdapter = FigmaBarAdapter(node, FigmaBarType.bottom);
    final decorationAdapter = FigmaDecorationAdapter(node);
    final constraintsAdapter = FigmaConstraintsAdapter(node, parentSize);

    barAdapter.validateBar();

    Widget content = Container(
      height: barAdapter.height,
      decoration: decorationAdapter.createBoxDecoration(),
      child: SafeArea(
        child: FigmaFlexRenderer().render(
          node: node,
          parentSize: Size(parentSize.width, barAdapter.height),
          children: children,
        ),
      ),
    );

    return constraintsAdapter.applyConstraints(content);
  }

  Size getPreferredSize({
    required final figma.Node node,
    required final EdgeInsets mediaQueryPadding,
  }) {
    final barAdapter = FigmaBarAdapter(node, FigmaBarType.bottom);
    barAdapter.validateBar();

    return Size.fromHeight(barAdapter.height);
  }
}
