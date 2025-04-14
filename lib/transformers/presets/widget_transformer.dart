// Copyright (c) 2025 Intales Srl. All rights reserved.
// Use of this source code is governed by a MIT license that can be found
// in the LICENSE file.

import 'package:flutter/widgets.dart';
import 'package:morphr/transformers/core/transformers_core.dart';

/// A transformer that replaces a Figma node with a completely custom widget.
class WidgetTransformer extends NodeTransformer {
  /// Creates a transformer that replaces a Figma node with a custom widget.
  ///
  /// The [selector] determines which nodes to replace.
  /// The [builder] creates the replacement widget.
  WidgetTransformer({
    required super.selector,
    required WidgetBuilder builder,
    super.childTransformers = const [],
  }) : super(transform: (context, widget) => builder(context.buildContext));

  /// Factory method to create a widget transformer for nodes with a specific name.
  factory WidgetTransformer.byName(
    String name, {
    required WidgetBuilder builder,
    bool exact = true,
  }) {
    return WidgetTransformer(
      selector: NameSelector(name, exact: exact),
      builder: builder,
    );
  }
}
