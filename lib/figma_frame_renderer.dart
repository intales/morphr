import 'package:morphr/figma_component_context.dart';
import 'package:morphr/figma_properties.dart';
import 'package:morphr/figma_renderer.dart';
import 'package:morphr/figma_style_utils.dart';
import 'package:morphr/figma_node_layout_info.dart';
import 'package:flutter/material.dart';
import 'package:figma/figma.dart' as figma;
import 'dart:math' show Point;

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
        // Base content
        final content =
            node.layoutMode != null && node.layoutMode != figma.LayoutMode.none
                ? _buildAutoLayoutContent(node, rendererContext, constraints)
                : _buildManualLayoutContent(node, rendererContext, constraints);

        // Apply visual styles while maintaining fluidity
        return _applyVisualStyles(content, node);
      },
    );
  }

  Widget _buildAutoLayoutContent(
    figma.Frame frame,
    FigmaComponentContext context,
    BoxConstraints constraints,
  ) {
    final children = context.get<List<Widget>>(
          FigmaProperties.children,
          nodeId: frame.name!,
        ) ??
        [];

    // In auto-layout, usiamo Flex per mantenere le relazioni tra elementi
    final flex = Flex(
      direction: frame.layoutMode == figma.LayoutMode.horizontal
          ? Axis.horizontal
          : Axis.vertical,
      mainAxisAlignment: _getMainAxisAlignment(frame.primaryAxisAlignItems),
      crossAxisAlignment: _getCrossAxisAlignment(frame.counterAxisAlignItems),
      // Usiamo MainAxisSize.max per default per sfruttare lo spazio disponibile
      mainAxisSize: MainAxisSize.max,
      children: _addSpacingToChildren(
        children: children
            .map((child) => _ResponsiveChildWrapper(
                  child: child,
                  constraints: constraints,
                ))
            .toList(),
        spacing: frame.itemSpacing?.toDouble(),
        isHorizontal: frame.layoutMode == figma.LayoutMode.horizontal,
      ),
    );

    // Aggiungiamo padding mantenendo la fluidità
    if (_hasPadding(frame)) {
      return Padding(
        padding: EdgeInsets.symmetric(
          horizontal: _getHorizontalPaddingFactor(frame) * constraints.maxWidth,
          vertical: _getVerticalPaddingFactor(frame) * constraints.maxHeight,
        ),
        child: flex,
      );
    }

    return flex;
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

    // Per il layout manuale, usiamo Stack ma con posizionamento relativo
    return Stack(
      children: [
        for (final info in layoutInfos)
          if (info.getPosition() != null && info.getSize() != null)
            Positioned.fill(
              child: Align(
                alignment: _getRelativeAlignment(
                  info.getPosition()!,
                  info.getSize()!,
                  frame.absoluteBoundingBox!,
                ),
                child: _ResponsiveChildWrapper(
                  child: info.widget,
                  constraints: BoxConstraints(
                    maxWidth: constraints.maxWidth *
                        (info.getSize()!.width /
                            frame.absoluteBoundingBox!.width!),
                    maxHeight: constraints.maxHeight *
                        (info.getSize()!.height /
                            frame.absoluteBoundingBox!.height!),
                  ),
                ),
              ),
            ),
      ],
    );
  }

  Widget _applyVisualStyles(Widget child, figma.Frame node) {
    // Applichiamo stili visuali mantenendo il layout fluido
    return Container(
      decoration: BoxDecoration(
        color: FigmaStyleUtils.getColor(node.fills),
        borderRadius: node.cornerRadius != null
            ? BorderRadius.circular(node.cornerRadius!.toDouble())
            : null,
        boxShadow: FigmaStyleUtils.getEffects(node.effects),
      ),
      child: child,
    );
  }

  double _getHorizontalPaddingFactor(figma.Frame frame) {
    final frameWidth = frame.absoluteBoundingBox?.width ?? 1;
    return ((frame.paddingLeft ?? 0) + (frame.paddingRight ?? 0)) /
        (2 * frameWidth);
  }

  double _getVerticalPaddingFactor(figma.Frame frame) {
    final frameHeight = frame.absoluteBoundingBox?.height ?? 1;
    return ((frame.paddingTop ?? 0) + (frame.paddingBottom ?? 0)) /
        (2 * frameHeight);
  }

  bool _hasPadding(figma.Frame frame) {
    return (frame.paddingLeft ?? 0) > 0 ||
        (frame.paddingRight ?? 0) > 0 ||
        (frame.paddingTop ?? 0) > 0 ||
        (frame.paddingBottom ?? 0) > 0;
  }

  Alignment _getRelativeAlignment(
      Point<double> position, Size size, figma.SizeRectangle frameBounds) {
    // Calcoliamo l'allineamento relativo basato sulla posizione nel frame
    final centerX = (position.x + (size.width / 2)) / frameBounds.width!;
    final centerY = (position.y + (size.height / 2)) / frameBounds.height!;

    // Convertiamo in coordinate di Alignment (-1 to 1)
    return Alignment(
      (centerX * 2) - 1,
      (centerY * 2) - 1,
    );
  }

  List<Widget> _addSpacingToChildren({
    required List<Widget> children,
    required double? spacing,
    required bool isHorizontal,
  }) {
    if (spacing == null || spacing == 0 || children.isEmpty) {
      return children;
    }

    // Per mantenere il layout fluido, usiamo Expanded per gli elementi
    // e Spacer per lo spacing quando possibile
    final spacedChildren = <Widget>[];

    for (var i = 0; i < children.length; i++) {
      // Wrap del child in Expanded se non è già un Expanded
      if (children[i] is! Expanded) {
        spacedChildren.add(Expanded(
          child: children[i],
        ));
      } else {
        spacedChildren.add(children[i]);
      }

      // Aggiungi spacing tra gli elementi (non dopo l'ultimo)
      if (i < children.length - 1) {
        spacedChildren.add(
          Spacer(
            flex: (spacing / 8)
                .round(), // Convertiamo lo spacing in un flex value
          ),
        );
      }
    }

    return spacedChildren;
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

// Widget wrapper che privilegia la responsività
class _ResponsiveChildWrapper extends StatelessWidget {
  final Widget child;
  final BoxConstraints constraints;

  const _ResponsiveChildWrapper({
    required this.child,
    required this.constraints,
  });

  @override
  Widget build(BuildContext context) {
    // Permettiamo al child di espandersi fino ai limiti disponibili
    // ma senza forzare dimensioni specifiche
    return ConstrainedBox(
      constraints: constraints,
      child: child,
    );
  }
}
