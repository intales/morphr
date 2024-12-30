import 'package:flutter/material.dart';
import 'package:morphr/components/figma_component.dart';
import 'package:morphr/figma_service.dart';
import 'package:morphr/renderers/figma_text_renderer.dart';

typedef FigmaTextComponentParams = (
  String componentName, {
  String text,
});

class FigmaTextComponent extends FigmaComponent {
  final FigmaTextComponentParams params;

  const FigmaTextComponent(
    this.params, {
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final componentName = params.$1;
    final node = FigmaService.instance.getComponent(componentName);
    if (node == null) return SizedBox.shrink();

    return const FigmaTextRenderer().render(
      node: node,
      content: params.text,
    );
  }
}
