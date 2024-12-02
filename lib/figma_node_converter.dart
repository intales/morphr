import 'package:figma/figma.dart' as figma_api;
import 'package:flutter/widgets.dart';

abstract class FigmaNodeConverter {
  Widget convert(figma_api.Node node);

  Widget applyLayoutAlign(figma_api.LayoutAlign? layoutAlign, Widget child) {
    return switch (layoutAlign) {
      figma_api.LayoutAlign.stretch => Expanded(child: child),
      figma_api.LayoutAlign.min =>
        Align(alignment: Alignment.centerLeft, child: child),
      figma_api.LayoutAlign.center =>
        Align(alignment: Alignment.center, child: child),
      figma_api.LayoutAlign.max =>
        Align(alignment: Alignment.centerRight, child: child),
      _ => child,
    };
  }
}

class FigmaNodeFactory {
  static final FigmaNodeFactory instance = FigmaNodeFactory._internal();

  FigmaNodeFactory._internal();

  final _converters = <Type, FigmaNodeConverter>{};

  void registerConverter(Type type, FigmaNodeConverter converter) {
    _converters[type] = converter;
  }

  Widget convertNode(figma_api.Node node) {
    final converter = _converters[node.runtimeType];
    if (converter == null) return const SizedBox.shrink();
    return converter.convert(node);
  }
}
