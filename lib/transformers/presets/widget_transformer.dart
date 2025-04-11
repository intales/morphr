// Copyright (c) 2025 Intales Srl. All rights reserved.
// Use of this source code is governed by a MIT license that can be found
// in the LICENSE file.

import 'package:flutter/widgets.dart';
import 'package:morphr/transformers/core/transformers_core.dart';

/// Creates a transformer that completely replaces a Figma node with a custom widget.
///
/// Unlike other transformers that modify or enhance existing nodes, this transformer
/// completely replaces the node with a new widget, allowing for full customization.
///
/// Parameters:
/// - [nodeName]: The name of the node to replace
/// - [builder]: Builder function that returns the replacement widget
/// - [exact]: Whether the node name should match exactly
///
/// Example:
/// ```dart
/// widgetTransformer(
///   "todos_list",
///   builder: (context) {
///     return ListView.builder(
///       itemCount: todos.length,
///       itemBuilder: (context, index) {
///         return FigmaComponent.tree(
///           "todo_item",
///           transformers: [
///             replaceText("title", todos[index].title),
///             replaceText("description", todos[index].description),
///           ],
///         );
///       },
///     );
///   },
/// )
/// ```
NodeTransformer widgetTransformer(
  String nodeName, {
  required WidgetBuilder builder,
  bool exact = true,
}) {
  return NodeTransformer.byName(
    nodeName,
    exact: exact,
    transformer: (context) {
      return builder(context.buildContext);
    },
  );
}
