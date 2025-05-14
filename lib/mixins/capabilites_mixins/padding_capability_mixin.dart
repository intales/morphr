import 'package:flutter/material.dart';
import 'package:morphr/adapters/figma_layout_adapter.dart';
import 'package:morphr/archetypes/widget_archetype.dart';
import 'package:morphr_figma/morphr_figma.dart' as figma;

mixin PaddingCapability {
  Capability get supportsPadding => (Widget widget) {
    return widget is Container || widget is Padding;
  };

  EdgeInsets extractPadding(figma.Node node) {
    final figmaLayout = FigmaLayoutAdapter(node);
    return figmaLayout.padding;
  }

  Widget buildFromPadding(Padding padding, figma.Node node) {
    final figmaLayout = FigmaLayoutAdapter(node);

    return Padding(
      key: padding.key,
      padding:
          figmaLayout.padding != EdgeInsets.zero
              ? figmaLayout.padding
              : padding.padding,
      child: padding.child,
    );
  }

  EdgeInsets? extractMargin(Widget widget) {
    final margin =
        widget is Container
            ? widget.margin
            : widget is Card
            ? widget.margin
            : null;
    return margin?.resolve(TextDirection.ltr);
  }
}
