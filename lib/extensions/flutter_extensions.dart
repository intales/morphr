import 'package:flutter/material.dart';

extension DecorationExtension on Decoration {
  Map<String, dynamic> toJson() {
    if (this is BoxDecoration) {
      final boxDecoration = this as BoxDecoration;
      return {
        'type': 'box',
        'properties': boxDecoration.toBoxDecorationJson(),
      };
    } else if (this is ShapeDecoration) {
      final shapeDecoration = this as ShapeDecoration;
      return {
        'type': 'shape',
        'properties': shapeDecoration.toShapeDecorationJson(),
      };
    }
    return {'type': 'unknown'};
  }

  static Decoration? fromJson(Map<String, dynamic>? json) {
    if (json == null) return null;

    final type = json['type'] as String?;
    if (type == 'box') {
      return BoxDecorationExtension.fromJson(json['properties']);
    } else if (type == 'shape') {
      return ShapeDecorationExtension.fromJson(json['properties']);
    }
    return null;
  }
}

extension BorderRadiusGeometryExtension on BorderRadiusGeometry {
  Map<String, dynamic> toJson() {
    if (this is BorderRadius) {
      final borderRadius = this as BorderRadius;
      return {
        'type': 'radius',
        'properties': borderRadius.toBorderRadiusJson(),
      };
    } else if (this is BorderRadiusDirectional) {
      final directional = this as BorderRadiusDirectional;
      return {
        'type': 'directional',
        'properties': {
          'topStart': {
            'x': directional.topStart.x,
            'y': directional.topStart.y
          },
          'topEnd': {'x': directional.topEnd.x, 'y': directional.topEnd.y},
          'bottomStart': {
            'x': directional.bottomStart.x,
            'y': directional.bottomStart.y
          },
          'bottomEnd': {
            'x': directional.bottomEnd.x,
            'y': directional.bottomEnd.y
          },
        },
      };
    }
    return {'type': 'unknown'};
  }

  static BorderRadiusGeometry? fromJson(Map<String, dynamic>? json) {
    if (json == null) return null;

    final type = json['type'] as String?;
    if (type == 'radius') {
      return BorderRadiusExtension.fromJson(json['properties']);
    } else if (type == 'directional') {
      final props = json['properties'] as Map<String, dynamic>;
      return BorderRadiusDirectional.only(
        topStart:
            Radius.elliptical(props['topStart']['x'], props['topStart']['y']),
        topEnd: Radius.elliptical(props['topEnd']['x'], props['topEnd']['y']),
        bottomStart: Radius.elliptical(
            props['bottomStart']['x'], props['bottomStart']['y']),
        bottomEnd:
            Radius.elliptical(props['bottomEnd']['x'], props['bottomEnd']['y']),
      );
    }
    return null;
  }
}

extension BorderRadiusExtension on BorderRadius {
  Map<String, dynamic> toBorderRadiusJson() {
    if (this == BorderRadius.zero) {
      return {'type': 'zero'};
    } else {
      return {
        'type': 'only',
        'topLeft': {'x': topLeft.x, 'y': topLeft.y},
        'topRight': {'x': topRight.x, 'y': topRight.y},
        'bottomLeft': {'x': bottomLeft.x, 'y': bottomLeft.y},
        'bottomRight': {'x': bottomRight.x, 'y': bottomRight.y},
      };
    }
  }

  Map<String, dynamic> toJson() => {
        'type': 'radius',
        'properties': toBorderRadiusJson(),
      };

  static BorderRadius? fromJson(Map<String, dynamic>? json) {
    if (json == null) return null;

    final type = json['type'] as String?;
    if (type == 'zero') {
      return BorderRadius.zero;
    } else if (type == 'circular') {
      return BorderRadius.circular(json['radius']);
    } else if (type == 'only') {
      return BorderRadius.only(
        topLeft: Radius.elliptical(json['topLeft']['x'], json['topLeft']['y']),
        topRight:
            Radius.elliptical(json['topRight']['x'], json['topRight']['y']),
        bottomLeft:
            Radius.elliptical(json['bottomLeft']['x'], json['bottomLeft']['y']),
        bottomRight: Radius.elliptical(
            json['bottomRight']['x'], json['bottomRight']['y']),
      );
    }
    return null;
  }
}

