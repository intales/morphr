import 'package:flutter/widgets.dart';
import 'package:morphr/components/figma_component.dart';
import 'package:morphr/figma_service.dart';
import 'package:morphr/renderers/figma_appbar_renderer.dart';

class FigmaBottombarComponent extends FigmaComponent {
  final String componentName;
  final List<Widget> children;

  const FigmaBottombarComponent(
    this.componentName, {
    required this.children,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final node = FigmaService.instance.getComponent(componentName);
    if (node == null) return SizedBox.shrink();

    return const FigmaAppbarRenderer().render(
      node: node,
      mediaQueryPadding: MediaQuery.of(context).padding,
      children: children,
    );
  }
}
