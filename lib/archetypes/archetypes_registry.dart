import 'package:flutter/widgets.dart';
import 'package:morphr/archetypes/button_archetype.dart';
import 'package:morphr/archetypes/container_archetype.dart';
import 'package:morphr/archetypes/text_archetype.dart';
import 'package:morphr/archetypes/widget_archetype.dart';

class ArchetypesRegistry {
  static ArchetypesRegistry initialize() =>
      ArchetypesRegistry()
        ..register(ButtonArchetype())
        ..register(ContainerArchetype())
        ..register(TextArchetype());

  final List<WidgetArchetype> _archetypes = [];

  void register(WidgetArchetype archetype) =>
      _archetypes
        ..add(archetype)
        ..sort((a, b) => b.priority.compareTo(a.priority));

  WidgetArchetype? findArchetypeFor(Widget widget) =>
      _archetypes.where((archetype) => archetype.canHandle(widget)).firstOrNull;
}
