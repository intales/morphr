import 'package:flutter/material.dart';
import 'package:morphr/adapters/figma_component_adapter.dart';
import 'package:morphr/extensions/morphr_border_x.dart';
import 'package:morphr/morphr_service.dart';

extension MorphrButtonStyleX on ButtonStyle {
  ButtonStyle morph(String componentName) {
    if (componentName.isEmpty) {
      return this;
    }

    final node = MorphrService.instance.getComponent(componentName);
    if (node == null) return this;

    final component = FigmaComponentAdapter(node);

    try {
      final backgroundColor = component.colors.first;
      final borderRadius = component.borderRadius;
      final border = Border().morph(componentName);
      final shadows = component.shadows;

      OutlinedBorder? shape;
      if (component.shape == BoxShape.circle) {
        shape = const CircleBorder();
      } else if (borderRadius != BorderRadius.zero) {
        shape = RoundedRectangleBorder(
          borderRadius: borderRadius,
          side: border.top,
        );
      }

      double? elevation;
      if (shadows.isNotEmpty) {
        elevation = shadows.first.blurRadius;
      }

      final padding = component.padding;
      final overlayColor = backgroundColor.withValues(alpha: 0.1);

      return copyWith(
        backgroundColor:
            this.backgroundColor ??
            WidgetStatePropertyAll<Color>(backgroundColor),
        overlayColor:
            this.overlayColor ?? WidgetStatePropertyAll<Color>(overlayColor),
        shadowColor:
            shadowColor ??
            (shadows.isNotEmpty
                ? WidgetStatePropertyAll<Color>(shadows.first.color)
                : shadowColor),
        elevation:
            this.elevation ??
            (elevation != null
                ? WidgetStatePropertyAll<double>(elevation)
                : this.elevation),
        padding:
            this.padding ?? WidgetStatePropertyAll<EdgeInsetsGeometry>(padding),
        shape:
            this.shape ??
            (shape != null
                ? WidgetStatePropertyAll<OutlinedBorder>(shape)
                : this.shape),
      );
    } catch (_) {
      return this;
    }
  }
}
