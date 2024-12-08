import 'dart:math' as math;
import 'package:figflow/figma_node_converter.dart';
import 'package:figflow/figma_style_helper.dart';
import 'package:figma/figma.dart' as figma_api;
import 'package:flutter/material.dart';

class FigmaScaleHelper {
  static const double designWidth = 390.0;
  static const double designHeight = 844.0;

  static FigmaScreenMetrics getMetrics(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    final screenWidth = screenSize.width;
    final screenHeight = screenSize.height;

    final widthScale = screenWidth / designWidth;
    final heightScale = screenHeight / designHeight;

    final contentScale = math.min(widthScale, heightScale);

    return FigmaScreenMetrics(
      screenSize: screenSize,
      widthScale: widthScale,
      heightScale: heightScale,
      contentScale: contentScale,
    );
  }
}

class FigmaScreenMetrics {
  final Size screenSize;
  final double widthScale;
  final double heightScale;
  final double contentScale;

  const FigmaScreenMetrics({
    required this.screenSize,
    required this.widthScale,
    required this.heightScale,
    required this.contentScale,
  });

  double scaleWidth(double value) => value * widthScale;
  double scaleHeight(double value) => value * heightScale;
  double scaleContent(double value) => value * contentScale;
}

class FigmaDocumentConverter extends FigmaNodeConverter {
  final FigmaNodeFactory _factory;

  FigmaDocumentConverter(this._factory);

  @override
  Widget convert(figma_api.Node node) {
    if (node is! figma_api.Document) {
      throw ArgumentError('Not a Document node');
    }

    final canvas = node.children?.first;
    if (canvas == null) return SizedBox.shrink();

    final frame =
        (canvas as figma_api.Canvas).children?.first as figma_api.Frame;

    return _wrapPageContent(frame);
  }

  Widget _wrapPageContent(figma_api.Frame frame) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final metrics = FigmaScaleHelper.getMetrics(context);

        final content = _factory.convertNode(frame);

        return Container(
          width: metrics.screenSize.width,
          height: metrics.screenSize.height,
          color: FigmaStyleHelper.extractFillColor(frame.fills) ?? Colors.white,
          child: content,
        );
      },
    );
  }
}
