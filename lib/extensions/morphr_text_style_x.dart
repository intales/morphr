import 'package:flutter/widgets.dart';
import 'package:morphr/adapters/figma_text_adapter.dart';
import 'package:morphr/morphr_service.dart';

extension MorphrTextStyleX on TextStyle {
  TextStyle morph(String componentName) {
    if (componentName.isEmpty) {
      return this;
    }

    final node = MorphrService.instance.getComponent(componentName);
    if (node == null) return this;

    final adapter = FigmaTextAdapter(node);
    if (!adapter.supportsText) return this;

    try {
      return adapter.createTextStyle()?.merge(this) ?? this;
    } catch (_) {
      return this;
    }
  }
}