extension ShapeDecorationExtension on ShapeDecoration {
  Map<String, dynamic> toShapeDecorationJson() => {
        'color': color?.toJson(),
        'shadows': shadows?.map((s) => s.toJson()).toList(),
        'gradient': gradient?.toJson(),
        'image': image != null ? {'type': 'image'} : null,
        'shape': _serializeShape(),
      };

  Map<String, dynamic> toJson() => {
        'type': 'shape',
        'properties': toShapeDecorationJson(),
      };

  Map<String, dynamic> _serializeShape() {
    if (shape is CircleBorder) {
      return {
        'type': 'circle',
        'side': (shape as CircleBorder).side.toJson(),
      };
    } else if (shape is RoundedRectangleBorder) {
      final roundedShape = shape as RoundedRectangleBorder;
      return {
        'type': 'roundedRectangle',
        'side': roundedShape.side.toJson(),
        'borderRadius': roundedShape.borderRadius.toJson(),
      };
    } else if (shape is StadiumBorder) {
      return {
        'type': 'stadium',
        'side': (shape as StadiumBorder).side.toJson(),
      };
    } else if (shape is BeveledRectangleBorder) {
      final beveledShape = shape as BeveledRectangleBorder;
      return {
        'type': 'beveledRectangle',
        'side': beveledShape.side.toJson(),
        'borderRadius': beveledShape.borderRadius.toJson(),
      };
    } else {
      return {'type': 'unknown'};
    }
  }

  static ShapeDecoration? fromJson(Map<String, dynamic>? json) {
    if (json == null) return null;

    final shapeJson = json['shape'] as Map<String, dynamic>?;
    if (shapeJson == null) return null;

    final shapeType = shapeJson['type'] as String?;
    ShapeBorder? shapeBorder;

    if (shapeType == 'circle') {
      shapeBorder = CircleBorder(
        side:
            BorderSideExtension.fromJson(shapeJson['side']) ?? BorderSide.none,
      );
    } else if (shapeType == 'roundedRectangle') {
      shapeBorder = RoundedRectangleBorder(
        side:
            BorderSideExtension.fromJson(shapeJson['side']) ?? BorderSide.none,
        borderRadius:
            BorderRadiusExtension.fromJson(shapeJson['borderRadius']) ??
                BorderRadius.zero,
      );
    } else if (shapeType == 'stadium') {
      shapeBorder = StadiumBorder(
        side:
            BorderSideExtension.fromJson(shapeJson['side']) ?? BorderSide.none,
      );
    } else if (shapeType == 'beveledRectangle') {
      shapeBorder = BeveledRectangleBorder(
        side:
            BorderSideExtension.fromJson(shapeJson['side']) ?? BorderSide.none,
        borderRadius:
            BorderRadiusExtension.fromJson(shapeJson['borderRadius']) ??
                BorderRadius.zero,
      );
    }

    if (shapeBorder == null) return null;

    return ShapeDecoration(
      color:
          json['color'] != null ? ColorExtension.fromJson(json['color']) : null,
      shadows: json['shadows'] != null
          ? List<BoxShadow>.from(
              json['shadows'].map((x) => BoxShadowExtension.fromJson(x)))
          : null,
      gradient: json['gradient'] != null
          ? GradientExtension.fromJson(json['gradient'])
          : null,
      shape: shapeBorder,
    );
  }
}

extension BorderSideExtension on BorderSide {
  Map<String, dynamic> toJson() => {
        'color': color.toJson(),
        'width': width,
        'style': style.index,
      };

  static BorderSide? fromJson(Map<String, dynamic>? json) {
    if (json == null) return null;

    return BorderSide(
      color: ColorExtension.fromJson(json['color']),
      width: json['width'],
      style: BorderStyle.values[json['style'] ?? 0],
    );
  }
}

