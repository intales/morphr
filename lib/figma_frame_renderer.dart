import 'package:flutter/material.dart';
import 'package:figma/figma.dart' as figma;
import 'package:morphr/figma_component_context.dart';
import 'package:morphr/figma_node_layout_info.dart';
import 'package:morphr/figma_properties.dart';
import 'package:morphr/figma_renderer.dart';
import 'package:morphr/figma_style_utils.dart';
import 'package:morphr/figma_transform_utils.dart';

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

    return LayoutBuilder(
      builder: (context, constraints) {
        final frame = node;

        // Determina le dimensioni del frame in base alle regole di layout
        final adjustedConstraints = _getFrameConstraints(frame, constraints);

        Widget content =
            node.layoutMode != null && node.layoutMode != figma.LayoutMode.none
                ? _buildAutoLayoutContent(
                    frame, rendererContext, adjustedConstraints)
                : _buildManualLayoutContent(
                    frame, rendererContext, adjustedConstraints);

        content = SizedBox(
          width: _getFrameWidth(frame, constraints),
          height: _getFrameHeight(frame, constraints),
          child: content,
        );

        final withStyles = _applyVisualStyles(content, frame);
        final withTap = wrapWithTap(withStyles, rendererContext, frame);
        return FigmaTransformUtils.wrapWithRotation(withTap, frame);
      },
    );
  }

  BoxConstraints _getFrameConstraints(
      figma.Frame frame, BoxConstraints parentConstraints) {
    return BoxConstraints(
      maxWidth: _getFrameWidth(frame, parentConstraints),
      maxHeight: _getFrameHeight(frame, parentConstraints),
      minWidth: _getFrameMinWidth(frame, parentConstraints),
      minHeight: _getFrameMinHeight(frame, parentConstraints),
    );
  }

  double _getFrameWidth(figma.Frame frame, BoxConstraints constraints) {
    if (frame.layoutAlign == figma.LayoutAlign.stretch) {
      return constraints.maxWidth;
    }
    return frame.absoluteBoundingBox?.width?.toDouble() ?? constraints.maxWidth;
  }

  double _getFrameHeight(figma.Frame frame, BoxConstraints constraints) {
    if (frame.layoutMode == figma.LayoutMode.vertical &&
        frame.layoutGrow == true) {
      return constraints.maxHeight;
    }
    return frame.absoluteBoundingBox?.height?.toDouble() ??
        constraints.maxHeight;
  }

  double _getFrameMinWidth(figma.Frame frame, BoxConstraints constraints) {
    if (frame.layoutAlign == figma.LayoutAlign.stretch) {
      return constraints.maxWidth;
    }
    return 0.0;
  }

  double _getFrameMinHeight(figma.Frame frame, BoxConstraints constraints) {
    if (frame.layoutMode == figma.LayoutMode.vertical &&
        frame.layoutGrow == true) {
      return constraints.maxHeight;
    }
    return 0.0;
  }
}

