// Copyright (c) 2025 Intales Srl. All rights reserved.
// Use of this source code is governed by a MIT license that can be found
// in the LICENSE file.

import 'package:morphr_figma/morphr_figma.dart' as figma;

/// A strategy for selecting nodes to be transformed.
///
/// This interface defines how nodes are matched for transformation.
abstract class NodeSelector {
  /// Returns true if the node should be selected for transformation.
  bool matches(figma.Node node, figma.Node? parent);
}

/// Selects nodes by their name.
class NameSelector implements NodeSelector {
  /// The name to match against.
  final String name;

  /// Whether the match should be exact or a partial match.
  final bool exact;

  /// Creates a name-based selector.
  ///
  /// If [exact] is true, the node name must match exactly.
  /// If false, the node name only needs to contain the given [name].
  const NameSelector(this.name, {this.exact = true});

  @override
  bool matches(figma.Node node, figma.Node? parent) {
    return exact ? node.name == name : node.name?.contains(name) ?? false;
  }
}

/// Selects nodes by their type.
class TypeSelector implements NodeSelector {
  /// The type to match against.
  final Type type;

  /// Creates a type-based selector.
  const TypeSelector(this.type);

  @override
  bool matches(figma.Node node, figma.Node? parent) {
    return node.runtimeType == type;
  }
}

/// Selects nodes using a custom predicate function.
class PredicateSelector implements NodeSelector {
  /// The predicate function to use for matching.
  final bool Function(figma.Node node, figma.Node? parent) predicate;

  /// Creates a selector using a custom predicate function.
  const PredicateSelector(this.predicate);

  @override
  bool matches(figma.Node node, figma.Node? parent) {
    return predicate(node, parent);
  }
}
