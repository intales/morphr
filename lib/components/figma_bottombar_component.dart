// Copyright (c) 2025 Intales Srl. All rights reserved.
// Use of this source code is governed by a MIT license that can be found
// in the LICENSE file.

import 'package:flutter/widgets.dart';
import 'package:morphr/components/figma_component.dart';
import 'package:morphr/morphr_service.dart';
import 'package:morphr/renderers/figma_bottombar_renderer.dart';

class FigmaBottombarComponent extends FigmaComponent {
  final String componentName;
  final List<Widget> children;

  const FigmaBottombarComponent(
    this.componentName, {
    required this.children,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final node = MorphrService.instance.getComponent(componentName);
    if (node == null) {
      throw ArgumentError("$componentName does not exist in figma file.");
    }

    return LayoutBuilder(builder: (context, constraints) {
      final parentSize = Size(constraints.maxWidth, constraints.maxHeight);
      return const FigmaBottomBarRenderer().render(
        node: node,
        mediaQueryPadding: MediaQuery.of(context).padding,
        parentSize: parentSize,
        children: children,
      );
    });
  }
}