Widget _buildAutoLayoutContent(
  figma.Frame frame,
  FigmaComponentContext context,
  BoxConstraints constraints,
) {
  // Rispetta le dimensioni specificate nel frame
  final boundingBox = frame.absoluteBoundingBox;
  final specifiedHeight = boundingBox?.height?.toDouble();
  final specifiedWidth = boundingBox?.width?.toDouble();

  // Aggiorniamo i constraints in base alle dimensioni specificate
  final adjustedConstraints = BoxConstraints(
    maxWidth: specifiedWidth ?? constraints.maxWidth,
    maxHeight: specifiedHeight ?? constraints.maxHeight,
    minHeight: specifiedHeight ?? 0.0,
    minWidth: specifiedWidth ?? 0.0,
  );
  // Ottieni contenuto scrollabile se presente
  final scrollableContent = context.get<ScrollableContent>(
    FigmaProperties.scrollableContent,
    nodeId: frame.name!,
  );

  if (scrollableContent != null) {
    return _buildScrollableContent(frame, scrollableContent);
  }

  // Layout standard non scrollabile
  final children = context.get<List<Widget>>(
        FigmaProperties.children,
        nodeId: frame.name!,
      ) ??
      [];

  if (children.isEmpty) return const SizedBox.shrink();

  final isHorizontal = frame.layoutMode == figma.LayoutMode.horizontal;
  final padding = _getFramePadding(frame);

  // Gestione spacing automatico o manuale
  final hasAutoSpacing = frame.itemSpacing == null;
  final spacing = hasAutoSpacing
      ? _calculateAutoSpacing(
          isHorizontal: isHorizontal,
          containerSize:
              isHorizontal ? constraints.maxWidth : constraints.maxHeight,
          itemCount: children.length,
          padding: padding)
      : frame.itemSpacing?.toDouble() ?? 0;

  // Costruzione lista di widgets con separatori
  final childrenWithSpacing = <Widget>[];
  for (var i = 0; i < children.length; i++) {
    childrenWithSpacing.add(
      _ResponsiveChildWrapper(
        child: children[i],
        constraints: adjustedConstraints,
        isHorizontal: isHorizontal,
      ),
    );

    if (i < children.length - 1 && spacing > 0) {
      childrenWithSpacing.add(
        SizedBox(
          width: isHorizontal ? spacing : 0,
          height: isHorizontal ? 0 : spacing,
        ),
      );
    }
  }

  final flex = Flex(
    direction: isHorizontal ? Axis.horizontal : Axis.vertical,
    mainAxisAlignment: _getMainAxisAlignment(frame.primaryAxisAlignItems),
    crossAxisAlignment: _getCrossAxisAlignment(frame.counterAxisAlignItems),
    mainAxisSize: _getMainAxisSize(frame),
    children: childrenWithSpacing,
  );

  if (padding != EdgeInsets.zero) {
    return Padding(
      padding: padding,
      child: flex,
    );
  }

  return flex;
}

Widget _buildScrollableContent(
  figma.Frame frame,
  ScrollableContent scrollableContent,
) {
  final isHorizontal = frame.layoutMode == figma.LayoutMode.horizontal;
  final padding = _getFramePadding(frame);
  final spacing = frame.itemSpacing?.toDouble() ?? 0;

  return ListView.separated(
    scrollDirection: isHorizontal ? Axis.horizontal : Axis.vertical,
    padding: padding,
    itemCount: scrollableContent.itemCount,
    separatorBuilder: (context, index) => SizedBox(
      width: isHorizontal ? spacing : 0,
      height: isHorizontal ? 0 : spacing,
    ),
    itemBuilder: scrollableContent.itemBuilder,
  );
}

Widget _buildManualLayoutContent(
  figma.Frame frame,
  FigmaComponentContext context,
  BoxConstraints constraints,
) {
  final layoutInfos = context.get<List<NodeLayoutInfo>>(
        FigmaProperties.layoutInfo,
        nodeId: frame.name!,
      ) ??
      [];

  if (layoutInfos.isEmpty) return const SizedBox.shrink();

  final boundingBox = frame.absoluteBoundingBox;
  if (boundingBox == null) return const SizedBox.shrink();

  return SizedBox(
    width: boundingBox.width?.toDouble(),
    height: boundingBox.height?.toDouble(),
    child: Stack(
      clipBehavior: Clip.none,
      children: [
        for (final info in layoutInfos)
          if (info.getPosition() != null && info.getSize() != null)
            Positioned(
              left: info.getPosition()!.x,
              top: info.getPosition()!.y,
              width: info.getSize()!.width,
              height: info.getSize()!.height,
              child: _ResponsiveChildWrapper(
                child: info.widget,
                constraints: BoxConstraints(
                  maxWidth: constraints.maxWidth *
                      (info.getSize()!.width / boundingBox.width!),
                  maxHeight: constraints.maxHeight *
                      (info.getSize()!.height / boundingBox.height!),
                ),
                isHorizontal: true,
              ),
            ),
      ],
    ),
  );
}

