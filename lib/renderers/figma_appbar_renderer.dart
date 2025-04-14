// Copyright (c) 2025 Intales Srl. All rights reserved.
// Use of this source code is governed by a MIT license that can be found
// in the LICENSE file.

import 'package:flutter/material.dart';
import 'package:morphr_figma/morphr_figma.dart' as figma;
import 'package:morphr/renderers/figma_flex_renderer.dart';
import 'package:morphr/adapters/figma_bar_adapter.dart';
import 'package:morphr/adapters/figma_decoration_adapter.dart';

class FigmaAppbarRenderer {
  const FigmaAppbarRenderer();

  Widget render({
    required final figma.Node node,
    required final EdgeInsets mediaQueryPadding,
    required final Size parentSize,
    required final List<Widget> children,
  }) {
    final barAdapter = FigmaBarAdapter(node, FigmaBarType.top);
    final decorationAdapter = FigmaDecorationAdapter(node);

    barAdapter.validateBar();

    final totalHeight = barAdapter.height + mediaQueryPadding.top;
    final contentHeight = barAdapter.height;

    return Stack(
      children: [
        Container(
          height: totalHeight,
          decoration: decorationAdapter.createBoxDecoration(),
        ),
        Positioned(
          top: mediaQueryPadding.top,
          left: 0,
          right: 0,
          height: contentHeight,
          child: const FigmaFlexRenderer().render(
            node: node,
            parentSize: Size(parentSize.width, contentHeight),
            children: children,
          ),
        ),
      ],
    );
  }

  Size getPreferredSize({
    required final figma.Node node,
    required final EdgeInsets mediaQueryPadding,
  }) {
    final barAdapter = FigmaBarAdapter(node, FigmaBarType.top);
    barAdapter.validateBar();

    return Size.fromHeight(barAdapter.height);
  }
}
