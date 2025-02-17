// Copyright (c) 2025 Intales Srl. All rights reserved.
// Use of this source code is governed by a MIT license that can be found
// in the LICENSE file.

import 'package:flutter/widgets.dart';
import 'package:morphr/components/figma_component.dart';
import 'package:morphr/morphr_service.dart';
import 'package:morphr/renderers/figma_vector_renderer.dart';

class FigmaIconComponent extends FigmaComponent {
  final String componentName;

  const FigmaIconComponent(
    this.componentName, {
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final node = MorphrService.instance.getComponent(componentName);
    if (node == null) {
      throw ArgumentError("$componentName does not exist in figma file.");
    }

    return LayoutBuilder(
      builder: (context, constraints) {
        final parentSize = Size(constraints.maxWidth, constraints.maxHeight);
        return const FigmaVectorRenderer().render(
          node: node,
          parentSize: parentSize,
        );
      },
    );
  }
}
