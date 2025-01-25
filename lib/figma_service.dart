import 'dart:convert';

import 'package:figma/figma.dart' as figma;
import 'package:flutter/services.dart' show rootBundle;

class FigmaService {
  FigmaService._();
  static final instance = FigmaService._();

  late final String _documentPath;
  late final figma.Document? _document;

  Future<void> initialize({
    required final String documentPath,
  }) async {
    _documentPath = documentPath;
    await _loadDocument();
  }

  figma.Node? getComponent(final String componentId) {
    if (_document == null) {
      throw StateError("FigmaService not initialized.");
    }

    return _findComponent(_document, componentId);
  }

  Future<void> _loadDocument() async {
    final file = await rootBundle.loadString(_documentPath);

    _document = figma.FileResponse.fromJson(jsonDecode(file)).document;
  }

  figma.Node? _findComponent(figma.Node node, String componentId) {
    if (node.name == componentId) {
      return node;
    }

    final nodes = _getChildNodes(node);
    if (nodes != null) {
      for (final child in nodes) {
        if (child == null) continue;

        final result = _findComponent(child, componentId);
        if (result != null) {
          return result;
        }
      }
    }

    return null;
  }

  List<figma.Node?>? _getChildNodes(figma.Node node) {
    if (node is figma.Document) return node.children;
    if (node is figma.Canvas) return node.children;
    if (node is figma.Frame) return node.children;
    return null;
  }

  Future<void> reload() async {
    await _loadDocument();
  }

  void clear() {
    _document = null;
  }
}
