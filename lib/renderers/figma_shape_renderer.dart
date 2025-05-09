// Copyright (c) 2025 Intales Srl. All rights reserved.
// Use of this source code is governed by a MIT license that can be found
// in the LICENSE file.

import 'package:flutter/material.dart';
import 'package:morphr_figma/morphr_figma.dart' as figma;
import 'package:morphr/adapters/figma_constraints_adapter.dart';
import 'package:morphr/adapters/figma_decoration_adapter.dart';
import 'package:morphr/adapters/figma_shape_adapter.dart';

class FigmaShapeRenderer {
  const FigmaShapeRenderer();

  Widget render({
    required final figma.Node node,
    required final Size parentSize,
    final Widget? child,
  }) {
    if (!node.visible) return const SizedBox.shrink();

    final shapeAdapter = FigmaShapeAdapter(node);
    final decorationAdapter = FigmaDecorationAdapter(node);
    final constraintsAdapter = FigmaConstraintsAdapter(node, parentSize);

    shapeAdapter.validateShape();
    decorationAdapter.validateDecoration();

    Widget container = Container(
      width: shapeAdapter.size?.width,
      height: shapeAdapter.size?.height,
      decoration: decorationAdapter.createBoxDecoration(),
      child: child,
    );

    container = decorationAdapter.wrapWithBlurEffects(container);

    // Apply constraints
    return constraintsAdapter.applyConstraints(container);
  }
}
