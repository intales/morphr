import 'package:flutter/material.dart';
import 'package:morphr/adapters/figma_decoration_adapter.dart';
import 'package:morphr/morphr_service.dart';

extension MorphrBottomSheetThemeDataX on BottomSheetThemeData {
  BottomSheetThemeData morph(String componentName) {
    if (componentName.isEmpty) {
      return this;
    }

    final node = MorphrService.instance.getComponent(componentName);
    if (node == null) return this;

    final decorationAdapter = FigmaDecorationAdapter(node);

    if (!decorationAdapter.supportsDecoration) {
      return this;
    }

    try {
      final decoration = decorationAdapter.createBoxDecoration();

      final Color? backgroundColor = decoration.color;

      final List<BoxShadow>? shadows = decoration.boxShadow;
      double? elevation;
      Color? shadowColor;
      if (shadows != null && shadows.isNotEmpty) {
        elevation = shadows.first.blurRadius;
        shadowColor = shadows.first.color;
      }

      final BorderRadius? borderRadius =
          decoration.borderRadius as BorderRadius?;
      ShapeBorder? shape;
      if (borderRadius != null) {
        shape = RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            topLeft: borderRadius.topLeft,
            topRight: borderRadius.topRight,
          ),
        );
      }

      double? modalBackdropOpacity;
      if (backgroundColor != null) {
        final isDark =
            ThemeData.estimateBrightnessForColor(backgroundColor) ==
            Brightness.dark;
        modalBackdropOpacity = isDark ? 0.5 : 0.3;
      }

      return copyWith(
        backgroundColor: this.backgroundColor ?? backgroundColor,
        elevation: this.elevation ?? elevation,
        shadowColor: this.shadowColor ?? shadowColor,
        shape: this.shape ?? shape,
        modalElevation: modalElevation ?? elevation,
        modalBarrierColor:
            modalBarrierColor ??
            (modalBackdropOpacity != null
                ? Colors.black.withValues(alpha: modalBackdropOpacity)
                : null),
      );
    } catch (_) {
      return this;
    }
  }
}
