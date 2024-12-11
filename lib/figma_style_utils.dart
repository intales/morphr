import 'package:figma/figma.dart' as figma;
import 'package:flutter/widgets.dart';

class FigmaStyleUtils {
  const FigmaStyleUtils._();

  static Color? getColor(final List<figma.Paint>? fills) {
    if (fills == null || fills.isEmpty) return null;

    final solidFill = fills.firstWhere(
      (fill) => fill.type == figma.PaintType.solid,
      orElse: () => fills.first,
    );

    if (solidFill.type != figma.PaintType.solid) return null;

    final color = solidFill.color;
    if (color == null) return null;

    return Color.fromRGBO(
      (color.r! * 255).round(),
      (color.g! * 255).round(),
      (color.b! * 255).round(),
      color.a!,
    );
  }

  static TextStyle? getTextStyle(final figma.Text text) {
    if (text.style == null) return null;

    final style = text.style!;
    final fills = text.fills;

    return TextStyle(
      color: getColor(fills),
      fontSize: style.fontSize!.toDouble(),
      fontWeight: _getFontWeight(style.fontWeight?.toInt()),
      fontStyle: style.italic == true ? FontStyle.italic : FontStyle.normal,
      letterSpacing: style.letterSpacing?.toDouble(),
      height: _calculateHeight(style),
      decoration: _getTextDecoration(style),
      fontFamily: style.fontFamily,
    );
  }

  static double? _calculateHeight(final figma.TypeStyle style) {
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
}
