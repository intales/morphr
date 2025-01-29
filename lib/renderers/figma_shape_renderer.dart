import 'package:flutter/material.dart';
import 'package:figma/figma.dart' as figma;
import 'package:morphr/adapters/figma_decoration_adapter.dart';
import 'package:morphr/adapters/figma_shape_adapter.dart';

class FigmaShapeRenderer {
  const FigmaShapeRenderer();

  Widget render({
    required final figma.Node node,
    final Widget? child,
  }) {
    final shapeAdapter = FigmaShapeAdapter(node);
    final decorationAdapter = FigmaDecorationAdapter(node);

    shapeAdapter.validateShape();
    decorationAdapter.validateDecoration();

    final container = Container(
      width: shapeAdapter.size?.width,
      height: shapeAdapter.size?.height,
      decoration: decorationAdapter.createBoxDecoration(),
      child: child,
    );

    return decorationAdapter.wrapWithBlurEffects(container);
  }
}
