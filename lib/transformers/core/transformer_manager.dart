// Copyright (c) 2025 Intales Srl. All rights reserved.
// Use of this source code is governed by a MIT license that can be found
// in the LICENSE file.

import 'package:flutter/widgets.dart';
import 'package:morphr/transformers/core/node_transformer.dart';
import 'package:morphr/transformers/core/transform_context.dart';
import 'package:morphr_figma/morphr_figma.dart' as figma;

/// A manager that applies transformations to a Figma node tree.
///
/// This class applies a list of transformers to a tree of Figma nodes,
/// producing a Flutter widget tree.
class TransformerManager {
  /// The list of transformers to apply.
  final List<NodeTransformer> transformers;

  /// Creates a transformer manager with the given transformers.
  const TransformerManager({required this.transformers});

  /// Applies transformations to the given node and its children.
  ///
  /// Returns a Flutter widget that represents the transformed node tree.
  Widget transformNode({
    required BuildContext buildContext,
    required figma.Node node,
    required figma.Node? parent,
    required Widget defaultWidget,
    List<NodeTransformer>? overrideTransformers,
    TransformContext? transformContext,
  }) {
    final applicableTransformers =
        (overrideTransformers ?? transformers)
            .where((t) => t.appliesTo(node, parent))
            .toList();

    if (applicableTransformers.isEmpty) {
      return defaultWidget;
    }

    final context =
        transformContext ??
        TransformContext(
          buildContext: buildContext,
          node: node,
          parent: parent,
          defaultWidget: defaultWidget,
        );

    Widget result = defaultWidget;
    for (final transformer in applicableTransformers) {
      try {
        final updatedContext = context.copyWith(defaultWidget: result);

        result = transformer.transform(updatedContext, result);
      } catch (e) {
        debugPrint('Error applying transformer to ${node.name}: $e');
      }
    }

    return result;
  }

  /// Gets the child transformers for a specific node.
  ///
  /// Returns the child transformers from the first transformer that applies to the node,
  /// or an empty list if no transformer applies or the applicable transformer has no child transformers.
  List<NodeTransformer> getChildTransformers(
    figma.Node node,
    figma.Node? parent,
  ) {
    for (final transformer in transformers) {
      if (transformer.appliesTo(node, parent)) {
        return transformer.childTransformers;
      }
    }
    return [];
  }
}
