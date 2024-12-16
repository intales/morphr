import 'dart:ui';

import 'package:figflow/figma_service.dart';
import 'package:figma/figma.dart' as figma;
import 'package:flutter/material.dart';

class FigmaStyleUtils {
  const FigmaStyleUtils._();

  static Color? getColor(final List<figma.Paint>? fills) {
    if (fills == null || fills.isEmpty) return null;

    final solidFill = fills.firstWhere(
      (fill) => fill.type == figma.PaintType.solid,
      orElse: () => fills.first,
    );

    if (solidFill.type != figma.PaintType.solid) {
      return _getGradientFirstColor(solidFill);
    }

    final color = solidFill.color;
    if (color == null) return null;

    return Color.fromRGBO(
      (color.r! * 255).round(),
      (color.g! * 255).round(),
      (color.b! * 255).round(),
      color.a!,
    );
  }

  static Gradient? getGradient(final figma.Paint fill) {
    if (fill.gradientStops == null || fill.gradientStops!.isEmpty) return null;

    switch (fill.type) {
      case figma.PaintType.gradientLinear:
        return _createLinearGradient(fill);
      case figma.PaintType.gradientRadial:
        return _createRadialGradient(fill);
      default:
        return null;
    }
  }

  static LinearGradient? _createLinearGradient(final figma.Paint fill) {
    if (fill.gradientStops == null || fill.gradientHandlePositions == null) {
      return null;
    }

    final stops = fill.gradientStops!.map((stop) => stop.position!).toList();

    final colors = fill.gradientStops!
        .map((stop) => Color.fromRGBO(
              (stop.color!.r! * 255).round(),
              (stop.color!.g! * 255).round(),
              (stop.color!.b! * 255).round(),
              stop.color!.a!,
            ))
        .toList();

    final handles = fill.gradientHandlePositions!;
    if (handles.length < 2) return null;

    final start = handles[0];
    final end = handles[1];

    return LinearGradient(
      begin: Alignment(start.x * 2 - 1, start.y * 2 - 1),
      end: Alignment(end.x * 2 - 1, end.y * 2 - 1),
      colors: colors,
      stops: stops,
    );
  }

  static RadialGradient? _createRadialGradient(final figma.Paint fill) {
    if (fill.gradientStops == null) return null;

    final stops = fill.gradientStops!
        .map((stop) => stop.position!)
        .toList()
        .reversed
        .toList();

    final colors = fill.gradientStops!
        .map((stop) => Color.fromRGBO(
              (stop.color!.r! * 255).round(),
              (stop.color!.g! * 255).round(),
              (stop.color!.b! * 255).round(),
              stop.color!.a!,
            ))
        .toList()
        .reversed
        .toList();

    return RadialGradient(
      colors: colors,
      stops: stops,
    );
  }

  static Color? _getGradientFirstColor(final figma.Paint fill) {
    if (fill.gradientStops == null || fill.gradientStops!.isEmpty) return null;

    final firstStop = fill.gradientStops!.first;
    return Color.fromRGBO(
      (firstStop.color!.r! * 255).round(),
      (firstStop.color!.g! * 255).round(),
      (firstStop.color!.b! * 255).round(),
      firstStop.color!.a!,
    );
  }

  static TextStyle? getTextStyle(final figma.Text text) {
    if (text.style == null) return null;

    final style = text.style!;
    final hasStroke = text.strokes.isNotEmpty == true;
    final hasFill = text.fills.isNotEmpty == true;

    return TextStyle(
      color: !hasStroke ? getColor(text.fills) : null,
      foreground: !hasFill && hasStroke
          ? (Paint()
            ..style = PaintingStyle.stroke
            ..strokeWidth = text.strokeWeight?.toDouble() ?? 1.0
            ..color = (getColor(text.strokes) ?? Colors.black))
          : null,
      fontSize: style.fontSize!.toDouble(),
      fontWeight: _getFontWeight(style.fontWeight?.toInt()),
      fontStyle: style.italic == true ? FontStyle.italic : FontStyle.normal,
      letterSpacing: style.letterSpacing?.toDouble(),
      height: _calculateTextHeight(style),
      decoration: _getTextDecoration(style),
      decorationColor: getColor(text.fills),
      shadows: getEffects(text.effects),
    );
  }

  static Paint? createTextPaint(
    final List<figma.Paint>? fills,
    final List<figma.Paint>? strokes,
    final double? strokeWeight,
  ) {
    if (strokes == null || strokes.isEmpty) {
      return null;
    }

    final paint = Paint();

    if (fills != null && fills.isNotEmpty) {
      paint.color = getColor(fills) ?? Colors.black;
    }

    paint.style = PaintingStyle.stroke;
    paint.strokeWidth = strokeWeight ?? 1.0;
    paint.color = getColor(strokes) ?? Colors.black;

    return paint;
  }

  static double? _calculateTextHeight(final figma.TypeStyle style) {
    if (style.lineHeightPx == null || style.fontSize == null) return null;
    return style.lineHeightPx! / style.fontSize!;
  }

