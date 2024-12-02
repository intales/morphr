import 'package:figma/figma.dart' as figma_api;
import 'package:flutter/widgets.dart';
import 'figma_node_converter.dart';

class FigmaFrameConverter extends FigmaNodeConverter {
  final FigmaNodeFactory _factory;

  FigmaFrameConverter(this._factory);

  @override
  Widget convert(figma_api.Node node) {
    if (node is! figma_api.Frame) throw ArgumentError('Not a Frame node');
    return applyLayoutAlign(
      node.layoutAlign,
      _convertLayout(node),
    );
  }

  Widget _convertLayout(figma_api.Frame frame) {
    var children = frame.children?.nonNulls
            .map((child) => _convertChild(child))
            .toList() ??
        [];
    final width = frame.absoluteBoundingBox?.width?.toDouble() ?? 0;
    final height = frame.absoluteBoundingBox?.height?.toDouble() ?? 0;
    final clipBehavior = frame.clipsContent == true ? Clip.hardEdge : Clip.none;

    if (frame.layoutMode == null ||
        frame.layoutMode == figma_api.LayoutMode.none) {
      return SizedBox(
        width: width,
        height: height,
        child: Stack(
          clipBehavior: clipBehavior,
          children: children,
        ),
      );
    }

    final isHorizontal = frame.layoutMode == figma_api.LayoutMode.horizontal;
    final itemSpacing = frame.itemSpacing.toDouble();

    if (itemSpacing > 0) {
      final spacedChildren = <Widget>[];
      for (var i = 0; i < children.length; i++) {
        spacedChildren.add(children[i]);
        if (i < children.length - 1) {
          if (isHorizontal) {
            spacedChildren.add(SizedBox(width: itemSpacing));
          } else {
            spacedChildren.add(SizedBox(height: itemSpacing));
          }
        }
      }
      children = spacedChildren;
    }

    Widget layout = isHorizontal
        ? Row(
            mainAxisAlignment: _convertMainAxisAlignment(
              align: frame.primaryAxisAlignItems,
            ),
            crossAxisAlignment: _convertCrossAxisAlignment(
              align: frame.counterAxisAlignItems,
            ),
            mainAxisSize: _convertAxisSize(
              sizingMode: isHorizontal
                  ? frame.primaryAxisSizingMode
                  : frame.counterAxisSizingMode,
            ),
            children: children,
          )
        : Column(
            mainAxisAlignment: _convertMainAxisAlignment(
              align: frame.primaryAxisAlignItems,
            ),
            crossAxisAlignment: _convertCrossAxisAlignment(
              align: frame.counterAxisAlignItems,
            ),
            mainAxisSize: _convertAxisSize(
              sizingMode: isHorizontal
                  ? frame.primaryAxisSizingMode
                  : frame.counterAxisSizingMode,
            ),
            children: children,
          );

    final padding = EdgeInsets.only(
      left: frame.paddingLeft.toDouble(),
      right: frame.paddingRight.toDouble(),
      top: frame.paddingTop.toDouble(),
      bottom: frame.paddingBottom.toDouble(),
    );

    if (padding != EdgeInsets.zero) {
      layout = Padding(
        padding: padding,
        child: layout,
      );
    }

    return SizedBox(
      width: width,
      height: height,
      child: ClipRect(
        clipBehavior: clipBehavior,
        child: layout,
      ),
    );
  }

  Widget _convertChild(figma_api.Node child) {
    return _factory.convertNode(child);
  }

  MainAxisAlignment _convertMainAxisAlignment({
    final figma_api.PrimaryAxisAlignItems? align,
  }) {
    switch (align) {
      case figma_api.PrimaryAxisAlignItems.min:
        return MainAxisAlignment.start;
      case figma_api.PrimaryAxisAlignItems.center:
        return MainAxisAlignment.center;
      case figma_api.PrimaryAxisAlignItems.max:
        return MainAxisAlignment.end;
      case figma_api.PrimaryAxisAlignItems.spaceBetween:
        return MainAxisAlignment.spaceBetween;
      default:
        return MainAxisAlignment.start;
    }
  }

  CrossAxisAlignment _convertCrossAxisAlignment({
    final figma_api.CounterAxisAlignItems? align,
  }) {
    switch (align) {
      case figma_api.CounterAxisAlignItems.min:
        return CrossAxisAlignment.start;
      case figma_api.CounterAxisAlignItems.center:
        return CrossAxisAlignment.center;
      case figma_api.CounterAxisAlignItems.max:
        return CrossAxisAlignment.end;
      default:
        return CrossAxisAlignment.center;
    }
  }

  MainAxisSize _convertAxisSize({
    final dynamic sizingMode,
  }) {
    if (sizingMode == figma_api.PrimaryAxisSizingMode.auto ||
        sizingMode == figma_api.CounterAxisSizingMode.auto) {
      return MainAxisSize.min;
    }
    return MainAxisSize.max;
  }
}
