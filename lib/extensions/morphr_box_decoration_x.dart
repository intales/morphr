import 'package:flutter/widgets.dart';
import 'package:morphr/adapters/figma_component_adapter.dart';
import 'package:morphr/extensions/morphr_border_x.dart';
import 'package:morphr/morphr_service.dart';

extension MorphrBoxDecorationX on BoxDecoration {
  BoxDecoration morph(String componentName) {
    if (componentName.isEmpty) {
      return this;
    }

    final node = MorphrService.instance.getComponent(componentName);
    if (node == null) return this;

    final component = FigmaComponentAdapter(node);

    try {
      return copyWith(
        color: color ?? component.colors.first,
        gradient: gradient ?? component.gradients.first,
        border: border ?? Border().morph(componentName),
        boxShadow: boxShadow ?? component.shadows,
        image: image,
        borderRadius:
            borderRadius ??
            (component.shape != BoxShape.circle
                ? component.borderRadius
                : null),
        shape: component.shape,
        backgroundBlendMode: backgroundBlendMode,
      );
    } catch (_) {
      return this;
    }
  }
}
