// Copyright (c) 2025 Intales Srl. All rights reserved.
// Use of this source code is governed by a MIT license that can be found
// in the LICENSE file.

import 'package:flutter/widgets.dart';
import 'package:morphr/renderers/figma_text_renderer.dart';
import 'package:morphr/transformers/core/transformers_core.dart';
import 'package:morphr_figma/morphr_figma.dart' as figma;

/// A transformer that replaces text content in a Figma text node.
class TextTransformer extends NodeTransformer {
  /// Creates a transformer that replaces text in a Figma text node.
  ///
  /// The [selector] determines which text nodes to transform.
  /// The [text] is the new content to display.
  TextTransformer({
    required super.selector,
    required String text,
    super.childTransformers = const [],
  }) : super(
         transform: (context, widget) {
           if (context.node is figma.Text) {
             return const FigmaTextRenderer().render(
               node: context.node as figma.Text,
               parentSize: Size.zero,
               content: text,
             );
           }
           return widget;
         },
       );

  /// Factory method to create a text transformer for nodes with a specific name.
  factory TextTransformer.byName(
    String name, {
    required String text,
    bool exact = true,
  }) {
    return TextTransformer(
      selector: NameSelector(name, exact: exact),
      text: text,
    );
  }
}
