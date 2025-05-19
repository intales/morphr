import 'package:morphr/adapters/figma_component_adapter.dart';
import 'package:morphr/morphr_service.dart';

/// A class that represents a given Figma component.
class Morph extends FigmaComponentAdapter {
  const Morph(super.node);
}

Morph? morph(String componentName) {
  if (componentName.isEmpty) {
    return null;
  }

  final node = MorphrService.instance.getComponent(componentName);
  if (node == null) return null;

  return Morph(node);
}
