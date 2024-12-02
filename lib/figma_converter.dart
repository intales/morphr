import 'package:figflow/figma_rectangle_converter.dart';
import 'package:figma/figma.dart' as figma_api;
import 'package:flutter/widgets.dart';

class FigmaConverter {
  final _rectangleConverter = FigmaRectangleConverter();

  Widget convertNode(figma_api.Node node) {
    switch (node) {
      case figma_api.Frame frame:
        return convertLayout(frame);
      case figma_api.Rectangle rectangle:
        return _rectangleConverter.convertRectangle(rectangle: rectangle);
      default:
        return const SizedBox.shrink();
    }
  }

  Widget convertLayout(figma_api.Frame frame) {
    var children = frame.children?.nonNulls
            .map((child) => _convertChild(child: child))
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
      width: frame.absoluteBoundingBox?.width?.toDouble() ?? 0,
      height: frame.absoluteBoundingBox?.height?.toDouble() ?? 0,
      child: ClipRect(
        clipBehavior: frame.clipsContent == true ? Clip.hardEdge : Clip.none,
        child: layout,
      ),
    );
  }

  Widget _convertChild({
    required figma_api.Node child,
  }) {
    final widget = convertNode(child);

    return switch (child) {
      figma_api.Rectangle rect => _applyLayoutAlign(rect.layoutAlign, widget),
      figma_api.Frame frame => _applyLayoutAlign(frame.layoutAlign, widget),
      figma_api.Vector vector => _applyLayoutAlign(vector.layoutAlign, widget),
      _ => widget
    };
  }

  Widget _applyLayoutAlign(
    figma_api.LayoutAlign? layoutAlign,
    Widget child,
  ) {
    return switch (layoutAlign) {
      figma_api.LayoutAlign.stretch => Expanded(child: child),
      figma_api.LayoutAlign.min =>
        Align(alignment: Alignment.centerLeft, child: child),
      figma_api.LayoutAlign.center =>
        Align(alignment: Alignment.center, child: child),
      figma_api.LayoutAlign.max =>
        Align(alignment: Alignment.centerRight, child: child),
      _ => child,
    };
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
