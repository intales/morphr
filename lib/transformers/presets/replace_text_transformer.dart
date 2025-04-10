// Copyright (c) 2025 Intales Srl. All rights reserved.
// Use of this source code is governed by a MIT license that can be found
// in the LICENSE file.

import 'package:flutter/widgets.dart';
import 'package:morphr/renderers/figma_text_renderer.dart';
import 'package:morphr/transformers/core/node_transformer.dart';
import 'package:morphr_figma/morphr_figma.dart' as figma;

/// Creates a transformer that replaces the text content of a text node.
NodeTransformer replaceText(
  String nodeName,
  String newText, {
  List<NodeTransformer> childTransformers = const [],
}) {
  return NodeTransformer.byName(
    nodeName,
    transformer: (context) {
      if (context.node is! figma.Text) {
        return context.defaultWidget;
      }

      return const FigmaTextRenderer().render(
        node: context.node as figma.Text,
        parentSize: Size.zero,
        content: newText,
      );
    },
    childTransformers: childTransformers,
  );
}