extension BoxBorderExtension on BoxBorder {
  Map<String, dynamic> toJson() {
    if (this is Border) {
      final border = this as Border;
      return {
        'type': 'border',
        'properties': border.toBorderJson(),
      };
    } else if (this is BorderDirectional) {
      final borderDirectional = this as BorderDirectional;
      return {
        'type': 'borderDirectional',
        'properties': {
          'type': 'directional',
          'top': borderDirectional.top.color.toARGB32() != 0
              ? {
                  'color': borderDirectional.top.color.toJson(),
                  'width': borderDirectional.top.width,
                  'style': borderDirectional.top.style.index
                }
              : null,
          'start': borderDirectional.start.color.toARGB32() != 0
              ? {
                  'color': borderDirectional.start.color.toJson(),
                  'width': borderDirectional.start.width,
                  'style': borderDirectional.start.style.index
                }
              : null,
          'end': borderDirectional.end.color.toARGB32() != 0
              ? {
                  'color': borderDirectional.end.color.toJson(),
                  'width': borderDirectional.end.width,
                  'style': borderDirectional.end.style.index
                }
              : null,
          'bottom': borderDirectional.bottom.color.toARGB32() != 0
              ? {
                  'color': borderDirectional.bottom.color.toJson(),
                  'width': borderDirectional.bottom.width,
                  'style': borderDirectional.bottom.style.index
                }
              : null,
        },
      };
    }
    return {'type': 'unknown'};
  }

  static BoxBorder? fromJson(Map<String, dynamic>? json) {
    if (json == null) return null;

    final type = json['type'] as String?;
    if (type == 'border') {
      return BorderExtension.fromJson(json['properties']);
    } else if (type == 'borderDirectional') {
      final properties = json['properties'] as Map<String, dynamic>;

      return BorderDirectional(
        top: properties['top'] != null
            ? BorderSide(
                color: ColorExtension.fromJson(properties['top']['color']),
                width: properties['top']['width'].toDouble(),
                style: BorderStyle.values[properties['top']['style'] ?? 0],
              )
            : BorderSide.none,
        start: properties['start'] != null
            ? BorderSide(
                color: ColorExtension.fromJson(properties['start']['color']),
                width: properties['start']['width'].toDouble(),
                style: BorderStyle.values[properties['start']['style'] ?? 0],
              )
            : BorderSide.none,
        end: properties['end'] != null
            ? BorderSide(
                color: ColorExtension.fromJson(properties['end']['color']),
                width: properties['end']['width'].toDouble(),
                style: BorderStyle.values[properties['end']['style'] ?? 0],
              )
            : BorderSide.none,
        bottom: properties['bottom'] != null
            ? BorderSide(
                color: ColorExtension.fromJson(properties['bottom']['color']),
                width: properties['bottom']['width'].toDouble(),
                style: BorderStyle.values[properties['bottom']['style'] ?? 0],
              )
            : BorderSide.none,
      );
    }
    return null;
  }
}

extension BorderExtension on Border {
  Map<String, dynamic> toBorderJson() {
    if (top == right && right == bottom && bottom == left) {
      return {
        'type': 'all',
        'color': top.color.toJson(),
        'width': top.width,
        'style': top.style.index,
      };
    } else {
      return {
        'type': 'symmetric',
        'top': {
          'color': top.color.toJson(),
          'width': top.width,
          'style': top.style.index
        },
        'right': {
          'color': right.color.toJson(),
          'width': right.width,
          'style': right.style.index
        },
        'bottom': {
          'color': bottom.color.toJson(),
          'width': bottom.width,
          'style': bottom.style.index
        },
        'left': {
          'color': left.color.toJson(),
          'width': left.width,
          'style': left.style.index
        },
      };
    }
  }

  Map<String, dynamic> toJson() => {
        'type': 'border',
        'properties': toBorderJson(),
      };

  static Border? fromJson(Map<String, dynamic>? json) {
    if (json == null) return null;

    final type = json['type'] as String?;
    if (type == 'all') {
      return Border.all(
        color: ColorExtension.fromJson(json['color']),
        width: json['width'],
        style: BorderStyle.values[json['style'] ?? 0],
      );
    } else {
      return Border(
        top: BorderSide(
          color: ColorExtension.fromJson(json['top']['color']),
          width: json['top']['width'],
          style: BorderStyle.values[json['top']['style'] ?? 0],
        ),
        right: BorderSide(
          color: ColorExtension.fromJson(json['right']['color']),
          width: json['right']['width'],
          style: BorderStyle.values[json['right']['style'] ?? 0],
        ),
        bottom: BorderSide(
          color: ColorExtension.fromJson(json['bottom']['color']),
          width: json['bottom']['width'],
          style: BorderStyle.values[json['bottom']['style'] ?? 0],
        ),
        left: BorderSide(
          color: ColorExtension.fromJson(json['left']['color']),
          width: json['left']['width'],
          style: BorderStyle.values[json['left']['style'] ?? 0],
        ),
      );
    }
  }
}

