import 'package:morphr/figma_component_context.dart';
import 'package:morphr/figma_frame_renderer.dart';
import 'package:morphr/figma_node_layout_info.dart';
import 'package:morphr/figma_properties.dart';
import 'package:morphr/figma_renderer.dart';
import 'package:morphr/figma_shape_renderer.dart';
import 'package:morphr/figma_text_renderer.dart';
import 'package:morphr/figma_vector_renderer.dart';
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
    List<Widget> renderedChildren = [];
    List<NodeLayoutInfo> layoutInfos = [];

    if (node is figma.Frame) {
      for (final child in node.children?.nonNulls ?? <figma.Node>[]) {
        final childWidget = render(
          componentContext: componentContext,
          node: child,
        );

        final isInput = child is figma.Text &&
            (componentContext.get<bool>(
                  FigmaProperties.isTextField,
                  nodeId: child.name!,
                ) ??
                false);

        layoutInfos.add(NodeLayoutInfo(
          node: child,
          widget: childWidget,
          isInput: isInput,
        ));
        renderedChildren.add(childWidget);
      }
    }

    final updatedContext = FigmaComponentContext(
      buildContext: componentContext.buildContext,
      properties: {
        ...componentContext.properties,
        if (renderedChildren.isNotEmpty)
          FigmaProperties.children: renderedChildren,
        if (renderedChildren.length == 1)
          FigmaProperties.child: renderedChildren.first,
        if (layoutInfos.isNotEmpty) FigmaProperties.layoutInfo: layoutInfos,
      },
      propertyScopes: componentContext.propertyScopes,
    );

    return FigmaRendererFactory.createBaseRenderer(
      componentContext: updatedContext,
      node: node,
    );
  }
}
