import 'package:figflow/figma_component_context.dart';
import 'package:figflow/figma_frame_renderer.dart';
import 'package:figflow/figma_properties.dart';
import 'package:figflow/figma_renderer.dart';
import 'package:figflow/figma_shape_renderer.dart';
import 'package:figflow/figma_text_renderer.dart';
import 'package:figflow/figma_vector_renderer.dart';
import 'package:flutter/widgets.dart';
import 'package:figma/figma.dart' as figma;

class FigmaRendererFactory {
  const FigmaRendererFactory._();
  static const _recursiveWrapper = RecursiveRendererWrapper();

  static Widget createRenderer({
    required final FigmaComponentContext componentContext,
    required final figma.Node node,
    final bool recursive = false,
  }) {
    if (!recursive) {
      final widget = createBaseRenderer(
        componentContext: componentContext,
        node: node,
      );

      return widget;
    }

    return _recursiveWrapper.render(
      componentContext: componentContext,
      node: node,
    );
  }

  static Widget createBaseRenderer({
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
      case figma.Frame _:
        return const FigmaFrameRenderer();
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

class RecursiveRendererWrapper {
  const RecursiveRendererWrapper();

  Widget render({
    required FigmaComponentContext componentContext,
    required figma.Node node,
  }) {
    // Se il nodo è un container, renderizza prima i children
    List<Widget> renderedChildren = [];
    if (node is figma.Frame) {
      renderedChildren = node.children?.nonNulls
              .map((child) => render(
                    componentContext: componentContext,
                    node: child,
                  ))
              .toList() ??
          [];
    }

    // Crea un nuovo context con i children renderizzati
    final updatedContext = FigmaComponentContext(
      buildContext: componentContext.buildContext,
      properties: {
        ...componentContext.properties,
        if (renderedChildren.isNotEmpty)
          FigmaProperties.children: renderedChildren,
        if (renderedChildren.length == 1)
          FigmaProperties.child: renderedChildren.first,
      },
      propertyScopes: componentContext.propertyScopes,
    );

    // Usa il renderer esistente con il context aggiornato
    final renderer = FigmaRendererFactory.createBaseRenderer(
      componentContext: updatedContext,
      node: node,
    );
    return renderer;
  }
}
