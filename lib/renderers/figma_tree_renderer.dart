// Copyright (c) 2025 Intales Srl. All rights reserved.
// Use of this source code is governed by a MIT license that can be found
// in the LICENSE file.

import 'package:flutter/material.dart';
import 'package:morphr/renderers/figma_flex_renderer.dart';
import 'package:morphr/renderers/figma_shape_renderer.dart';
import 'package:morphr/renderers/figma_text_renderer.dart';
import 'package:morphr/renderers/figma_vector_renderer.dart';
import 'package:morphr/transformers/core/node_transformer.dart';
import 'package:morphr/transformers/core/transformer_manager.dart';
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
    // Initialize or reuse transformer manager
    transformerManager ??= TransformerManager(transformers: transformers);

    try {
      // First, create the base widget according to node type
      Widget baseWidget = _createBaseWidget(node, context);

      // Apply transformations if any
      final Widget transformedWidget = transformerManager.transformNode(
        buildContext: context,
        node: node,
        parent: parent,
        defaultWidget: baseWidget,
      );

      // If the widget was transformed and we're not going to process children,
      // return it as is
      if (transformedWidget != baseWidget) {
        // Check if the node has no children or if it's a leaf node type
        if (_getChildNodes(node) == null || _getChildNodes(node)!.isEmpty) {
          return transformedWidget;
        }
      }

      // Then, render children recursively if available
      final children = _getChildNodes(node);
      if (children != null && children.isNotEmpty) {
        // Get child transformers for this node
        final childTransformers = transformerManager.getChildTransformers(
          node,
          parent,
        );

        // Create list of rendered children
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

        // Combine with children according to layout
        if (childWidgets.isNotEmpty) {
          // If the node was transformed, wrap the children with it
          if (transformedWidget != baseWidget) {
            // This is simplified and might need adjustment based on how
            // you want transformed parents to interact with their children
            return _combineWithChildren(transformedWidget, node, childWidgets);
          }

          // Otherwise combine the base widget with children
          return _combineWithChildren(baseWidget, node, childWidgets);
        }
      }

      // If there are no children to process, return the transformed widget
      return transformedWidget;
    } catch (e, stackTrace) {
      // If rendering fails, return a placeholder with error info
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
    // Determine node type and render accordingly
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
      // If rendering fails, return a placeholder with error info
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
    // Use the existing text renderer
    return const FigmaTextRenderer().render(
      node: node,
      parentSize: Size.zero, // Size will be determined by the text
      content: node.characters ?? '',
    );
  }

  /// Renders a vector node.
  Widget _renderVector(figma.Vector node) {
    // Use the existing vector renderer
    return const FigmaVectorRenderer().render(
      node: node,
      parentSize: Size.zero, // Parent size doesn't matter for vector rendering
    );
  }

  /// Renders a container node (Frame, Rectangle, Group, etc.)
  Widget _renderContainer(figma.Node node) {
    // Use the existing shape renderer
    return const FigmaShapeRenderer().render(
      node: node,
      parentSize: Size.zero, // The size will be determined by the renderer
      child: null, // Children will be added separately
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
