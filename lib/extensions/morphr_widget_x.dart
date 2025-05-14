import 'package:flutter/widgets.dart';
import 'package:morphr/morphr_service.dart';

class MorphrKey extends ValueKey<String> {
  const MorphrKey(super.value);
}

extension MorphrWidgetX on Widget {
  Widget morph({String? componentName}) {
    var nodeName = componentName;
    if (key is MorphrKey) {
      nodeName = (key as MorphrKey).value;
    }
    if (nodeName?.isEmpty ?? true) {
      return this;
    }

    final node = MorphrService.instance.getComponent(nodeName!);
    if (node == null) return this;

    final archetypeRegistry = MorphrService.instance.archetypesRegistry;
    if (archetypeRegistry == null) return this;

    final archetype = archetypeRegistry.findArchetypeFor(this);
    if (archetype == null) return this;

    try {
      return archetype.build(this, node);
    } catch (e) {
      print(e);

      return this;
    }
  }
}
