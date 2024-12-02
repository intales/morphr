import 'package:figflow/figflow.dart';
import 'package:figflow/figma_frame_converter.dart';
import 'package:figflow/figma_node_converter.dart';
import 'package:figma/figma.dart' as figma_api;
import 'package:flutter/widgets.dart';

class FigmaConverter {
  final _factory = FigmaNodeFactory.instance;

  FigmaConverter() {
    _factory.registerConverter(figma_api.Rectangle, FigmaRectangleConverter());
    _factory.registerConverter(figma_api.Frame, FigmaFrameConverter(_factory));
  }

  Widget convertNode(figma_api.Node node) {
    return _factory.convertNode(node);
  }
}
