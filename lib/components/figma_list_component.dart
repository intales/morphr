// Copyright (c) 2025 Intales Srl. All rights reserved.
// Use of this source code is governed by a MIT license that can be found
// in the LICENSE file.

import 'package:flutter/widgets.dart';
import 'package:morphr/components/figma_component.dart';
import 'package:morphr/morphr_service.dart';
import 'package:morphr/renderers/figma_list_renderer.dart';

class FigmaListComponent extends FigmaComponent {
  final String componentName;
  final int itemCount;
  final IndexedWidgetBuilder itemBuilder;
  final Axis scrollDirection;
  final bool shrinkWrap;

  const FigmaListComponent(
    this.componentName, {
    required this.itemCount,
    required this.itemBuilder,
    this.scrollDirection = Axis.vertical,
    this.shrinkWrap = false,
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
        return const FigmaListRenderer().render(
          node: node,
          parentSize: parentSize,
          itemCount: itemCount,
          itemBuilder: itemBuilder,
          scrollDirection: scrollDirection,
          shrinkWrap: shrinkWrap,
        );
      },
    );
  }
}
