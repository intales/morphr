import 'package:flutter/material.dart';
import 'package:morphr/adapters/figma_decoration_adapter.dart';
import 'package:morphr/adapters/figma_layout_adapter.dart';
import 'package:morphr_figma/morphr_figma.dart' as figma;

mixin ContainerBuilderCapability {
  // Requires these capabilities to be implemented by other mixins
  Widget? extractChild(Widget widget);
  EdgeInsets? extractMargin(Widget widget);
  AlignmentGeometry? extractAlignment(Widget widget);
  BoxConstraints? extractConstraints(Widget widget);
  Clip? extractClipBehavior(Widget widget);
  double? extractWidth(figma.Node node);
  double? extractHeight(figma.Node node);

  Widget buildFromContainer(Container container, figma.Node node) {
    final figmaDecoration = FigmaDecorationAdapter(node);
    final figmaLayout = FigmaLayoutAdapter(node);

    return Container(
      key: container.key,
      alignment: container.alignment,
      padding:
          figmaLayout.padding != EdgeInsets.zero
              ? figmaLayout.padding
              : container.padding,
      color: figmaDecoration.supportsDecoration ? null : container.color,
      decoration:
          figmaDecoration.supportsDecoration
              ? figmaDecoration.createBoxDecoration()
              : container.decoration,
      foregroundDecoration: container.foregroundDecoration,
      width: extractWidth(node) ?? container.constraints?.maxWidth,
      height: extractHeight(node) ?? container.constraints?.maxHeight,
      constraints: container.constraints,
      margin: container.margin,
      transform: container.transform,
      transformAlignment: container.transformAlignment,
      clipBehavior: container.clipBehavior,
      child: container.child,
    );
  }
}