Widget _applyVisualStyles(Widget content, figma.Frame frame) {
  final hasGradient = frame.fills.any((f) =>
      f.type == figma.PaintType.gradientLinear ||
      f.type == figma.PaintType.gradientRadial);

  final decoration = BoxDecoration(
    color: !hasGradient ? FigmaStyleUtils.getColor(frame.fills) : null,
    gradient: hasGradient
        ? FigmaStyleUtils.getGradient(frame.fills.firstWhere((f) =>
            f.type == figma.PaintType.gradientLinear ||
            f.type == figma.PaintType.gradientRadial))
        : null,
    borderRadius: frame.cornerRadius != null
        ? BorderRadius.circular(frame.cornerRadius!.toDouble())
        : null,
    border: FigmaStyleUtils.getBorder(frame),
    boxShadow: FigmaStyleUtils.getEffects(frame.effects),
  );

  final container = Container(
    decoration: decoration,
    child: content,
  );

  return FigmaStyleUtils.wrapWithBlur(container, frame.effects);
}

EdgeInsets _getFramePadding(figma.Frame frame) {
  return EdgeInsets.only(
    left: frame.paddingLeft?.toDouble() ?? 0,
    top: frame.paddingTop?.toDouble() ?? 0,
    right: frame.paddingRight?.toDouble() ?? 0,
    bottom: frame.paddingBottom?.toDouble() ?? 0,
  );
}

double _calculateAutoSpacing(
    {required bool isHorizontal,
    required double containerSize,
    required int itemCount,
    required EdgeInsets padding}) {
  if (itemCount <= 1) return 0;

  final availableSpace = containerSize -
      (isHorizontal
          ? (padding.left + padding.right)
          : (padding.top + padding.bottom));

  // Base spacing del 2% dello spazio disponibile
  final baseSpacing = availableSpace * 0.02;

  // Limiti di spacing per mantenere una buona leggibilità
  const minSpacing = 8.0;
  const maxSpacing = 24.0;

  return baseSpacing.clamp(minSpacing, maxSpacing);
}

MainAxisAlignment _getMainAxisAlignment(figma.PrimaryAxisAlignItems? align) {
  return switch (align) {
    figma.PrimaryAxisAlignItems.min => MainAxisAlignment.start,
    figma.PrimaryAxisAlignItems.center => MainAxisAlignment.center,
    figma.PrimaryAxisAlignItems.max => MainAxisAlignment.end,
    figma.PrimaryAxisAlignItems.spaceBetween => MainAxisAlignment.spaceBetween,
    _ => MainAxisAlignment.start,
  };
}

CrossAxisAlignment _getCrossAxisAlignment(figma.CounterAxisAlignItems? align) {
  return switch (align) {
    figma.CounterAxisAlignItems.min => CrossAxisAlignment.start,
    figma.CounterAxisAlignItems.center => CrossAxisAlignment.center,
    figma.CounterAxisAlignItems.max => CrossAxisAlignment.end,
    figma.CounterAxisAlignItems.baseline => CrossAxisAlignment.baseline,
    _ => CrossAxisAlignment.start,
  };
}

MainAxisSize _getMainAxisSize(figma.Frame frame) {
  // Se il frame ha un constraint di crescita, usiamo max
  if (frame.layoutGrow == true) {
    return MainAxisSize.max;
  }
  // Altrimenti lasciamo che il contenuto determini la dimensione
  return MainAxisSize.min;
}

class _ResponsiveChildWrapper extends StatelessWidget {
  final Widget child;
  final BoxConstraints constraints;
  final bool isHorizontal;

  const _ResponsiveChildWrapper({
    required this.child,
    required this.constraints,
    required this.isHorizontal,
  });

  @override
  Widget build(BuildContext context) {
    // Permettiamo al child di espandersi fino ai limiti disponibili
    // ma senza forzare dimensioni specifiche
    return ConstrainedBox(
      constraints: BoxConstraints(
        maxWidth: isHorizontal ? double.infinity : constraints.maxWidth,
        maxHeight: isHorizontal ? constraints.maxHeight : double.infinity,
      ),
      child: child,
    );
  }
}
