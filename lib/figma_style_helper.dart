import 'dart:math' as math;
import 'package:figma/figma.dart' as figma_api;
import 'package:flutter/widgets.dart';

class FigmaStyleHelper {
  static BoxDecoration? extractBoxDecoration({
    List<figma_api.Paint>? fills,
    List<figma_api.Paint>? strokes,
    double? strokeWeight,
    double? cornerRadius,
    List<double>? cornerRadii,
  }) {
    if ((fills == null || fills.isEmpty) &&
        (strokes == null || strokes.isEmpty)) {
      return null;
    }

    return BoxDecoration(
      color: extractFillColor(fills),
      gradient: extractGradient(fills),
      border: extractBorder(strokes, strokeWeight),
      borderRadius: extractBorderRadius(cornerRadius, cornerRadii),
    );
  }

  static Color? extractFillColor(List<figma_api.Paint>? fills) {
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

  static BorderRadius? extractBorderRadius(
    double? cornerRadius,
    List<double>? cornerRadii,
  ) {
    if (cornerRadii?.isNotEmpty == true) {
      return BorderRadius.only(
        topLeft: Radius.circular(cornerRadii![0]),
        topRight: Radius.circular(cornerRadii[1]),
        bottomRight: Radius.circular(cornerRadii[2]),
        bottomLeft: Radius.circular(cornerRadii[3]),
      );
    }

    if (cornerRadius != null && cornerRadius > 0) {
      return BorderRadius.circular(cornerRadius);
    }

    return null;
  }

  static Border? extractBorder(
    List<figma_api.Paint>? strokes,
    double? strokeWeight,
  ) {
    if (strokes == null || strokes.isEmpty) return null;

    final stroke = strokes.first;
    if (!stroke.visible || stroke.color == null) return null;

    final color = stroke.color!;
    return Border.all(
      color: Color.fromRGBO(
        (color.r! * 255).round(),
        (color.g! * 255).round(),
        (color.b! * 255).round(),
        color.a!,
      ),
      width: strokeWeight ?? 1,
    );
  }

  static Gradient? extractGradient(List<figma_api.Paint>? fills) {
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

    final positions =
        gradientFill.gradientStops?.map((stop) => stop.position!).toList();

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
