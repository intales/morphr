import 'package:flutter/material.dart';
import 'package:morphr/components/figma_component.dart';
import 'package:morphr/figma_service.dart';
import 'package:morphr/renderers/figma_flex_renderer.dart';

typedef FigmaFlexComponentParams = (
  String componentName, {
  List<Widget> children,
});

class FigmaFlexComponent extends FigmaComponent {
  final FigmaFlexComponentParams params;

  const FigmaFlexComponent(
    this.params, {
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final componentName = params.$1;
    final node = FigmaService.instance.getComponent(componentName);
    if (node == null) return SizedBox.shrink();

    return const FigmaFlexRenderer().render(
      node: node,
      children: params.children,
    );
  }
}
