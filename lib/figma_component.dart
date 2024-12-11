import 'package:figflow/figflow.dart';
import 'package:figflow/figma_component_context.dart';
import 'package:figflow/figma_properties.dart';
import 'package:figflow/figma_renderer_factory.dart';
import 'package:flutter/widgets.dart';

abstract class FigmaComponent extends StatelessWidget {
  const FigmaComponent({super.key});

  String get figmaComponentId;

  String? get text => null;
  int? get maxLines => null;
  TextOverflow? get overflow => null;
  bool? get softWrap => null;

  @override
  Widget build(BuildContext context) {
    final component = FigmaService.instance.getComponent(figmaComponentId);
    if (component == null) {
      throw Exception("Cannot find $figmaComponentId component");
    }

    final componentContext = FigmaComponentContext(
      buildContext: context,
      properties: _properties,
    );

    return FigmaRendererFactory.createRenderer(
      componentContext: componentContext,
      node: component,
    );
  }

  Map<String, dynamic> get _properties {
    return {
      if (text != null) FigmaProperties.text: text,
      if (overflow != null) FigmaProperties.overflow: overflow,
      if (maxLines != null) FigmaProperties.maxLines: maxLines,
      if (softWrap != null) FigmaProperties.softWrap: softWrap,
    };
  }
}
