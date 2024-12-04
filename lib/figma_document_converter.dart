import 'package:figflow/figma_node_converter.dart';
import 'package:figma/figma.dart' as figma_api;
import 'package:flutter/widgets.dart';

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
    print('Layout Mode: ${frame.layoutMode}');
    print('Item Spacing: ${frame.itemSpacing}');
    print('Primary Axis Align: ${frame.primaryAxisAlignItems}');
    print('Padding: ${frame.paddingTop}, ${frame.paddingBottom}');

    return _factory.convertNode(frame);

    return _wrapPageContent(frame as figma_api.Frame);
  }

  Widget _wrapPageContent(figma_api.Frame frame) {
    return LayoutBuilder(
      builder: (context, constraints) {
        // Determina se siamo in una viewport molto diversa dal design
        final frameWidth = frame.absoluteBoundingBox?.width ?? 0;
        final frameHeight = frame.absoluteBoundingBox?.height ?? 0;
        final designAspectRatio = frameWidth / frameHeight;
        final screenAspectRatio = constraints.maxWidth / constraints.maxHeight;

        if ((screenAspectRatio - designAspectRatio).abs() < 0.2) {
          return SizedBox(
            width: constraints.maxWidth,
            child: _factory.convertNode(frame),
          );
        }

        return SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: constraints.maxWidth * 0.05, // 5% padding
            ),
            child: _factory.convertNode(frame),
          ),
        );
      },
    );
  }
}
