import 'package:figflow/figflow.dart';
import 'package:figflow/figma_component_context.dart';
import 'package:figflow/figma_property_scope.dart';
import 'package:figflow/figma_renderer_factory.dart';
import 'package:flutter/widgets.dart';

class FigmaComponent extends StatelessWidget {
  final String componentId;
  final Map<String, dynamic> properties;
  final List<FigmaPropertyScope> propertyScopes;
  final bool recursive;

  const FigmaComponent({
    required this.componentId,
    this.properties = const {},
    this.propertyScopes = const [],
    this.recursive = false,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final component = FigmaService.instance.getComponent(componentId);
    if (component == null) {
      throw Exception('Cannot find $componentId component');
    }

    final componentContext = FigmaComponentContext(
      properties: properties,
      propertyScopes: propertyScopes,
      buildContext: context,
    );

    return FigmaRendererFactory.createRenderer(
      componentContext: componentContext,
      node: component,
      recursive: recursive,
    );
  }
}
