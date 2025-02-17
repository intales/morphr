// Copyright (c) 2025 Intales Srl. All rights reserved.
// Use of this source code is governed by a MIT license that can be found
// in the LICENSE file.

import 'package:flutter/material.dart';
import 'package:morphr/components/figma_component.dart';
import 'package:morphr/figma_service.dart';
import 'package:morphr/renderers/figma_text_field_renderer.dart';

class FigmaTextFieldComponent extends FigmaComponent {
  final String componentName;
  final TextEditingController? controller;
  final ValueChanged<String>? onChanged;
  final ValueChanged<String>? onSubmitted;
  final String? hint;

  const FigmaTextFieldComponent(
    this.componentName, {
    this.controller,
    this.onChanged,
    this.onSubmitted,
    this.hint,
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
        return FigmaTextFieldRenderer().render(
          node,
          parentSize,
          controller: controller,
          onChanged: onChanged,
          onSubmitted: onSubmitted,
          hint: hint,
        );
      },
    );
  }
}
