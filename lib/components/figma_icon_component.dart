import 'package:flutter/widgets.dart';
import 'package:morphr/components/figma_component.dart';
import 'package:morphr/figma_service.dart';
import 'package:morphr/renderers/figma_vector_renderer.dart';

class FigmaIconComponent extends FigmaComponent {
  final String componentName;

  const FigmaIconComponent(
    this.componentName, {
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final node = FigmaService.instance.getComponent(componentName);
    if (node == null) return SizedBox.shrink();

    return LayoutBuilder(
      builder: (context, constraints) {
        final parentSize = Size(constraints.maxWidth, constraints.maxHeight);
        return const FigmaVectorRenderer().render(
          node: node,
          parentSize: parentSize,
        );
      },
    );
  }
}
