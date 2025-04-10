// Copyright (c) 2025 Intales Srl. All rights reserved.
// Use of this source code is governed by a MIT license that can be found
// in the LICENSE file.

import 'package:flutter/material.dart';
import 'package:morphr/renderers/figma_flex_renderer.dart';
import 'package:morphr/renderers/figma_shape_renderer.dart';
import 'package:morphr/renderers/figma_text_renderer.dart';
import 'package:morphr/renderers/figma_vector_renderer.dart';
import 'package:morphr/transformers/core/transformers_core.dart';
import 'package:morphr_figma/morphr_figma.dart' as figma;

/// A renderer that can recursively render a Figma node tree into Flutter widgets.
///
/// This renderer automatically determines the type of each node and renders it
/// appropriately, including its children.
class FigmaTreeRenderer {
  const FigmaTreeRenderer();

  /// Renders a Figma node and all its children recursively.
  ///
  /// The [node] is the Figma node to render.
  /// The [context] is the BuildContext for responsive sizing.
  /// The [transformers] list allows customizing the rendering behavior.
  /// The [parent] is the parent node (if any).
  /// The [transformerManager] is used internally for applying transformations.
  Widget render({
    required figma.Node node,
    required BuildContext context,
    List<NodeTransformer> transformers = const [],
    figma.Node? parent,
    TransformerManager? transformerManager,
  }) {
    transformerManager ??= TransformerManager(transformers: transformers);

    try {
      Widget baseWidget = _createBaseWidget(node, context);
      final children = _getChildNodes(node);

      final transformContext = TransformContext(
        buildContext: context,
        node: node,
        parent: parent,
        defaultWidget: baseWidget,
      );

      final transformedWidget = transformerManager.transformNode(
        buildContext: context,
        node: node,
        parent: parent,
        defaultWidget: baseWidget,
        transformContext: transformContext,
      );

      if (transformedWidget != baseWidget) {
        return transformedWidget;
      }

      if (children != null && children.isNotEmpty) {
        final childTransformers = transformerManager.getChildTransformers(
          node,
          parent,
        );

        final childWidgets = <Widget>[];
        for (final child in children) {
          if (child != null) {
            childWidgets.add(
              render(
                node: child,
                context: context,
                transformers: childTransformers,
                parent: node,
                transformerManager: transformerManager,
              ),
            );
          }
        }

        if (childWidgets.isNotEmpty) {
          return _combineWithChildren(baseWidget, node, childWidgets);
        }
      }

      return baseWidget;
    } catch (e, stackTrace) {
      debugPrint('Error rendering node: $e');
      debugPrint('Stack trace: $stackTrace');
      return SizedBox(
        width: 50,
        height: 50,
        child: ColoredBox(color: Colors.red.withValues(alpha: 0.3)),
      );
    }
  }

  /// Creates the base widget for a node without children.
  Widget _createBaseWidget(figma.Node node, BuildContext context) {
    try {
      if (node is figma.Text) {
        return _renderText(node);
      } else if (node is figma.Vector) {
        return _renderVector(node);
      } else {
        // Frame, Rectangle, Group, Instance, etc. are treated as containers
        return _renderContainer(node);
      }
    } catch (e) {
      debugPrint('Error rendering node: $e');
      return SizedBox(
        width: 50,
        height: 50,
        child: ColoredBox(color: Colors.red.withValues(alpha: 0.3)),
      );
    }
  }

  /// Renders a text node.
  Widget _renderText(figma.Text node) {
    return const FigmaTextRenderer().render(
      node: node,
      parentSize: Size.zero,
      content: node.characters ?? '',
    );
  }

  /// Renders a vector node.
  Widget _renderVector(figma.Vector node) {
    return const FigmaVectorRenderer().render(
      node: node,
      parentSize: Size.zero,
    );
  }

  /// Renders a container node (Frame, Rectangle, Group, etc.)
  Widget _renderContainer(figma.Node node) {
    return const FigmaShapeRenderer().render(
      node: node,
      parentSize: Size.zero,
      child: null,
    );
  }

  /// Gets the child nodes of a container node.
  List<figma.Node?>? _getChildNodes(figma.Node node) {
    if (node is figma.Frame) return node.children;
    if (node is figma.Group) return node.children;
    if (node is figma.Instance) return node.children;
    return null;
  }

  /// Combines the base widget with its children according to layout.
  Widget _combineWithChildren(
    Widget baseWidget,
    figma.Node node,
    List<Widget> children,
  ) {
    return const FigmaFlexRenderer().render(
      node: node,
      parentSize: Size.zero,
      children: children,
    );
  }
}
