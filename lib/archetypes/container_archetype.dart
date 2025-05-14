import 'package:flutter/material.dart';
import 'package:morphr/archetypes/widget_archetype.dart';
import 'package:morphr/mixins/capabilites_mixins/capabilites_mixins.dart';
import 'package:morphr_figma/morphr_figma.dart' as figma;

class ContainerArchetype extends WidgetArchetype
    with
        ContainerCapability,
        DecorationCapability,
        PaddingCapability,
        SizeCapability,
        CardCapability,
        AlignCapability,
        ContainerBuilderCapability {
  @override
  List<Capability> get requiredCapabilities => [isContainer];

  @override
  List<Capability> get optionalCapabilities => [
    supportsDecoration,
    supportsPadding,
    supportsSize,
    supportsChild,
  ];

  @override
  Widget build(Widget widget, figma.Node node) {
    if (widget is Container) {
      return buildFromContainer(widget, node);
    } else if (widget is SizedBox) {
      return buildFromSizedBox(widget, node);
    } else if (widget is DecoratedBox) {
      return buildFromDecoratedBox(widget, node);
    } else if (widget is Padding) {
      return buildFromPadding(widget, node);
    } else if (widget is Align || widget is Center) {
      return buildFromAlign(widget as Align, node);
    } else if (widget is Card) {
      return buildFromCard(widget, node);
    }

    return widget;
  }
}
