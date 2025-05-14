import 'package:flutter/material.dart';
import 'package:morphr/adapters/figma_decoration_adapter.dart';
import 'package:morphr/archetypes/widget_archetype.dart';
import 'package:morphr_figma/morphr_figma.dart' as figma;

mixin DecorationCapability {
  Capability get supportsDecoration => (Widget widget) {
    return widget is Container || widget is DecoratedBox || widget is Card;
  };

  BoxDecoration extractDecoration(figma.Node node) {
    final figmaDecoration = FigmaDecorationAdapter(node);
    return figmaDecoration.createBoxDecoration();
  }

  Widget buildFromDecoratedBox(DecoratedBox decoratedBox, figma.Node node) {
    final figmaDecoration = FigmaDecorationAdapter(node);

    return DecoratedBox(
      key: decoratedBox.key,
      decoration:
          figmaDecoration.supportsDecoration
              ? figmaDecoration.createBoxDecoration()
              : decoratedBox.decoration,
      position: decoratedBox.position,
      child: decoratedBox.child,
    );
  }

  Color? extractBackgroundColor(figma.Node node) {
    final figmaDecoration = FigmaDecorationAdapter(node);
    final decoration = figmaDecoration.createBoxDecoration();
    return decoration.color;
  }

  Color? extractShadowColor(figma.Node node) {
    final figmaDecoration = FigmaDecorationAdapter(node);
    final decoration = figmaDecoration.createBoxDecoration();
    final shadows = decoration.boxShadow;
    if (shadows != null && shadows.isNotEmpty) {
      return shadows.first.color;
    }
    return null;
  }

  double? extractElevation(figma.Node node) {
    final figmaDecoration = FigmaDecorationAdapter(node);
    final decoration = figmaDecoration.createBoxDecoration();
    final shadows = decoration.boxShadow;
    if (shadows != null && shadows.isNotEmpty) {
      // Elevation is roughly equivalent to the blur radius in Material Design
      return shadows.first.blurRadius;
    }
    return null;
  }

  ShapeBorder? extractShape(figma.Node node) {
    final figmaDecoration = FigmaDecorationAdapter(node);
    final decoration = figmaDecoration.createBoxDecoration();

    if (decoration.borderRadius != null) {
      return RoundedRectangleBorder(
        borderRadius: decoration.borderRadius as BorderRadius,
        side:
            decoration.border != null
                ? BorderSide(
                  color: decoration.border?.top.color ?? Colors.transparent,
                  width: decoration.border?.top.width ?? 0,
                )
                : BorderSide.none,
      );
    }

    if (decoration.border != null) {
      return Border.all(
            color: decoration.border?.top.color ?? Colors.transparent,
            width: decoration.border?.top.width ?? 0,
          )
          as ShapeBorder;
    }

    return null;
  }
}
