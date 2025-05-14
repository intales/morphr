import 'package:flutter/material.dart';
import 'package:morphr/archetypes/widget_archetype.dart';
import 'package:morphr_figma/morphr_figma.dart' as figma;

mixin ContainerCapability {
  Capability get isContainer => (Widget widget) {
    return widget is Container ||
        widget is SizedBox ||
        widget is DecoratedBox ||
        widget is ConstrainedBox ||
        widget is Padding ||
        widget is Align ||
        widget is Center ||
        widget is Card;
  };

  Capability get supportsChild => (Widget widget) {
    return widget is SingleChildRenderObjectWidget ||
        (widget is Container) ||
        (widget is SizedBox) ||
        (widget is Card);
  };

  Widget buildFromContainer(Container container, figma.Node node) {
    // This will be implemented by combining other capabilities
    throw UnimplementedError('Should be overridden by concrete implementation');
  }

  Widget? extractChild(Widget widget) {
    if (widget is Container) return widget.child;
    if (widget is SizedBox) return widget.child;
    if (widget is Padding) return widget.child;
    if (widget is Align) return widget.child;
    if (widget is DecoratedBox) return widget.child;
    if (widget is Card) return widget.child;
    return null;
  }

  Clip? extractClipBehavior(Widget widget) {
    if (widget is Container) return widget.clipBehavior;
    if (widget is Card) return widget.clipBehavior;
    return null;
  }
}
