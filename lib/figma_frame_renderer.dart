import 'package:figflow/figma_component_context.dart';
import 'package:figflow/figma_node_layout_info.dart';
import 'package:figflow/figma_properties.dart';
import 'package:figflow/figma_renderer.dart';
import 'package:figflow/figma_style_utils.dart';
import 'package:flutter/material.dart';
import 'package:figma/figma.dart' as figma;

class FigmaFrameRenderer extends FigmaRenderer {
  const FigmaFrameRenderer();

  @override
  Widget render({
    required FigmaComponentContext rendererContext,
    required figma.Node node,
  }) {
    if (node is! figma.Frame) {
      throw ArgumentError('Node must be a FRAME node');
    }

    final originalSize = Size(
      node.absoluteBoundingBox?.width?.toDouble() ?? 0,
      node.absoluteBoundingBox?.height?.toDouble() ?? 0,
    );

    final customWidth = rendererContext.get<double>(
      FigmaProperties.width,
      nodeId: node.name!,
    );
    final customHeight = rendererContext.get<double>(
      FigmaProperties.height,
      nodeId: node.name!,
    );
    final fit = rendererContext.get<FigmaFrameFit>(
          FigmaProperties.fit,
          nodeId: node.name!,
        ) ??
        FigmaFrameFit.none;

    final content =
        node.layoutMode != null && node.layoutMode != figma.LayoutMode.none
            ? _buildAutoLayoutContent(node, rendererContext)
            : _buildManualLayoutContent(node, rendererContext);

    final effects = FigmaStyleUtils.getEffects(node.effects);
    final backgroundColor = FigmaStyleUtils.getColor(node.fills);
    final gradient = node.fills.isNotEmpty
        ? FigmaStyleUtils.getGradient(node.fills.firstWhere(
            (f) =>
                f.type == figma.PaintType.gradientLinear ||
                f.type == figma.PaintType.gradientRadial,
            orElse: () => node.fills.first,
          ))
        : null;

    final hasBorder = node.strokes.isNotEmpty;
    final borderColor =
        hasBorder ? FigmaStyleUtils.getColor(node.strokes) : null;
    final borderWidth = node.strokeWeight?.toDouble();
    final cornerRadius = node.cornerRadius?.toDouble();

    Widget framedContent = Container(
      width: originalSize.width,
      height: originalSize.height,
      decoration: BoxDecoration(
        color: backgroundColor,
        gradient: gradient,
        boxShadow: effects,
        border: hasBorder
            ? Border.all(
                color: borderColor ?? Colors.black,
                width: borderWidth ?? 1.0,
              )
            : null,
        borderRadius:
            cornerRadius != null ? BorderRadius.circular(cornerRadius) : null,
      ),
      child: content,
    );

    framedContent = FigmaStyleUtils.wrapWithBlur(framedContent, node.effects);

    if ((customWidth == null && customHeight == null) ||
        fit == FigmaFrameFit.none) {
      return framedContent;
    }

    final result = wrapWithTap(
      framedContent,
      rendererContext,
      node,
    );

    return LayoutBuilder(
      builder: (context, constraints) {
        final targetSize = Size(
          customWidth ?? constraints.maxWidth,
          customHeight ?? constraints.maxHeight,
        );

        return _applyScaling(
          child: result,
          originalSize: originalSize,
          targetSize: targetSize,
          fit: fit,
        );
      },
    );
  }

  Widget _buildAutoLayoutContent(
      figma.Frame frame, FigmaComponentContext context) {
    final children = context.get<List<Widget>>(
          FigmaProperties.children,
          nodeId: frame.name!,
        ) ??
        [];

    return Flex(
      direction: frame.layoutMode == figma.LayoutMode.horizontal
          ? Axis.horizontal
          : Axis.vertical,
      mainAxisAlignment: _getMainAxisAlignment(frame.primaryAxisAlignItems),
      crossAxisAlignment: _getCrossAxisAlignment(frame.counterAxisAlignItems),
      mainAxisSize: MainAxisSize.min,
      children: children,
    );
  }

  Widget _buildManualLayoutContent(
      figma.Frame frame, FigmaComponentContext context) {
    final layoutInfos = context.get<List<NodeLayoutInfo>>(
          FigmaProperties.layoutInfo,
          nodeId: frame.name!,
        ) ??
        [];

    return Stack(
      clipBehavior: Clip.none,
      children: [
        for (final info in layoutInfos)
          if (info.getPosition() != null && info.getSize() != null)
            Positioned(
              left: info.getPosition()!.x,
              top: info.getPosition()!.y,
              width: info.getSize()!.width,
              height: info.getSize()!.height,
              child: info.widget,
            ),
      ],
    );
  }

  Widget _applyScaling({
    required Widget child,
    required Size originalSize,
    required Size targetSize,
    required FigmaFrameFit fit,
  }) {
    final contentBox = SizedBox(
      width: originalSize.width,
      height: originalSize.height,
      child: child,
    );

    switch (fit) {
      case FigmaFrameFit.contain:
        return Center(
          child: FittedBox(
            fit: BoxFit.contain,
            child: contentBox,
          ),
        );

      case FigmaFrameFit.cover:
        return SizedBox(
          width: targetSize.width,
          height: targetSize.height,
          child: FittedBox(
            fit: BoxFit.cover,
            child: contentBox,
          ),
        );

      case FigmaFrameFit.fill:
        return SizedBox(
          width: targetSize.width,
          height: targetSize.height,
          child: FittedBox(
            fit: BoxFit.fill,
            child: contentBox,
          ),
        );

      case FigmaFrameFit.none:
        return contentBox;
    }
  }

  MainAxisAlignment _getMainAxisAlignment(figma.PrimaryAxisAlignItems? align) {
    return switch (align) {
      figma.PrimaryAxisAlignItems.min => MainAxisAlignment.start,
      figma.PrimaryAxisAlignItems.center => MainAxisAlignment.center,
      figma.PrimaryAxisAlignItems.max => MainAxisAlignment.end,
      figma.PrimaryAxisAlignItems.spaceBetween =>
        MainAxisAlignment.spaceBetween,
      _ => MainAxisAlignment.start,
    };
  }

  CrossAxisAlignment _getCrossAxisAlignment(
      figma.CounterAxisAlignItems? align) {
    return switch (align) {
      figma.CounterAxisAlignItems.min => CrossAxisAlignment.start,
      figma.CounterAxisAlignItems.center => CrossAxisAlignment.center,
      figma.CounterAxisAlignItems.max => CrossAxisAlignment.end,
      figma.CounterAxisAlignItems.baseline => CrossAxisAlignment.baseline,
      _ => CrossAxisAlignment.start,
    };
  }
}
