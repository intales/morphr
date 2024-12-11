import 'package:figflow/figma_component_context.dart';
import 'package:flutter/widgets.dart';
import 'package:figma/figma.dart' as figma;

abstract class FigmaRenderer {
  const FigmaRenderer();

  Widget render({
    required final FigmaComponentContext rendererContext,
    required final figma.Node node,
  });
}
