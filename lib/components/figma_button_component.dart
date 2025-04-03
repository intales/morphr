// Copyright (c) 2025 Intales Srl. All rights reserved.
// Use of this source code is governed by a MIT license that can be found
// in the LICENSE file.

import 'package:flutter/widgets.dart';
import 'package:morphr_figma/morphr_figma.dart' as figma;
import 'package:morphr/components/figma_component.dart';
import 'package:morphr/morphr_service.dart';
import 'package:morphr/renderers/figma_shape_renderer.dart';
import 'package:morphr/renderers/figma_text_renderer.dart';

class FigmaButtonComponent extends FigmaComponent {
  final String componentName;
  final VoidCallback onPressed;
  final Widget? child;

  const FigmaButtonComponent(
    this.componentName, {
    required this.onPressed,
    this.child,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final node = MorphrService.instance.getComponent(componentName);
    if (node == null) return SizedBox.shrink();

    return LayoutBuilder(
      builder: (context, constraints) {
        final size = Size(constraints.maxWidth, constraints.maxHeight);

        return GestureDetector(
          onTap: onPressed,
          child: _buildButtonContent(node, size),
        );
      },
    );
  }

  Widget _buildButtonContent(figma.Node node, Size parentSize) {
    if (node is figma.Text) {
      return const FigmaTextRenderer().render(
        node: node,
        parentSize: parentSize,
        content: node.characters ?? '',
      );
    }

    return const FigmaShapeRenderer().render(
      node: node,
      parentSize: parentSize,
      child: child,
    );
  }
}
