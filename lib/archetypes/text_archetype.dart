import 'package:flutter/material.dart';
import 'package:morphr/archetypes/widget_archetype.dart';
import 'package:morphr/mixins/capabilites_mixins/capabilites_mixins.dart';
import 'package:morphr_figma/morphr_figma.dart' as figma;

class TextArchetype extends WidgetArchetype with TextCapability {
  @override
  List<Capability> get requiredCapabilities => [isText];

  @override
  List<Capability> get optionalCapabilities => [];

  @override
  Widget build(Widget widget, figma.Node node) {
    if (widget is Text) {
      return buildFromText(widget, node);
    } else if (widget is RichText) {
      return buildFromRichText(widget, node);
    }

    return widget;
  }
}