  static FontWeight _getFontWeight(final int? weight) {
    if (weight == null) return FontWeight.normal;

    switch (weight) {
      case 100:
        return FontWeight.w100;
      case 200:
        return FontWeight.w200;
      case 300:
        return FontWeight.w300;
      case 400:
        return FontWeight.w400;
      case 500:
        return FontWeight.w500;
      case 600:
        return FontWeight.w600;
      case 700:
        return FontWeight.w700;
      case 800:
        return FontWeight.w800;
      case 900:
        return FontWeight.w900;
      default:
        return FontWeight.normal;
    }
  }

  static TextDecoration? _getTextDecoration(final figma.TypeStyle style) {
    if (style.textDecoration == figma.TextDecoration.underline) {
      return TextDecoration.underline;
    }
    if (style.textDecoration == figma.TextDecoration.strikeThrough) {
      return TextDecoration.lineThrough;
    }
    return null;
  }

  static TextAlign getTextAlign(final figma.TextAlignHorizontal? align) {
    switch (align) {
      case figma.TextAlignHorizontal.left:
        return TextAlign.left;
      case figma.TextAlignHorizontal.center:
        return TextAlign.center;
      case figma.TextAlignHorizontal.right:
        return TextAlign.right;
      case figma.TextAlignHorizontal.justified:
        return TextAlign.justify;
      default:
        return TextAlign.left;
    }
  }

  static List<BoxShadow>? getEffects(List<figma.Effect>? effects) {
    if (effects == null || effects.isEmpty) return null;

    final shadows = <BoxShadow>[];

    for (final effect in effects) {
      if (effect.type == figma.EffectType.dropShadow ||
          effect.type == figma.EffectType.innerShadow) {
        shadows.add(BoxShadow(
          color: Color.fromRGBO(
            (effect.color?.r ?? 0 * 255).round(),
            (effect.color?.g ?? 0 * 255).round(),
            (effect.color?.b ?? 0 * 255).round(),
            effect.color?.a ?? 1,
          ),
          offset: Offset(
            effect.offset?.x.toDouble() ?? 0,
            effect.offset?.y.toDouble() ?? 0,
          ),
          blurRadius: effect.radius?.toDouble() ?? 0,
          spreadRadius: effect.spread?.toDouble() ?? 0,
        ));
      }
    }

    return shadows.isEmpty ? null : shadows;
  }

  static Widget wrapWithBlur(Widget child, List<figma.Effect>? effects) {
    if (effects == null || effects.isEmpty) return child;

    Widget result = child;

    for (final effect in effects) {
      if (effect.type == figma.EffectType.layerBlur) {
        result = ImageFiltered(
          imageFilter: ImageFilter.blur(
            sigmaX: effect.radius?.toDouble() ?? 0,
            sigmaY: effect.radius?.toDouble() ?? 0,
          ),
          child: result,
        );
      } else if (effect.type == figma.EffectType.backgroundBlur) {
        result = BackdropFilter(
          filter: ImageFilter.blur(
            sigmaX: effect.radius?.toDouble() ?? 0,
            sigmaY: effect.radius?.toDouble() ?? 0,
          ),
          child: result,
        );
      }
    }

    return result;
  }

  static Border? getBorder(final figma.Node node) {
    final strokes = _getStrokes(node);
    if (strokes == null || strokes.isEmpty) return null;

    return Border.all(
      color: getColor(strokes) ?? Colors.transparent,
      width: _getStrokeWieght(node) ?? 1.0,
    );
  }

  static double? _getStrokeWieght(final figma.Node node) {
    switch (node) {
      case figma.Text text:
        return text.strokeWeight;
      case figma.Ellipse ellipse:
        return ellipse.strokeWeight;
      case figma.Rectangle rectangle:
        return rectangle.strokeWeight;
      default:
        return null;
    }
  }

  static List<figma.Paint>? _getStrokes(final figma.Node node) {
    switch (node) {
      case figma.Text text:
        return text.strokes;
      case figma.Ellipse ellipse:
        return ellipse.strokes;
      case figma.Rectangle rectangle:
        return rectangle.strokes;
      default:
        return null;
    }
  }

  static Future<DecorationImage?> getImageFill(
    final List<figma.Paint>? fills,
    String nodeId,
  ) async {
    if (fills == null || fills.isEmpty) return null;

    final imageFill = fills.firstWhere(
      (fill) => fill.type == figma.PaintType.image,
      orElse: () => fills.first,
    );

    if (imageFill.type != figma.PaintType.image) return null;

    try {
      final imageUrl = await FigmaService.instance.getImageUrl(nodeId);
      if (imageUrl == null) return null;

      return DecorationImage(
        image: NetworkImage(imageUrl),
        fit: _getImageScaleMode(imageFill.scaleMode),
        repeat: _getImageRepeatMode(imageFill.scalingFactor?.toDouble() ?? 1),
      );
    } on figma.FigmaException catch (e) {
      debugPrint('Error loading image: ${e.message}');
      return null;
    }
  }

  static BoxFit _getImageScaleMode(figma.ScaleMode? scaleMode) {
    return switch (scaleMode) {
      figma.ScaleMode.fill => BoxFit.cover,
      figma.ScaleMode.fit => BoxFit.contain,
      figma.ScaleMode.tile => BoxFit.none,
      figma.ScaleMode.stretch => BoxFit.fill,
      _ => BoxFit.cover,
    };
  }

  static ImageRepeat _getImageRepeatMode(double scalingFactor) {
    return scalingFactor != 1 ? ImageRepeat.repeat : ImageRepeat.noRepeat;
  }
}
