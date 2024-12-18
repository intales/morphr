import 'package:morphr/figma_component_context.dart';
import 'package:morphr/figma_properties.dart';
import 'package:morphr/figma_renderer.dart';
import 'package:morphr/figma_style_utils.dart';
import 'package:morphr/figma_transform_utils.dart';
import 'package:flutter/material.dart';
import 'package:figma/figma.dart' as figma;

class FigmaShapeRenderer extends FigmaRenderer {
  const FigmaShapeRenderer();

  @override
  Widget render({
    required final FigmaComponentContext rendererContext,
    required final figma.Node node,
  }) {
    if (node is! figma.Rectangle && node is! figma.Ellipse) {
      throw ArgumentError('Node must be a RECTANGLE or ELLIPSE node');
    }

    final fills = _getFills(node);
    final hasImage =
        fills?.any((f) => f.type == figma.PaintType.image) ?? false;

    Widget buildShapeContent(DecorationImage? imageDecoration) {
      final decoration = BoxDecoration(
        shape: _getShape(node),
        borderRadius: _getBorderRadius(node),
        color: !hasImage && !_hasGradient(node) ? _getSolidColor(node) : null,
        gradient: !hasImage ? _getGradient(node) : null,
        image: imageDecoration,
        border: _getBorder(node),
        boxShadow: _getBoxShadow(node),
      );

      final container = Container(
        width: _getWidth(node),
        height: _getHeight(node),
        decoration: decoration,
        child: rendererContext.get<Widget>(
          FigmaProperties.child,
          nodeId: node.name!,
        ),
      );

      final withBlur =
          FigmaStyleUtils.wrapWithBlur(container, _getEffects(node));
      final withTap = wrapWithTap(withBlur, rendererContext, node);
      return FigmaTransformUtils.wrapWithRotation(withTap, node);
    }

    if (hasImage) {
      return FutureBuilder<DecorationImage?>(
        future: FigmaStyleUtils.getImageFill(
          fills,
          node.id,
        ),
        builder: (context, snapshot) {
          return buildShapeContent(snapshot.data);
        },
      );
    }

    return buildShapeContent(null);
  }

  BoxShape _getShape(figma.Node node) {
    return node is figma.Rectangle ? BoxShape.rectangle : BoxShape.circle;
  }

  BorderRadius? _getBorderRadius(figma.Node node) {
    if (node is! figma.Rectangle) return null;
    final radius = node.cornerRadius?.toDouble() ?? 0.0;
    return radius > 0 ? BorderRadius.circular(radius) : null;
  }

  Color? _getSolidColor(figma.Node node) {
    final fills = _getFills(node);
    return !_hasGradient(node) ? FigmaStyleUtils.getColor(fills) : null;
  }

  Gradient? _getGradient(figma.Node node) {
    if (!_hasGradient(node)) return null;

    final fills = _getFills(node);
    if (fills == null) return null;

    return FigmaStyleUtils.getGradient(fills.firstWhere(
      (f) =>
          f.type == figma.PaintType.gradientLinear ||
          f.type == figma.PaintType.gradientRadial,
    ));
  }

  Border? _getBorder(figma.Node node) {
    final strokes = _getStrokes(node);
    if (strokes == null || strokes.isEmpty) return null;

    return Border.all(
      color: FigmaStyleUtils.getColor(strokes) ?? Colors.black,
      width: _getStrokeWeight(node) ?? 1.0,
    );
  }

  List<BoxShadow>? _getBoxShadow(figma.Node node) {
    final effects = _getEffects(node);
    return FigmaStyleUtils.getEffects(effects);
  }

  List<figma.Paint>? _getFills(figma.Node node) {
    if (node is figma.Rectangle) return node.fills;
    if (node is figma.Ellipse) return node.fills;
    return null;
  }

  List<figma.Paint>? _getStrokes(figma.Node node) {
    if (node is figma.Rectangle) return node.strokes;
    if (node is figma.Ellipse) return node.strokes;
    return null;
  }

  double? _getStrokeWeight(figma.Node node) {
    if (node is figma.Rectangle) return node.strokeWeight?.toDouble();
    if (node is figma.Ellipse) return node.strokeWeight?.toDouble();
    return null;
  }

  List<figma.Effect>? _getEffects(figma.Node node) {
    if (node is figma.Rectangle) return node.effects;
    if (node is figma.Ellipse) return node.effects;
    return null;
  }

  bool _hasGradient(figma.Node node) {
    final fills = _getFills(node);
    return fills?.any((f) =>
            f.type == figma.PaintType.gradientLinear ||
            f.type == figma.PaintType.gradientRadial) ??
        false;
  }

  double? _getWidth(figma.Node node) {
    if (node is figma.Rectangle) {
      return node.absoluteBoundingBox?.width?.toDouble();
    }
    if (node is figma.Ellipse) {
      return node.absoluteBoundingBox?.width?.toDouble();
    }
    return null;
  }

  double? _getHeight(figma.Node node) {
    if (node is figma.Rectangle) {
      return node.absoluteBoundingBox?.height?.toDouble();
    }
    if (node is figma.Ellipse) {
      return node.absoluteBoundingBox?.height?.toDouble();
    }
    return null;
  }
}
