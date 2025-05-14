import 'package:flutter/material.dart';
import 'package:morphr_figma/morphr_figma.dart' as figma;

mixin AlignCapability {
  Widget buildFromAlign(Align align, figma.Node node) {
    return Align(
      key: align.key,
      alignment: align.alignment,
      widthFactor: align.widthFactor,
      heightFactor: align.heightFactor,
      child: align.child,
    );
  }

  AlignmentGeometry? extractAlignment(Widget widget) {
    if (widget is Align) return widget.alignment;
    if (widget is Container) return widget.alignment;
    return null;
  }
}
