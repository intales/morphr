// Copyright (c) 2025 Intales Srl. All rights reserved.
// Use of this source code is governed by a MIT license that can be found
// in the LICENSE file.

import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:figma/figma.dart' as figma;
import 'package:morphr/cloud/morphr_cloud.dart';
import 'package:morphr/cloud/morphr_cloud_options.dart';
import 'package:morphr/cloud/morphr_file_storage.dart';

class MorphrService {
  MorphrService._();
  static final instance = MorphrService._();

  late final String _documentPath;
  late figma.Document? _document;
  MorphrCloud? _cloud;
  MorphrFileStorage? _fileStorage;
  bool _isCloudEnabled = false;

  Future<void> initialize({
    required final String documentPath,
  }) async {
    _documentPath = documentPath;
    await _loadDocument();
  }

  Future<void> initializeCloud({
    required MorphrCloudOptions options,
  }) async {
    _fileStorage = MorphrFileStorage(
      fileName: 'design.json',
    );

    _cloud = MorphrCloud(
      options: options,
      fileStorage: _fileStorage!,
    );

    await _cloud!.init();
    _isCloudEnabled = true;

    await syncCloud();
  }

  bool get isCloudEnabled => _isCloudEnabled;

  Future<void> syncCloud() async {
    if (!_isCloudEnabled || _cloud == null) {
      throw StateError("Cloud not initialized. Call initializeCloud().");
    }

    await _cloud!.sync();
    await _loadDocumentFromCloud();
  }

  Future<void> resetCloudToAsset() async {
    if (!_isCloudEnabled || _cloud == null) {
      throw StateError("Cloud not initialized. Call initializeCloud().");
    }

    await _loadDocumentFromCloud();
  }

  figma.Node? getComponent(final String componentId) {
    if (_document == null) {
      throw StateError("MorphrService not initialized.");
    }

    return _findComponent(_document!, componentId);
  }

  Future<void> _loadDocument() async {
    final file = await rootBundle.loadString(_documentPath);
    _document = figma.FileResponse.fromJson(jsonDecode(file)).document
        as figma.Document?;
  }

  Future<void> _loadDocumentFromCloud() async {
    if (_fileStorage == null || _fileStorage!.localPath == null) {
      throw StateError("File storage not initialized.");
    }

    final file = await _fileStorage!.readAsString();
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
    if (_isCloudEnabled) {
      await _loadDocumentFromCloud();
    } else {
      await _loadDocument();
    }
  }

  void clear() {
    _document = null;
    _cloud = null;
    _fileStorage = null;
    _isCloudEnabled = false;
  }
}
