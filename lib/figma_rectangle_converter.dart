import 'dart:math' as math;
import 'package:figma_api/figma_api.dart' as figma_api;
import 'package:flutter/widgets.dart';

class FigmaRectangleConverter {
  Widget convertRectangle({required figma_api.Node node}) {
    return Container(
      width: node.absoluteBoundingBox?.width.toDouble() ?? 0,
      height: node.absoluteBoundingBox?.height.toDouble() ?? 0,
      decoration: BoxDecoration(
        color: _extractFillColor(node.fills),
        borderRadius: _extractBorderRadius(node),
        border: _extractBorder(node),
        gradient: _extractGradient(node.fills),
      ),
    );
  }

  Color? _extractFillColor(List<figma_api.Paint>? fills) {
    if (fills == null || fills.isEmpty) return null;

    final solidFill = fills
        .where(
          (fill) =>
              fill.type == figma_api.PaintTypeEnum.SOLID &&
              fill.visible != false,
        )
        .firstOrNull;

    if (solidFill?.color == null) return null;

    return Color.fromRGBO(
      (solidFill!.color!.r * 255).round(),
      (solidFill.color!.g * 255).round(),
      (solidFill.color!.b * 255).round(),
      solidFill.color!.a.toDouble(),
    );
  }

  BorderRadius _extractBorderRadius(figma_api.Node node) {
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

  Border? _extractBorder(figma_api.Node node) {
    if (node.strokes == null || node.strokes!.isEmpty) return null;

    final stroke = node.strokes!.first;
    if (!stroke.visible!) return null;

    return Border.all(
      color: Color.fromRGBO(
        (stroke.color!.r * 255).round(),
        (stroke.color!.g * 255).round(),
        (stroke.color!.b * 255).round(),
        stroke.color!.a.toDouble(),
      ),
      width: node.strokeWeight?.toDouble() ?? 1,
    );
  }

  Gradient? _extractGradient(List<figma_api.Paint>? fills) {
    if (fills == null || fills.isEmpty) return null;

    final gradientFill = fills
        .where(
          (fill) =>
              fill.type != figma_api.PaintTypeEnum.SOLID &&
              fill.visible != false,
        )
        .firstOrNull;

    if (gradientFill == null) return null;

    final stops = gradientFill.gradientStops?.map((stop) {
      return Color.fromRGBO(
        (stop.color.r * 255).round(),
        (stop.color.g * 255).round(),
        (stop.color.b * 255).round(),
        stop.color.a.toDouble(),
      );
    }).toList();

    final positions = gradientFill.gradientStops
        ?.map((stop) => stop.position.toDouble())
        .toList();

    switch (gradientFill.type) {
      case figma_api.PaintTypeEnum.GRADIENT_LINEAR:
        if (gradientFill.gradientHandlePositions?.length != 3) return null;

        final start = gradientFill.gradientHandlePositions![0];
        final end = gradientFill.gradientHandlePositions![1];

        return LinearGradient(
          colors: stops ?? [],
          stops: positions,
          begin: Alignment(start.x * 2 - 1, start.y * 2 - 1),
          end: Alignment(end.x * 2 - 1, end.y * 2 - 1),
        );

      case figma_api.PaintTypeEnum.GRADIENT_RADIAL:
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
