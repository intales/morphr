import 'package:flutter/material.dart';
import 'package:morphr/archetypes/widget_archetype.dart';
import 'package:morphr/mixins/capabilites_mixins/capabilites_mixins.dart';
import 'package:morphr_figma/morphr_figma.dart' as figma;

class ButtonArchetype extends WidgetArchetype with ButtonCapability {
  @override
  List<Capability> get requiredCapabilities => [isButton];

  @override
  List<Capability> get optionalCapabilities => [];

  @override
  Widget build(Widget widget, figma.Node node) {
    if (widget is ElevatedButton) {
      return buildFromElevatedButton(widget, node);
    } else if (widget is TextButton) {
      return buildFromTextButton(widget, node);
    } else if (widget is OutlinedButton) {
      return buildFromOutlinedButton(widget, node);
    } else if (widget is IconButton) {
      return buildFromIconButton(widget, node);
    } else if (widget is FloatingActionButton) {
      return buildFromFloatingActionButton(widget, node);
    }

    return widget;
  }
}
