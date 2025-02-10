import 'package:flutter/material.dart';
import 'package:figma/figma.dart' as figma;
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
    final shapeAdapter = FigmaShapeAdapter(node);
    final decorationAdapter = FigmaDecorationAdapter(node);
    final constraintsAdapter = FigmaConstraintsAdapter(node, parentSize);

    shapeAdapter.validateShape();
    decorationAdapter.validateDecoration();
    constraintsAdapter.validateConstraints();

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
