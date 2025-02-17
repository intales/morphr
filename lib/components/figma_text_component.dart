// Copyright (c) 2025 Intales Srl. All rights reserved.
// Use of this source code is governed by a MIT license that can be found
// in the LICENSE file.

import 'package:flutter/material.dart';
import 'package:morphr/components/figma_component.dart';
import 'package:morphr/figma_service.dart';
import 'package:morphr/renderers/figma_text_renderer.dart';

class FigmaTextComponent extends FigmaComponent {
  final String componentName;
  final String text;

  const FigmaTextComponent(
    this.componentName, {
    required this.text,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final node = FigmaService.instance.getComponent(componentName);
    if (node == null) {
      throw ArgumentError("$componentName does not exist in figma file.");
    }

    return LayoutBuilder(
      builder: (context, constraints) {
        final parentSize = Size(constraints.maxWidth, constraints.maxHeight);
        return const FigmaTextRenderer().render(
          node: node,
          parentSize: parentSize,
          content: text,
        );
      },
    );
  }
}
