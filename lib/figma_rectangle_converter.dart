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

    final positions =
        gradientFill.gradientStops?.map((stop) => stop.position).toList();

    switch (gradientFill.type) {
      case figma_api.PaintTypeEnum.GRADIENT_LINEAR:
        return LinearGradient(
          colors: stops ?? [],
          stops: positions?.map((e) => e.toDouble()).toList(),
          // TODO: handle gradient transform
        );
      case figma_api.PaintTypeEnum.GRADIENT_RADIAL:
        return RadialGradient(
          colors: stops ?? [],
          stops: positions?.map((e) => e.toDouble()).toList(),
          // TODO: handle gradient transform
        );
      default:
        return null;
    }
  }
}
