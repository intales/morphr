// Copyright (c) 2025 Intales Srl. All rights reserved.
// Use of this source code is governed by a MIT license that can be found
// in the LICENSE file.

import 'package:flutter/widgets.dart';
import 'package:morphr/components/figma_component.dart';
import 'package:morphr/transformers/core/node_transformer.dart';

/// Creates a transformer that converts a Figma frame into a dynamic list.
///
/// This transformer uses a template item from the Figma design and renders
/// it multiple times based on a data source provided by the caller.
///
/// Parameters:
/// - [nodeName]: The name of the Figma frame that contains the list.
/// - [items]: The data source driving the list.
/// - [itemBuilder]: A function that builds each item widget using the template and data.
/// - [scrollDirection]: Optional scroll direction (defaults to vertical).
/// - [childTransformers]: Optional transformers to apply to child nodes.
/// - [emptyBuilder]: Optional builder for when the list is empty.
/// - [exact]: Whether the node name should match exactly.
///
/// Example usage:
/// ```dart
/// FigmaComponent.tree(
///   "main_page",
///   transformers: [
///     dynamicList(
///       "todos_list",
///       items: todoItems,
///       itemBuilder: (context, template, index, item) {
///         return FigmaComponent.tree(
///           template.name,
///           transformers: [
///             replaceText("title", item.title),
///             replaceText("description", item.description),
///           ],
///         );
///       },
///     ),
///   ],
/// )
/// ```
NodeTransformer listTransformer<T>(
  String nodeName, {
  required List<T> items,
  required Widget Function(BuildContext context, int index, T item) itemBuilder,
  Axis scrollDirection = Axis.vertical,
  List<NodeTransformer> childTransformers = const [],
  WidgetBuilder? emptyBuilder,
  bool exact = true,
  bool expand = false,
  bool shrinkWrap = false,
}) {
  return NodeTransformer.byName(
    nodeName,
    exact: exact,
    transformer: (context) {
      if (items.isEmpty && emptyBuilder != null) {
        return emptyBuilder(context.buildContext);
      }

      Widget widget = FigmaComponent.list(
        nodeName,
        itemCount: items.length,
        itemBuilder: (listContext, index) {
          return itemBuilder(listContext, index, items[index]);
        },
        shrinkWrap: shrinkWrap,
        scrollDirection: scrollDirection,
      );

      if (expand) widget = Expanded(child: widget);
      return widget;
    },
    childTransformers: childTransformers,
  );
}
