import 'package:figflow/figma_style_helper.dart';
import 'package:figma/figma.dart' as figma_api;
import 'package:flutter/widgets.dart';
import 'figma_node_converter.dart';

class FigmaFrameConverter extends FigmaNodeConverter {
  final FigmaNodeFactory _factory;

  FigmaFrameConverter(this._factory);

  @override
  Widget convert(figma_api.Node node) {
    if (node is! figma_api.Frame) throw ArgumentError('Not a Frame node');
    return _buildLayout(node);
  }

  Widget _buildLayout(figma_api.Frame frame) {
    var children = frame.children?.nonNulls
            .map((child) => _convertChild(child))
            .toList() ??
        [];

    if (frame.itemSpacing > 0) {
      children = _addSpacingBetweenChildren(
        children: children,
        spacing: frame.itemSpacing,
        isHorizontal: frame.layoutMode == figma_api.LayoutMode.horizontal,
      );
    }

    Widget layout;
    if (frame.layoutMode == figma_api.LayoutMode.horizontal) {
      layout = Row(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: children,
      );
    } else if (frame.layoutMode == figma_api.LayoutMode.vertical) {
      layout = Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: children,
      );
    } else {
      layout = Stack(
        children: children,
      );
    }

    final decoration = FigmaStyleHelper.extractBoxDecoration(
      fills: frame.fills,
      strokes: frame.strokes,
      strokeWeight: frame.strokeWeight,
      cornerRadius: frame.cornerRadius,
      cornerRadii: frame.rectangleCornerRadii,
    );

    if (decoration != null) {
      layout = Container(
        decoration: decoration,
        child: layout,
      );
    }

    if (frame.absoluteBoundingBox != null) {
      final width = frame.absoluteBoundingBox?.width ?? 0;
      final height = frame.absoluteBoundingBox?.height ?? 0;

      layout = ConstrainedBox(
        constraints: BoxConstraints(
          maxWidth: width,
          maxHeight: height,
        ),
        child: frame.overflowDirection != figma_api.OverflowDirection.none
            ? SingleChildScrollView(
                scrollDirection: frame.overflowDirection ==
                        figma_api.OverflowDirection.horizontalScrolling
                    ? Axis.horizontal
                    : Axis.vertical,
                child: layout,
              )
            : layout,
      );
    }

    return layout;
  }

  List<Widget> _addSpacingBetweenChildren({
    required List<Widget> children,
    required double spacing,
    required bool isHorizontal,
  }) {
    final spacedChildren = <Widget>[];
    for (var i = 0; i < children.length; i++) {
      spacedChildren.add(children[i]);
      if (i < children.length - 1) {
        if (isHorizontal) {
          spacedChildren.add(SizedBox(width: spacing));
        } else {
          spacedChildren.add(SizedBox(height: spacing));
        }
      }
    }
    return spacedChildren;
  }

  Widget _convertChild(figma_api.Node child) {
    return _factory.convertNode(child);
  }
}
