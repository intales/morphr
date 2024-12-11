import 'package:figflow/figma_component_context.dart';
import 'package:figflow/figma_renderer.dart';
import 'package:flutter/widgets.dart';
import 'package:figma/figma.dart' as figma;

class FigmaVectorRenderer extends FigmaRenderer {
  const FigmaVectorRenderer();

  @override
  Widget render({
    required FigmaComponentContext rendererContext,
    required figma.Node node,
  }) {
    throw UnimplementedError();
  }
}
