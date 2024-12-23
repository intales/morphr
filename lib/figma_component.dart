import 'package:morphr/figma_component_context.dart';
import 'package:morphr/figma_property_scope.dart';
import 'package:morphr/figma_renderer_factory.dart';
import 'package:morphr/figma_service.dart';
import 'package:flutter/widgets.dart';

class FigmaOverride {
  final String? nodeId;
  final Map<String, dynamic> properties;

  const FigmaOverride({
    this.nodeId,
    required this.properties,
  });
}

class FigmaComponent extends StatelessWidget {
  final String componentId;
  final List<FigmaOverride> overrides;
  final bool recursive;

  const FigmaComponent({
    required this.componentId,
    this.overrides = const [],
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
      buildContext: context,
      properties: _getGlobalOverrides(),
      propertyScopes: _getTargetedOverrides(),
    );

    return FigmaRendererFactory.createRenderer(
      componentContext: componentContext,
      node: component,
      recursive: recursive,
    );
  }

  Map<String, dynamic> _getGlobalOverrides() {
    final globalOverrides =
        overrides.where((override) => override.nodeId == null);
    return {
      for (final override in globalOverrides) ...override.properties,
    };
  }

  List<FigmaPropertyScope> _getTargetedOverrides() {
    final targetedOverrides =
        overrides.where((override) => override.nodeId != null);
    return [
      for (final override in targetedOverrides)
        FigmaPropertyScope(
          nodeId: override.nodeId!,
          properties: override.properties,
        ),
    ];
  }
}