extension BoxDecorationExtension on BoxDecoration {
  Map<String, dynamic> toBoxDecorationJson() => {
        'color': color?.toJson(),
        'gradient': gradient?.toJson(),
        'border': border?.toJson(),
        'borderRadius': borderRadius?.toJson(),
        'boxShadow': boxShadow?.map((s) => s.toJson()).toList(),
        'shape': shape.index,
      };

  Map<String, dynamic> toJson() => {
        'type': 'box',
        'properties': toBoxDecorationJson(),
      };

  static BoxDecoration fromJson(Map<String, dynamic> json) => BoxDecoration(
        color: json['color'] != null
            ? ColorExtension.fromJson(json['color'])
            : null,
        gradient: json['gradient'] != null
            ? GradientExtension.fromJson(json['gradient'])
            : null,
        border: json['border'] != null
            ? BorderExtension.fromJson(json['border'])
            : null,
        borderRadius: json['borderRadius'] != null
            ? BorderRadiusExtension.fromJson(json['borderRadius'])
            : null,
        boxShadow: json['boxShadow'] != null
            ? List<BoxShadow>.from(
                json['boxShadow'].map((x) => BoxShadowExtension.fromJson(x)))
            : null,
        shape: BoxShape.values[json['shape'] ?? 0],
      );
}

extension ColorExtension on Color {
  Map<String, dynamic> toJson() => {'value': toARGB32()};
  static Color fromJson(Map<String, dynamic> json) => Color(json['value']);
}

extension GradientExtension on Gradient {
  Map<String, dynamic> toJson() {
    if (this is LinearGradient) {
      return {
        'type': 'linear',
        'properties': (this as LinearGradient).toLinearGradientJson(),
      };
    } else if (this is RadialGradient) {
      return {
        'type': 'radial',
        'properties': (this as RadialGradient).toRadialGradientJson(),
      };
    }
    return {'type': 'unknown'};
  }

  static Gradient? fromJson(Map<String, dynamic>? json) {
    if (json == null) return null;

    final type = json['type'] as String?;
    if (type == 'linear') {
      return LinearGradientExtension.fromJson(json['properties']);
    } else if (type == 'radial') {
      return RadialGradientExtension.fromJson(json['properties']);
    }
    // Default fallback
    return null;
  }
}

extension AlignmentGeometryExtension on AlignmentGeometry {
  Map<String, dynamic> toJson() {
    if (this is Alignment) {
      final alignment = this as Alignment;
      return {
        'type': 'alignment',
        'properties': {'x': alignment.x, 'y': alignment.y}
      };
    } else if (this is AlignmentDirectional) {
      final directional = this as AlignmentDirectional;
      return {
        'type': 'directional',
        'properties': {'start': directional.start, 'y': directional.y}
      };
    }
    return {'type': 'unknown'};
  }

  static AlignmentGeometry? fromJson(Map<String, dynamic>? json) {
    if (json == null) return null;

    final type = json['type'] as String?;
    final props = json['properties'] as Map<String, dynamic>?;
    if (props == null) return null;

    if (type == 'alignment') {
      return Alignment(props['x'], props['y']);
    } else if (type == 'directional') {
      return AlignmentDirectional(props['start'], props['y']);
    }
    return null;
  }
}

extension AlignmentExtension on Alignment {
  Map<String, dynamic> toAlignmentJson() => {'x': x, 'y': y};

  Map<String, dynamic> toJson() => {
        'type': 'alignment',
        'properties': toAlignmentJson(),
      };

  static Alignment? fromJson(Map<String, dynamic>? json) {
    if (json == null) return null;
    return Alignment(json['x'], json['y']);
  }
}

extension LinearGradientExtension on LinearGradient {
  Map<String, dynamic> toLinearGradientJson() => {
        'begin': begin.toJson(),
        'end': end.toJson(),
        'colors': colors.map((c) => c.toJson()).toList(),
        'stops': stops,
        'tileMode': tileMode.index,
      };

  Map<String, dynamic> toJson() => {
        'type': 'linear',
        'properties': toLinearGradientJson(),
      };

