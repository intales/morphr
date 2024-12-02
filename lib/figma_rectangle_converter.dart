import 'package:figflow/figma_style_helper.dart';
import 'package:figma/figma.dart' as figma_api;
import 'package:flutter/widgets.dart';
import 'figma_node_converter.dart';

class FigmaRectangleConverter extends FigmaNodeConverter {
  @override
  Widget convert(figma_api.Node node) {
    if (node is! figma_api.Rectangle) {
      throw ArgumentError('Not a Rectangle node');
    }
    return applyLayoutAlign(
      node.layoutAlign,
      convertRectangle(rectangle: node),
    );
  }

  Widget convertRectangle({
    required figma_api.Rectangle rectangle,
  }) {
    return Container(
      width: rectangle.absoluteBoundingBox?.width ?? 0,
      height: rectangle.absoluteBoundingBox?.height ?? 0,
      decoration: FigmaStyleHelper.extractBoxDecoration(
        fills: rectangle.fills,
        strokes: rectangle.strokes,
        strokeWeight: rectangle.strokeWeight,
        cornerRadius: rectangle.cornerRadius,
        cornerRadii: rectangle.rectangleCornerRadii,
      ),
    );
  }
}
