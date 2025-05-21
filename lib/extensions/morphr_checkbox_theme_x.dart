import 'package:flutter/material.dart';
import 'package:morphr/adapters/figma_component_adapter.dart';
import 'package:morphr/extensions/morphr_border_x.dart';
import 'package:morphr/morphr_service.dart';

extension MorphrCheckboxThemeDataX on CheckboxThemeData {
  CheckboxThemeData morph(String componentName) {
    if (componentName.isEmpty) {
      return this;
    }

    final node = MorphrService.instance.getComponent(componentName);
    if (node == null) return this;

    final component = FigmaComponentAdapter(node);

    try {
      final backgroundColor = component.colors.first;
      final side = Border().morph(componentName).top;

      final borderRadius = component.borderRadius;
      OutlinedBorder? shape;
      shape = RoundedRectangleBorder(borderRadius: borderRadius);
      if (component.shape == BoxShape.circle) {
        shape = CircleBorder();
      }

      final splashRadius = component.size.width * 1.2;

      return copyWith(
        fillColor:
            fillColor ??
            WidgetStateProperty.resolveWith((states) {
              if (states.contains(WidgetState.selected)) {
                return backgroundColor;
              }
              return null;
            }),
        splashRadius: this.splashRadius ?? splashRadius,
        shape: this.shape ?? shape,
        side: this.side ?? side,
      );
    } catch (_) {
      return this;
    }
  }
}
