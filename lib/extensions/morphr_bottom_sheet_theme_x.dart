import 'package:flutter/material.dart';
import 'package:morphr/adapters/figma_component_adapter.dart';
import 'package:morphr/morphr_service.dart';

extension MorphrBottomSheetThemeDataX on BottomSheetThemeData {
  BottomSheetThemeData morph(String componentName) {
    if (componentName.isEmpty) {
      return this;
    }

    final node = MorphrService.instance.getComponent(componentName);
    if (node == null) return this;

    final component = FigmaComponentAdapter(node);

    try {
      final backgroundColor = component.colors.first;

      final shadows = component.shadows;
      double? elevation;
      Color? shadowColor;
      if (shadows.isNotEmpty) {
        elevation = shadows.first.blurRadius;
        shadowColor = shadows.first.color;
      }

      final borderRadius = component.borderRadius;
      ShapeBorder? shape;
      shape = RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: borderRadius.topLeft,
          topRight: borderRadius.topRight,
        ),
      );

      double? modalBackdropOpacity;
      final isDark =
          ThemeData.estimateBrightnessForColor(backgroundColor) ==
          Brightness.dark;
      modalBackdropOpacity = isDark ? 0.5 : 0.3;

      return copyWith(
        backgroundColor: this.backgroundColor ?? backgroundColor,
        elevation: this.elevation ?? elevation,
        shadowColor: this.shadowColor ?? shadowColor,
        shape: this.shape ?? shape,
        modalElevation: modalElevation ?? elevation,
        modalBarrierColor:
            modalBarrierColor ??
            Colors.black.withValues(alpha: modalBackdropOpacity),
      );
    } catch (_) {
      return this;
    }
  }
}
