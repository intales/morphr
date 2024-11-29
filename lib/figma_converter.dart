import 'package:figflow/figma_rectangle_converter.dart';
import 'package:figma_api/figma_api.dart' as figma_api;
import 'package:flutter/widgets.dart';

class FigmaConverter {
  final _rectangleConverter = FigmaRectangleConverter();

  Widget convertNode(figma_api.Node node) {
    switch (node.type) {
      case figma_api.NodeTypeEnum.FRAME:
        return convertLayout(node);
      case figma_api.NodeTypeEnum.RECTANGLE:
        return _rectangleConverter.convertRectangle(node: node);
      default:
        return const SizedBox.shrink();
    }
  }

  Widget convertLayout(figma_api.Node node) {
    final children =
        node.children?.map((child) => _convertChild(child: child)).toList() ??
            [];
    final width = node.absoluteBoundingBox?.width.toDouble() ?? 0;
    final height = node.absoluteBoundingBox?.height.toDouble() ?? 0;
    final clipBehavior = node.clipsContent == true ? Clip.hardEdge : Clip.none;

    if (node.layoutMode == null ||
        node.layoutMode == figma_api.NodeLayoutModeEnum.NONE) {
      return SizedBox(
        width: width,
        height: height,
        child: Stack(
          clipBehavior: clipBehavior,
          children: children,
        ),
      );
    }

    final isHorizontal =
        node.layoutMode == figma_api.NodeLayoutModeEnum.HORIZONTAL;
    Widget layout = isHorizontal
        ? Row(
            mainAxisAlignment:
                _convertMainAxisAlignment(align: node.primaryAxisAlignItems),
            crossAxisAlignment:
                _convertCrossAxisAlignment(align: node.counterAxisAlignItems),
            mainAxisSize: _convertAxisSize(
              sizingMode: isHorizontal
                  ? node.primaryAxisSizingMode
                  : node.counterAxisSizingMode,
            ),
            children: children,
          )
        : Column(
            mainAxisAlignment:
                _convertMainAxisAlignment(align: node.primaryAxisAlignItems),
            crossAxisAlignment:
                _convertCrossAxisAlignment(align: node.counterAxisAlignItems),
            mainAxisSize: _convertAxisSize(
              sizingMode: isHorizontal
                  ? node.primaryAxisSizingMode
                  : node.counterAxisSizingMode,
            ),
            children: children,
          );

    return SizedBox(
      width: width,
      height: height,
      child: ClipRect(
        clipBehavior: clipBehavior,
        child: layout,
      ),
    );
  }

  Widget _convertChild({required figma_api.Node child}) {
    final widget = convertNode(child);

    switch (child.layoutAlign) {
      case figma_api.NodeLayoutAlignEnum.STRETCH:
        return Expanded(child: widget);
      case figma_api.NodeLayoutAlignEnum.MIN:
        return Align(alignment: Alignment.centerLeft, child: widget);
      case figma_api.NodeLayoutAlignEnum.CENTER:
        return Align(alignment: Alignment.center, child: widget);
      case figma_api.NodeLayoutAlignEnum.MAX:
        return Align(alignment: Alignment.centerRight, child: widget);
      case figma_api.NodeLayoutAlignEnum.INHERIT:
      case null:
        return widget;
    }
  }

  MainAxisAlignment _convertMainAxisAlignment({
    final figma_api.NodePrimaryAxisAlignItemsEnum? align,
  }) {
    switch (align) {
      case figma_api.NodePrimaryAxisAlignItemsEnum.MIN:
        return MainAxisAlignment.start;
      case figma_api.NodePrimaryAxisAlignItemsEnum.CENTER:
        return MainAxisAlignment.center;
      case figma_api.NodePrimaryAxisAlignItemsEnum.MAX:
        return MainAxisAlignment.end;
      case figma_api.NodePrimaryAxisAlignItemsEnum.SPACE_BETWEEN:
        return MainAxisAlignment.spaceBetween;
      default:
        return MainAxisAlignment.start;
    }
  }

  CrossAxisAlignment _convertCrossAxisAlignment({
    final figma_api.NodeCounterAxisAlignItemsEnum? align,
  }) {
    switch (align) {
      case figma_api.NodeCounterAxisAlignItemsEnum.MIN:
        return CrossAxisAlignment.start;
      case figma_api.NodeCounterAxisAlignItemsEnum.CENTER:
        return CrossAxisAlignment.center;
      case figma_api.NodeCounterAxisAlignItemsEnum.MAX:
        return CrossAxisAlignment.end;
      default:
        return CrossAxisAlignment.center;
    }
  }

  MainAxisSize _convertAxisSize({final dynamic sizingMode}) {
    if (sizingMode == figma_api.NodePrimaryAxisSizingModeEnum.AUTO ||
        sizingMode == figma_api.NodeCounterAxisSizingModeEnum.AUTO) {
      return MainAxisSize.min;
    }
    return MainAxisSize.max;
  }
}
