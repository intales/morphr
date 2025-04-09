// Copyright (c) 2025 Intales Srl. All rights reserved.
// Use of this source code is governed by a MIT license that can be found
// in the LICENSE file.

import 'package:flutter/widgets.dart';
import 'package:morphr/components/figma_component.dart';
import 'package:morphr/morphr_service.dart';
import 'package:morphr/renderers/figma_tree_renderer.dart';
import 'package:morphr/transformers/core/node_transformer.dart';

/// A component that renders an entire Figma component tree recursively.
///
/// This component automatically determines the type of each node in the tree
/// and renders it appropriately, preserving the layout structure.
class FigmaTreeComponent extends FigmaComponent {
  /// The name of the root component in Figma.
  final String componentName;

  /// Optional transformers to customize the rendering behavior.
  final List<NodeTransformer> transformers;

  /// Creates a new FigmaTreeComponent.
  ///
  /// The [componentName] is the name of the Figma component to render.
  /// The [transformers] provide a way to customize the rendering of specific nodes.
  const FigmaTreeComponent(
    this.componentName, {
    this.transformers = const [],
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    // Get the component from the Morphr service
    final node = MorphrService.instance.getComponent(componentName);
    if (node == null) {
      return const SizedBox.shrink();
    }

    // Use the tree renderer to render the entire component tree
    return const FigmaTreeRenderer().render(
      node: node,
      context: context,
      transformers: transformers,
    );
  }
}
