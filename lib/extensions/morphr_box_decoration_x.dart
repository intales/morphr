import 'package:flutter/widgets.dart';
import 'package:morphr/adapters/figma_decoration_adapter.dart';
import 'package:morphr/morphr_service.dart';

extension MorphrBoxDecorationX on BoxDecoration {
  BoxDecoration morph(String componentName) {
    if (componentName.isEmpty) {
      return this;
    }

    final node = MorphrService.instance.getComponent(componentName);
    if (node == null) return this;

    final adapter = FigmaDecorationAdapter(node);
    if (!adapter.supportsDecoration) return this;

    try {
      final decoration = adapter.createBoxDecoration();
      return copyWith(
        color: decoration.color ?? color,
        gradient: decoration.gradient ?? gradient,
        border: decoration.border ?? border,
        boxShadow: decoration.boxShadow ?? boxShadow,
        image: decoration.image ?? image,
        borderRadius: decoration.borderRadius ?? borderRadius,
        shape: decoration.shape,
        backgroundBlendMode:
            decoration.backgroundBlendMode ?? backgroundBlendMode,
      );
    } catch (_) {
      return this;
    }
  }
}