  static LinearGradient fromJson(Map<String, dynamic> json) => LinearGradient(
        begin: AlignmentGeometryExtension.fromJson(json['begin']) ??
            Alignment.centerLeft,
        end: AlignmentGeometryExtension.fromJson(json['end']) ??
            Alignment.centerRight,
        colors: json['colors'] != null
            ? List<Color>.from(
                json['colors'].map((x) => ColorExtension.fromJson(x)))
            : const [Colors.black, Colors.black],
        stops: json['stops'] != null ? List<double>.from(json['stops']) : null,
        tileMode: TileMode.values[json['tileMode'] ?? 0],
      );
}

extension RadialGradientExtension on RadialGradient {
  Map<String, dynamic> toRadialGradientJson() => {
        'center': center.toJson(),
        'radius': radius,
        'colors': colors.map((c) => c.toJson()).toList(),
        'stops': stops,
        'tileMode': tileMode.index,
        'focal': focal?.toJson(),
        'focalRadius': focalRadius,
      };

  Map<String, dynamic> toJson() => {
        'type': 'radial',
        'properties': toRadialGradientJson(),
      };

  static RadialGradient fromJson(Map<String, dynamic> json) => RadialGradient(
        center: AlignmentGeometryExtension.fromJson(json['center']) ??
            Alignment.center,
        radius: json['radius'],
        colors: json['colors'] != null
            ? List<Color>.from(
                json['colors'].map((x) => ColorExtension.fromJson(x)))
            : const [Colors.black, Colors.black],
        stops: json['stops'] != null ? List<double>.from(json['stops']) : null,
        tileMode: TileMode.values[json['tileMode'] ?? 0],
        focal: json['focal'] != null
            ? AlignmentGeometryExtension.fromJson(json['focal'])
            : null,
        focalRadius: json['focalRadius'] ?? 0.0,
      );
}

extension BoxShadowExtension on BoxShadow {
  Map<String, dynamic> toJson() => {
        'color': color.toJson(),
        'offset': {'dx': offset.dx, 'dy': offset.dy},
        'blurRadius': blurRadius,
        'spreadRadius': spreadRadius,
        'blurStyle': blurStyle.index,
      };

  static BoxShadow fromJson(Map<String, dynamic> json) => BoxShadow(
        color: ColorExtension.fromJson(json['color']),
        offset: Offset(json['offset']['dx'], json['offset']['dy']),
        blurRadius: json['blurRadius'],
        spreadRadius: json['spreadRadius'],
        blurStyle: BlurStyle.values[json['blurStyle'] ?? 0],
      );
}

extension OffsetExtension on Offset {
  Map<String, dynamic> toJson() => {'dx': dx, 'dy': dy};
  static Offset fromJson(Map<String, dynamic> json) =>
      Offset(json['dx'], json['dy']);
}

extension SizeExtension on Size {
  Map<String, dynamic> toJson() => {'width': width, 'height': height};
  static Size? fromJson(Map<String, dynamic>? json) {
    if (json == null) return null;
    return Size(json['width'], json['height']);
  }
}

extension MainAxisAlignmentExtension on MainAxisAlignment {
  int toJson() => index;
  static MainAxisAlignment fromJson(int json) => MainAxisAlignment.values[json];
}

extension CrossAxisAlignmentExtension on CrossAxisAlignment {
  int toJson() => index;
  static CrossAxisAlignment fromJson(int json) =>
      CrossAxisAlignment.values[json];
}

extension MainAxisSizeExtension on MainAxisSize {
  int toJson() => index;
  static MainAxisSize fromJson(int json) => MainAxisSize.values[json];
}

extension TextAlignExtension on TextAlign {
  int toJson() => index;
  static TextAlign fromJson(int json) => TextAlign.values[json];
}

// TESTO E STILE TESTO

extension TextStyleExtension on TextStyle {
  Map<String, dynamic> toJson() => {
        'color': color?.toJson(),
        'backgroundColor': backgroundColor?.toJson(),
        'fontSize': fontSize,
        'fontWeight': fontWeight?.index,
        'fontStyle': fontStyle?.index,
        'letterSpacing': letterSpacing,
        'wordSpacing': wordSpacing,
        'height': height,
        'decoration': decoration?.toJson(),
        'decorationColor': decorationColor?.toJson(),
        'decorationStyle': decorationStyle?.index,
        'decorationThickness': decorationThickness,
      };

