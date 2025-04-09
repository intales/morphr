// Copyright (c) 2025 Intales Srl. All rights reserved.
// Use of this source code is governed by a MIT license that can be found
// in the LICENSE file.

import 'package:flutter/widgets.dart';
import 'package:morphr/transformers/core/node_selector.dart';
import 'package:morphr/transformers/core/transform_context.dart';
import 'package:morphr_figma/morphr_figma.dart' as figma;

/// A function that transforms a Figma node into a Flutter widget.
typedef NodeTransformerFunction = Widget Function(TransformContext context);

/// A transformer that can modify how a Figma node is rendered as a Flutter widget.
///
/// Node transformers are used to customize how specific nodes in a Figma document
/// are rendered in Flutter. This allows for adding interactivity, dynamic content,
/// or custom rendering logic to specific parts of a design.
class NodeTransformer {
  /// The selector that determines which nodes this transformer applies to.
  final NodeSelector selector;

  /// The function that performs the transformation.
  final NodeTransformerFunction transformer;

  /// Optional transformers to apply to child nodes.
  final List<NodeTransformer> childTransformers;

  /// Creates a node transformer.
  ///
  /// The [selector] determines which nodes this transformer applies to.
  /// The [transformer] defines how to transform matching nodes.
  /// Optional [childTransformers] can be provided to transform child nodes.
  const NodeTransformer({
    required this.selector,
    required this.transformer,
    this.childTransformers = const [],
  });

  /// Checks if this transformer should be applied to the given node.
  bool appliesTo(figma.Node node, figma.Node? parent) {
    return selector.matches(node, parent);
  }

  /// Applies the transformation to the given context.
  Widget transform(TransformContext context) {
    return transformer(context);
  }

  /// Factory method to create a transformer that matches nodes by name.
  factory NodeTransformer.byName(
    String name, {
    required NodeTransformerFunction transformer,
    List<NodeTransformer> childTransformers = const [],
    bool exact = true,
  }) {
    return NodeTransformer(
      selector: NameSelector(name, exact: exact),
      transformer: transformer,
      childTransformers: childTransformers,
    );
  }

  /// Factory method to create a transformer that matches nodes by type.
  factory NodeTransformer.byType(
    Type type, {
    required NodeTransformerFunction transformer,
    List<NodeTransformer> childTransformers = const [],
  }) {
    return NodeTransformer(
      selector: TypeSelector(type),
      transformer: transformer,
      childTransformers: childTransformers,
    );
  }

  /// Factory method to create a transformer with a custom predicate function.
  factory NodeTransformer.custom({
    required bool Function(figma.Node node, figma.Node? parent) predicate,
    required NodeTransformerFunction transformer,
    List<NodeTransformer> childTransformers = const [],
  }) {
    return NodeTransformer(
      selector: PredicateSelector(predicate),
      transformer: transformer,
      childTransformers: childTransformers,
    );
  }
}
