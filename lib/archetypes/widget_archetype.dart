import 'package:flutter/widgets.dart';
import 'package:morphr_figma/morphr_figma.dart' as figma;

typedef Capability = bool Function(Widget widget);

abstract class WidgetArchetype {
  Widget build(Widget widget, figma.Node node);
  int get priority => 0;
  List<Capability> get requiredCapabilities;
  List<Capability> get optionalCapabilities;

  bool canHandle(Widget widget) {
    final requiredCaps =
        requiredCapabilities.isEmpty ||
        requiredCapabilities.every((cap) => cap(widget));

    final optionalCaps =
        optionalCapabilities.isEmpty ||
        optionalCapabilities.any((cap) => cap(widget));

    return requiredCaps && optionalCaps;
  }
}
