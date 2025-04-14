// Copyright (c) 2025 Intales Srl. All rights reserved.
// Use of this source code is governed by a MIT license that can be found
// in the LICENSE file.

import 'package:flutter/widgets.dart';
import 'package:morphr_figma/morphr_figma.dart' as figma;

/// A class that represents the context in which a node transformation happens.
///
/// This context provides information about the node being transformed,
/// its parent, siblings, and the current build context.
class TransformContext {
  /// The Flutter build context
  final BuildContext buildContext;

  /// The Figma node being transformed
  final figma.Node node;

  /// Parent node in the Figma hierarchy (null if root)
  final figma.Node? parent;

  /// The default widget that would be created without transformation
  final Widget defaultWidget;

  /// Creates a new transform context.
  const TransformContext({
    required this.buildContext,
    required this.node,
    required this.defaultWidget,
    this.parent,
  });

  /// Creates a copy of this context with some properties replaced.
  TransformContext copyWith({
    BuildContext? buildContext,
    figma.Node? node,
    figma.Node? parent,
    Widget? defaultWidget,
  }) {
    return TransformContext(
      buildContext: buildContext ?? this.buildContext,
      node: node ?? this.node,
      parent: parent ?? this.parent,
      defaultWidget: defaultWidget ?? this.defaultWidget,
    );
  }
}