  static TextStyle? fromJson(Map<String, dynamic>? json) {
    if (json == null) return null;

    return TextStyle(
      color:
          json['color'] != null ? ColorExtension.fromJson(json['color']) : null,
      backgroundColor: json['backgroundColor'] != null
          ? ColorExtension.fromJson(json['backgroundColor'])
          : null,
      fontSize: json['fontSize'],
      fontWeight: json['fontWeight'] != null
          ? FontWeight.values[json['fontWeight']]
          : null,
      fontStyle: json['fontStyle'] != null
          ? FontStyle.values[json['fontStyle']]
          : null,
      letterSpacing: json['letterSpacing'],
      wordSpacing: json['wordSpacing'],
      height: json['height'],
      decoration: json['decoration'] != null
          ? TextDecorationExtension.fromJson(json['decoration'])
          : null,
      decorationColor: json['decorationColor'] != null
          ? ColorExtension.fromJson(json['decorationColor'])
          : null,
      decorationStyle: json['decorationStyle'] != null
          ? TextDecorationStyle.values[json['decorationStyle']]
          : null,
      decorationThickness: json['decorationThickness'],
    );
  }
}

extension TextDecorationExtension on TextDecoration {
  int toJson() {
    if (this == TextDecoration.none) return 0;
    if (this == TextDecoration.underline) return 1;
    if (this == TextDecoration.overline) return 2;
    if (this == TextDecoration.lineThrough) return 3;
    return 0;
  }

  static TextDecoration fromJson(int json) {
    switch (json) {
      case 0:
        return TextDecoration.none;
      case 1:
        return TextDecoration.underline;
      case 2:
        return TextDecoration.overline;
      case 3:
        return TextDecoration.lineThrough;
      default:
        return TextDecoration.none;
    }
  }
}

extension EdgeInsetsGeometryExtension on EdgeInsetsGeometry {
  Map<String, dynamic> toJson() {
    if (this is EdgeInsets) {
      final edgeInsets = this as EdgeInsets;
      return {
        'type': 'insets',
        'properties': edgeInsets.toEdgeInsetsJson(),
      };
    } else if (this is EdgeInsetsDirectional) {
      final directional = this as EdgeInsetsDirectional;
      return {
        'type': 'directional',
        'properties': {
          'start': directional.start,
          'top': directional.top,
          'end': directional.end,
          'bottom': directional.bottom,
        },
      };
    }
    return {'type': 'unknown'};
  }

  static EdgeInsetsGeometry? fromJson(Map<String, dynamic>? json) {
    if (json == null) return null;

    final type = json['type'] as String?;
    final props = json['properties'] as Map<String, dynamic>?;
    if (props == null) return null;

    if (type == 'insets') {
      return EdgeInsetsExtension.fromJson(props);
    } else if (type == 'directional') {
      return EdgeInsetsDirectional.fromSTEB(
        props['start'] ?? 0.0,
        props['top'] ?? 0.0,
        props['end'] ?? 0.0,
        props['bottom'] ?? 0.0,
      );
    }
    return null;
  }
}

extension EdgeInsetsExtension on EdgeInsets {
  Map<String, dynamic> toEdgeInsetsJson() {
    if (this == EdgeInsets.zero) {
      return {'type': 'zero'};
    } else if (left == right && top == bottom && left == top) {
      return {'type': 'all', 'value': left};
    } else if (left == right && top == bottom) {
      return {'type': 'symmetric', 'horizontal': left, 'vertical': top};
    } else {
      return {
        'type': 'only',
        'left': left,
        'top': top,
        'right': right,
        'bottom': bottom,
      };
    }
  }

  Map<String, dynamic> toJson() => {
        'type': 'insets',
        'properties': toEdgeInsetsJson(),
      };

  static EdgeInsets? fromJson(Map<String, dynamic>? json) {
    if (json == null) return null;

    final type = json['type'] as String?;
    if (type == 'zero') {
      return EdgeInsets.zero;
    } else if (type == 'all') {
      return EdgeInsets.all(json['value']);
    } else if (type == 'symmetric') {
      return EdgeInsets.symmetric(
        horizontal: json['horizontal'],
        vertical: json['vertical'],
      );
    } else {
      return EdgeInsets.only(
        left: json['left'] ?? 0.0,
        top: json['top'] ?? 0.0,
        right: json['right'] ?? 0.0,
        bottom: json['bottom'] ?? 0.0,
      );
    }
  }
}
