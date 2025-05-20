import 'package:flutter/material.dart';
import 'package:morphr/adapters/figma_component_adapter.dart';
import 'package:morphr/morphr_service.dart';

extension MorphrBorderRadiusX on BorderRadius {
  BorderRadius morph(String componentName) {
    if (componentName.isEmpty) {
      return this;
    }

    final node = MorphrService.instance.getComponent(componentName);
    if (node == null) return this;

    final component = FigmaComponentAdapter(node);

    try {
      return component.borderRadius;
    } catch (_) {
      return this;
    }
  }
}
