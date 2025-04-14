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
///
/// The hierarchical structure of NodeTransformer allows defining transformations
/// that apply to both the selected node and its children, creating a clear
/// parent-child relationship similar to Flutter's widget tree.
///
/// Example usage:
/// ```dart
/// NodeTransformer(
///   selector: NameSelector("todo_card"),
///   transform: (context, widget) => GestureDetector(
///     onTap: () => print("Card tapped"),
///     child: widget,
///   ),
///   childTransformers: [
///     NodeTransformer(
///       selector: NameSelector("todo_title"),
///       transform: (context, widget) => Text("New Title"),
///     ),
///     NodeTransformer(
///       selector: NameSelector("todo_description"),
///       transform: (context, widget) => Text("New Description"),
///     ),
///   ],
/// )
/// ```
class NodeTransformer {
  /// The selector that determines which nodes this transformer applies to.
  final NodeSelector selector;

  /// The function that performs the transformation on the selected node.
  ///
  /// This function takes the transformation context and the default widget,
  /// and returns a new widget that replaces or modifies the default one.
  final Widget Function(TransformContext context, Widget widget) transform;

  /// Transformers to apply to child nodes of the selected node.
  ///
  /// These transformers will only be applied to nodes that are children
  /// of the node that matched this transformer's selector.
  final List<NodeTransformer> childTransformers;

  /// Creates a node transformer.
  ///
  /// The [selector] determines which nodes this transformer applies to.
  /// The [transform] defines how to transform matching nodes.
  /// Optional [childTransformers] can be provided to transform child nodes.
  const NodeTransformer({
    required this.selector,
    required this.transform,
    this.childTransformers = const [],
  });

  /// Checks if this transformer should be applied to the given node.
  bool appliesTo(figma.Node node, figma.Node? parent) {
    return selector.matches(node, parent);
  }

  /// Applies the transformation to the given context.
  Widget applyTransform(TransformContext context) {
    return transform(context, context.defaultWidget);
  }

  /// Factory method to create a transformer that matches nodes by name.
  factory NodeTransformer.byName(
    String name, {
    required Widget Function(TransformContext, Widget) transform,
    List<NodeTransformer> childTransformers = const [],
    bool exact = true,
  }) {
    return NodeTransformer(
      selector: NameSelector(name, exact: exact),
      transform: transform,
      childTransformers: childTransformers,
    );
  }

  /// Factory method to create a transformer that matches nodes by type.
  factory NodeTransformer.byType(
    Type type, {
    required Widget Function(TransformContext, Widget) transform,
    List<NodeTransformer> childTransformers = const [],
  }) {
    return NodeTransformer(
      selector: TypeSelector(type),
      transform: transform,
      childTransformers: childTransformers,
    );
  }

  /// Factory method to create a transformer with a custom predicate function.
  factory NodeTransformer.custom({
    required bool Function(figma.Node node, figma.Node? parent) predicate,
    required Widget Function(TransformContext, Widget) transform,
    List<NodeTransformer> childTransformers = const [],
  }) {
    return NodeTransformer(
      selector: PredicateSelector(predicate),
      transform: transform,
      childTransformers: childTransformers,
    );
  }
}
