import 'package:flutter/material.dart';
import 'package:morphr/adapters/figma_component_adapter.dart';
import 'package:morphr/morphr_service.dart';

extension MorphrBottomNavigationBarThemeX on BottomNavigationBarThemeData {
  BottomNavigationBarThemeData morph(String componentName) {
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
      if (shadows.isNotEmpty) {
        elevation = shadows.first.blurRadius / 2;
      }

      Color? selectedItemColor;
      Color? unselectedItemColor;
      final brightness = ThemeData.estimateBrightnessForColor(backgroundColor);

      selectedItemColor =
          brightness == Brightness.dark ? Colors.white : Colors.black;

      unselectedItemColor =
          brightness == Brightness.dark
              ? Colors.white.withValues(alpha: 0.6)
              : Colors.black.withValues(alpha: 0.6);

      return copyWith(
        backgroundColor: this.backgroundColor ?? backgroundColor,
        elevation: this.elevation ?? elevation,
        selectedItemColor: this.selectedItemColor ?? selectedItemColor,
        unselectedItemColor: this.unselectedItemColor ?? unselectedItemColor,
      );
    } catch (_) {
      return this;
    }
  }
}
