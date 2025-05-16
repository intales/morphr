import 'package:flutter/material.dart';
import 'package:morphr/adapters/figma_decoration_adapter.dart';
import 'package:morphr/morphr_service.dart';
import 'package:morphr_figma/morphr_figma.dart' as figma;

extension MorphrNavigationRailThemeDataX on NavigationRailThemeData {
  NavigationRailThemeData morph(String componentName) {
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

      Color? selectedIconColor;
      Color? unselectedIconColor;
      Color? indicatorColor;

      if (backgroundColor != null) {
        final brightness = ThemeData.estimateBrightnessForColor(
          backgroundColor,
        );

        if (brightness == Brightness.dark) {
          selectedIconColor = Colors.white;
          unselectedIconColor = Colors.white.withValues(alpha: 0.6);
          indicatorColor = Colors.white.withValues(alpha: 0.3);
        } else {
          selectedIconColor = Colors.black;
          unselectedIconColor = Colors.black.withValues(alpha: 0.6);
          indicatorColor = Colors.black.withValues(alpha: 0.2);
        }
      }

      if (decoration.border != null) {
        indicatorColor = decoration.border!.top.color;
      }

      final List<BoxShadow>? shadows = decoration.boxShadow;
      double? elevation;
      if (shadows != null && shadows.isNotEmpty) {
        elevation = shadows.first.blurRadius / 2;
      }

      double? minWidth;
      double? minExtendedWidth;
      if (node is figma.Frame ||
          node is figma.Instance ||
          node is figma.Rectangle) {
        double? width;

        if (node is figma.Frame) {
          width = node.absoluteBoundingBox?.width?.toDouble();
        } else if (node is figma.Rectangle) {
          width = node.absoluteBoundingBox?.width?.toDouble();
        } else if (node is figma.Instance) {
          width = node.absoluteBoundingBox?.width?.toDouble();
        }

        if (width != null && width > 0) {
          minWidth = width;
          minExtendedWidth = width * 3;
        }
      }

      final BorderRadius? borderRadius =
          decoration.borderRadius as BorderRadius?;
      ShapeBorder? indicatorShape;
      if (borderRadius != null) {
        indicatorShape = RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            topRight: borderRadius.topRight,
            bottomRight: borderRadius.bottomRight,
          ),
        );
      }

      double? groupAlignment;
      if (node is figma.Frame) {
        final topPadding = node.paddingTop.toDouble();
        if (topPadding > 0) {
          groupAlignment = -1.0 + (topPadding / 100);
        }
      } else if (node is figma.Instance) {
        final topPadding = node.paddingTop.toDouble();
        if (topPadding > 0) {
          groupAlignment = -1.0 + (topPadding / 100);
        }
      }

      return copyWith(
        backgroundColor: this.backgroundColor ?? backgroundColor,
        elevation: this.elevation ?? elevation,
        selectedIconTheme:
            selectedIconTheme ??
            (selectedIconColor != null
                ? IconThemeData(color: selectedIconColor)
                : null),
        unselectedIconTheme:
            unselectedIconTheme ??
            (unselectedIconColor != null
                ? IconThemeData(color: unselectedIconColor)
                : null),
        indicatorColor: this.indicatorColor ?? indicatorColor,
        indicatorShape: this.indicatorShape ?? indicatorShape,
        labelType: labelType ?? NavigationRailLabelType.none,
        minWidth: this.minWidth ?? minWidth,
        minExtendedWidth: this.minExtendedWidth ?? minExtendedWidth,
        groupAlignment: this.groupAlignment ?? groupAlignment,
      );
    } catch (_) {
      return this;
    }
  }
}
