import 'package:figflow/figma_component_context.dart';
import 'package:figflow/figma_renderer.dart';
import 'package:figflow/figma_shape_renderer.dart';
import 'package:figflow/figma_text_renderer.dart';
import 'package:figflow/figma_vector_renderer.dart';
import 'package:flutter/widgets.dart';
import 'package:figma/figma.dart' as figma;

class FigmaRendererFactory {
  const FigmaRendererFactory._();

  static Widget createRenderer({
    required final FigmaComponentContext componentContext,
    required final figma.Node node,
  }) {
    final widget = _createBaseRenderer(
      componentContext: componentContext,
      node: node,
    );

    return widget;
  }

  static Widget _createBaseRenderer({
    required final FigmaComponentContext componentContext,
    required final figma.Node node,
  }) =>
      _getRendererForNode(node: node).render(
        rendererContext: componentContext,
        node: node,
      );

  static FigmaRenderer _getRendererForNode({
    required final figma.Node node,
  }) {
    switch (node) {
      case figma.Text _:
        return const FigmaTextRenderer();
      case figma.Rectangle _:
      case figma.Ellipse _:
        return const FigmaShapeRenderer();
      case figma.Vector _:
        return const FigmaVectorRenderer();
      default:
        throw FigmaRendererFactoryException(node.runtimeType);
    }
  }
}

class FigmaRendererFactoryException implements Exception {
  final Type type;

  const FigmaRendererFactoryException(this.type);

  @override
  String toString() => "Cannot find renderer for figma node type: $type";
}
