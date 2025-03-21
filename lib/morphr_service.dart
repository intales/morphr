// Copyright (c) 2025 Intales Srl. All rights reserved.
// Use of this source code is governed by a MIT license that can be found
// in the LICENSE file.

import 'dart:convert';

import 'package:figma/figma.dart' as figma;
import 'package:flutter/services.dart' show rootBundle;

class MorphrService {
  MorphrService._();
  static final instance = MorphrService._();

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
      throw StateError("MorphrService not initialized.");
    }

    return _findComponent(_document, componentId);
  }

  Future<void> _loadDocument() async {
    final file = await rootBundle.loadString(_documentPath);

    _document = figma.FileResponse.fromJson(jsonDecode(file)).document
        as figma.Document?;
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
