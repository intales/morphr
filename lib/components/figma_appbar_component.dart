import 'package:flutter/widgets.dart';
import 'package:morphr/components/figma_component.dart';
import 'package:morphr/figma_service.dart';
import 'package:morphr/renderers/figma_appbar_renderer.dart';

class FigmaAppbarComponent extends FigmaComponent
    implements PreferredSizeWidget {
  static const FigmaAppbarRenderer _appbarRenderer = FigmaAppbarRenderer();

  final String componentName;
  final BuildContext context;
  final List<Widget> children;

  const FigmaAppbarComponent(
    this.componentName, {
    required this.context,
    required this.children,
    super.key,
  });

  @override
  Size get preferredSize {
    final node = FigmaService.instance.getComponent(componentName);
    if (node == null) return Size.zero;

    return _appbarRenderer.getPreferredSize(
      node: node,
      mediaQueryPadding: MediaQuery.of(context).padding,
    );
  }

  @override
  Widget build(BuildContext context) {
    final node = FigmaService.instance.getComponent(componentName);
    if (node == null) {
      return SizedBox.shrink();
    }

    return const FigmaAppbarRenderer().render(
      node: node,
      mediaQueryPadding: MediaQuery.of(context).padding,
      children: children,
    );
  }
}
