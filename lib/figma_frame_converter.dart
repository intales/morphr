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
    return applyLayoutAlign(
      node.layoutAlign,
      convertLayout(node),
    );
  }

  Widget convertLayout(figma_api.Frame frame) {
    var children = frame.children?.nonNulls
            .map((child) => _convertChild(child))
            .toList() ??
        [];
    final useFixedWidth =
        frame.counterAxisSizingMode != figma_api.CounterAxisSizingMode.auto;
    final useFixedHeight =
        frame.primaryAxisSizingMode != figma_api.PrimaryAxisSizingMode.auto;

    final width =
        useFixedWidth ? (frame.absoluteBoundingBox?.width ?? 0) : null;
    final height =
        useFixedHeight ? (frame.absoluteBoundingBox?.height ?? 0) : null;
    final clipBehavior = frame.clipsContent == true ? Clip.hardEdge : Clip.none;

    if (frame.layoutMode == null ||
        frame.layoutMode == figma_api.LayoutMode.none) {
      final stackWidget = SizedBox(
        width: width,
        height: height,
        child: Stack(
          clipBehavior: clipBehavior,
          children: children,
        ),
      );

      return _applyScrollToStack(
        frame: frame,
        child: stackWidget,
        width: width,
        height: height,
      );
    }

    final isHorizontal = frame.layoutMode == figma_api.LayoutMode.horizontal;
    final itemSpacing = frame.itemSpacing;

    if (itemSpacing > 0) {
      children = _addSpacingBetweenChildren(
        children: children,
        spacing: itemSpacing,
        isHorizontal: isHorizontal,
      );
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

    layout = _applyPadding(
      frame: frame,
      child: layout,
    );

    layout = _applyScrollToLayout(
      frame: frame,
      child: layout,
      isHorizontal: isHorizontal,
    );

    final decoration = FigmaStyleHelper.extractBoxDecoration(
      fills: frame.fills,
      strokes: frame.strokes,
      strokeWeight: frame.strokeWeight,
    );

    if (decoration != null) {
      layout = Container(
        decoration: decoration,
        child: layout,
      );
    }

    if (width != null || height != null) {
      layout = SizedBox(
        width: width,
        height: height,
        child: layout,
      );
    }

    return SizedBox(
      width: frame.absoluteBoundingBox?.width ?? 0,
      height: frame.absoluteBoundingBox?.height ?? 0,
      child: ClipRect(
        clipBehavior: frame.clipsContent == true ? Clip.hardEdge : Clip.none,
        child: layout,
      ),
    );
  }

  Widget _applyScrollToStack({
    required figma_api.Frame frame,
    required Widget child,
    required double? width,
    required double? height,
  }) {
    if (frame.overflowDirection == figma_api.OverflowDirection.none) {
      return child;
    }

    return SingleChildScrollView(
      scrollDirection: frame.overflowDirection ==
              figma_api.OverflowDirection.horizontalScrolling
          ? Axis.horizontal
          : Axis.vertical,
      child: SingleChildScrollView(
        scrollDirection: frame.overflowDirection ==
                figma_api.OverflowDirection.horizontalScrolling
            ? Axis.vertical
            : Axis.horizontal,
        child: SizedBox(
          width: width,
          height: height,
          child: child,
        ),
      ),
    );
  }

  Widget _applyScrollToLayout({
    required figma_api.Frame frame,
    required Widget child,
    required bool isHorizontal,
  }) {
    if (frame.overflowDirection == figma_api.OverflowDirection.none) {
      return child;
    }

    final scrollDirection = frame.overflowDirection ==
            figma_api.OverflowDirection.horizontalScrolling
        ? Axis.horizontal
        : Axis.vertical;

    if ((isHorizontal && scrollDirection == Axis.horizontal) ||
        (!isHorizontal && scrollDirection == Axis.vertical)) {
      return SingleChildScrollView(
        scrollDirection: scrollDirection,
        child: child,
      );
    }

    return child;
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

  Widget _applyPadding({
    required figma_api.Frame frame,
    required Widget child,
  }) {
    final padding = EdgeInsets.only(
      left: frame.paddingLeft,
      right: frame.paddingRight,
      top: frame.paddingTop,
      bottom: frame.paddingBottom,
    );

    if (padding != EdgeInsets.zero) {
      return Padding(
        padding: padding,
        child: child,
      );
    }

    return child;
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
