import 'dart:math' as math;
import 'package:figma/figma.dart' as figma_api;
import 'package:flutter/widgets.dart';
import 'figma_node_converter.dart';

class FigmaRectangleConverter extends FigmaNodeConverter {
  @override
  Widget convert(figma_api.Node node) {
    if (node is! figma_api.Rectangle) {
      throw ArgumentError('Not a Rectangle node');
    }
    return applyLayoutAlign(
      node.layoutAlign,
      convertRectangle(rectangle: node),
    );
  }

  Widget convertRectangle({
    required figma_api.Rectangle rectangle,
  }) {
    return Container(
      width: rectangle.absoluteBoundingBox?.width?.toDouble() ?? 0,
      height: rectangle.absoluteBoundingBox?.height?.toDouble() ?? 0,
      decoration: BoxDecoration(
        color: _extractFillColor(rectangle.fills),
        borderRadius: _extractBorderRadius(rectangle),
        border: _extractBorder(rectangle),
        gradient: _extractGradient(rectangle.fills),
      ),
    );
  }

  Color? _extractFillColor(List<figma_api.Paint>? fills) {
    if (fills == null || fills.isEmpty) return null;

    final solidFill = fills
        .where((fill) => fill.type == figma_api.PaintType.solid && fill.visible)
        .firstOrNull;

    if (solidFill?.color == null) return null;

    final color = solidFill!.color!;
    return Color.fromRGBO(
      (color.r! * 255).round(),
      (color.g! * 255).round(),
      (color.b! * 255).round(),
      color.a!,
    );
  }

  BorderRadius _extractBorderRadius(figma_api.Rectangle node) {
    if (node.rectangleCornerRadii?.isNotEmpty == true) {
      return BorderRadius.only(
        topLeft: Radius.circular(node.rectangleCornerRadii![0].toDouble()),
        topRight: Radius.circular(node.rectangleCornerRadii![1].toDouble()),
        bottomRight: Radius.circular(node.rectangleCornerRadii![2].toDouble()),
        bottomLeft: Radius.circular(node.rectangleCornerRadii![3].toDouble()),
      );
    }
    return BorderRadius.circular(node.cornerRadius?.toDouble() ?? 0);
  }

  Border? _extractBorder(figma_api.Rectangle rectangle) {
    if (rectangle.strokes.isEmpty) return null;

    final stroke = rectangle.strokes.first;
    if (!stroke.visible) return null;

    final color = stroke.color!;
    return Border.all(
      color: Color.fromRGBO(
        (color.r! * 255).round(),
        (color.g! * 255).round(),
        (color.b! * 255).round(),
        color.a!,
      ),
      width: rectangle.strokeWeight?.toDouble() ?? 1,
    );
  }

  Gradient? _extractGradient(List<figma_api.Paint>? fills) {
    if (fills == null || fills.isEmpty) return null;

    final gradientFill = fills
        .where((fill) => fill.type != figma_api.PaintType.solid && fill.visible)
        .firstOrNull;

    if (gradientFill == null) return null;

    final stops = gradientFill.gradientStops?.map((stop) {
      final color = stop.color!;
      return Color.fromRGBO(
        (color.r! * 255).round(),
        (color.g! * 255).round(),
        (color.b! * 255).round(),
        color.a!,
      );
    }).toList();

    final positions = gradientFill.gradientStops
        ?.map((stop) => stop.position!.toDouble())
        .toList();

    switch (gradientFill.type) {
      case figma_api.PaintType.gradientLinear:
        if (gradientFill.gradientHandlePositions?.length != 3) return null;

        final start = gradientFill.gradientHandlePositions![0];
        final end = gradientFill.gradientHandlePositions![1];

        return LinearGradient(
          colors: stops ?? [],
          stops: positions,
          begin: Alignment(start.x * 2 - 1, start.y * 2 - 1),
          end: Alignment(end.x * 2 - 1, end.y * 2 - 1),
        );

      case figma_api.PaintType.gradientRadial:
        if (gradientFill.gradientHandlePositions?.length != 3) return null;

        final center = gradientFill.gradientHandlePositions![0];
        final radius = gradientFill.gradientHandlePositions![1];

        final focalX = center.x;
        final focalY = center.y;
        final radiusX = radius.x - center.x;
        final radiusY = radius.y - center.y;

        return RadialGradient(
          colors: stops ?? [],
          stops: positions,
          center: Alignment(focalX * 2 - 1, focalY * 2 - 1),
          radius: math.max(radiusX.abs(), radiusY.abs()) * 2,
          focal: Alignment(focalX * 2 - 1, focalY * 2 - 1),
          tileMode: TileMode.clamp,
        );

      default:
        return null;
    }
  }
}
