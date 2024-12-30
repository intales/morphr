import 'package:flutter/widgets.dart';
import 'package:morphr/components/figma_component.dart';
import 'package:morphr/figma_service.dart';
import 'package:morphr/renderers/figma_shape_renderer.dart';

class FigmaButtonComponent extends FigmaComponent {
  final String componentName;
  final VoidCallback onPressed;
  final Widget? child;

  const FigmaButtonComponent(
    this.componentName, {
    required this.onPressed,
    this.child,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final node = FigmaService.instance.getComponent(componentName);
    if (node == null) return SizedBox.shrink();

    return GestureDetector(
      onTap: onPressed,
      child: const FigmaShapeRenderer().render(
        node: node,
        child: child,
      ),
    );
  }
}
