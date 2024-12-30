import 'package:flutter/material.dart';
import 'package:morphr/components/figma_component.dart';
import 'package:morphr/figma_service.dart';
import 'package:morphr/renderers/figma_shape_renderer.dart';

typedef FigmaContainerComponentParams = (
  String componentName, {
  Widget? child,
});

class FigmaContainerComponent extends FigmaComponent {
  final String componentName;
  final Widget? child;

  const FigmaContainerComponent(
    this.componentName, {
    this.child,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final node = FigmaService.instance.getComponent(componentName);
    if (node == null) return SizedBox.shrink();

    return const FigmaShapeRenderer().render(
      node: node,
      child: child,
    );
  }
}
