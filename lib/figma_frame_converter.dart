import 'package:figma/figma.dart' as figma_api;
import 'package:flutter/widgets.dart';
import 'figma_node_converter.dart';

class FigmaScaleHelper {
  static const double designWidth = 390.0;
  static const double designHeight = 844.0; // iPhone 14 height

  static double getScaleFactor(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    // Usiamo il fattore di scala più piccolo tra width e height
    // per evitare overflow
    final widthScale = screenWidth / designWidth;
    final heightScale = screenHeight / designHeight;

    return widthScale < heightScale ? widthScale : heightScale;
  }

  static double scale(double dimension, BuildContext context) {
    return dimension * getScaleFactor(context);
  }
}

class FigmaFrameConverter extends FigmaNodeConverter {
  final FigmaNodeFactory _factory;

  FigmaFrameConverter(this._factory);

  @override
  Widget convert(figma_api.Node node) {
    if (node is! figma_api.Frame) throw ArgumentError('Not a Frame node');
    return LayoutBuilder(
      builder: (context, constraints) {
        final scaleFactor = FigmaScaleHelper.getScaleFactor(context);
        return _buildScaledLayout(node, scaleFactor, context);
      },
    );
  }

  Widget _buildScaledLayout(
      figma_api.Frame frame, double scale, BuildContext context) {
    var children = frame.children?.nonNulls
            .map((child) => _convertChild(child))
            .toList() ??
        [];

    // Gestione dimensioni fisse
    final useFixedWidth =
        frame.counterAxisSizingMode != figma_api.CounterAxisSizingMode.auto;
    final useFixedHeight =
        frame.primaryAxisSizingMode != figma_api.PrimaryAxisSizingMode.auto;

    final width = useFixedWidth
        ? FigmaScaleHelper.scale(frame.absoluteBoundingBox?.width ?? 0, context)
        : null;
    final height = useFixedHeight
        ? FigmaScaleHelper.scale(
            frame.absoluteBoundingBox?.height ?? 0, context)
        : null;

    // Caso base: nessun layout mode = Stack
    if (frame.layoutMode == null ||
        frame.layoutMode == figma_api.LayoutMode.none) {
      final stackWidget = SizedBox(
        width: width,
        height: height,
        child: Stack(
          clipBehavior: frame.clipsContent == true ? Clip.hardEdge : Clip.none,
          children: children,
        ),
      );

      return _applyScrollToStack(
        frame: frame,
        child: stackWidget,
        width: width,
        height: height,
        context: context,
      );
    }

    // Layout orizzontale o verticale
    final isHorizontal = frame.layoutMode == figma_api.LayoutMode.horizontal;

    // Gestione spacing
    if (frame.itemSpacing > 0) {
      children = _addSpacingBetweenChildren(
        children: children,
        spacing: FigmaScaleHelper.scale(frame.itemSpacing, context),
        isHorizontal: isHorizontal,
      );
    }

    // Creazione layout base
    Widget layout = isHorizontal
        ? Row(
            mainAxisAlignment:
                _convertMainAxisAlignment(align: frame.primaryAxisAlignItems),
            crossAxisAlignment:
                _convertCrossAxisAlignment(align: frame.counterAxisAlignItems),
            mainAxisSize: MainAxisSize.min,
            children: children,
          )
        : Column(
            mainAxisAlignment:
                _convertMainAxisAlignment(align: frame.primaryAxisAlignItems),
            crossAxisAlignment:
                _convertCrossAxisAlignment(align: frame.counterAxisAlignItems),
            mainAxisSize: MainAxisSize.min,
            children: children,
          );

    // Applica padding se presente
    if (frame.paddingLeft > 0 ||
        frame.paddingRight > 0 ||
        frame.paddingTop > 0 ||
        frame.paddingBottom > 0) {
      layout = Padding(
        padding: EdgeInsets.only(
          left: FigmaScaleHelper.scale(frame.paddingLeft, context),
          right: FigmaScaleHelper.scale(frame.paddingRight, context),
          top: FigmaScaleHelper.scale(frame.paddingTop, context),
          bottom: FigmaScaleHelper.scale(frame.paddingBottom, context),
        ),
        child: layout,
      );
    }

    // Applica scroll se necessario
    layout = _applyScrollToLayout(
      frame: frame,
      child: layout,
      isHorizontal: isHorizontal,
    );

    // Applica dimensioni finali
    if (width != null || height != null) {
      layout = SizedBox(
        width: width,
        height: height,
        child: layout,
      );
    }

    return layout;
  }

  Widget _applyScrollToStack({
    required figma_api.Frame frame,
    required Widget child,
    required double? width,
    required double? height,
    required BuildContext context,
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
        return CrossAxisAlignment.start;
    }
  }

  Widget _convertChild(figma_api.Node child) {
    return _factory.convertNode(child);
  }
}
