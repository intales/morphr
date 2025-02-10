import 'package:flutter/widgets.dart';
import 'package:morphr/figma_service.dart';
import 'package:morphr/renderers/figma_list_renderer.dart';

class FigmaListComponent extends StatelessWidget {
  final String componentName;
  final int itemCount;
  final IndexedWidgetBuilder itemBuilder;
  final Axis scrollDirection;

  const FigmaListComponent({
    required this.componentName,
    required this.itemCount,
    required this.itemBuilder,
    this.scrollDirection = Axis.vertical,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final node = FigmaService.instance.getComponent(componentName);
    if (node == null) return SizedBox.shrink();

    return LayoutBuilder(
      builder: (context, constraints) {
        final parentSize = Size(constraints.maxWidth, constraints.maxHeight);
        return const FigmaListRenderer().render(
          node: node,
          parentSize: parentSize,
          itemCount: itemCount,
          itemBuilder: itemBuilder,
          scrollDirection: scrollDirection,
        );
      },
    );
  }
}
