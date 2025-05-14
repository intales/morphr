// Copyright (c) 2025 Intales Srl. All rights reserved.
// Use of this source code is governed by a MIT license that can be found
// in the LICENSE file.

import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:morphr/archetypes/archetypes_registry.dart';
import 'package:morphr_figma/morphr_figma.dart' as figma;
import 'package:morphr/cloud/morphr_cloud.dart';
import 'package:morphr/cloud/morphr_cloud_options.dart';
import 'package:morphr/cloud/morphr_file_storage.dart';

class MorphrService {
  MorphrService._();
  static final instance = MorphrService._();
  static const _fallbackPath = "assets/morphr/fallback.json";

  late final String _documentPath;
  late figma.Document? _document;
  MorphrCloud? _cloud;
  MorphrFileStorage? _fileStorage;
  bool _isCloudEnabled = false;
  ArchetypesRegistry? archetypesRegistry;

  void _initializeArchetypeRegistry() {
    archetypesRegistry = ArchetypesRegistry.initialize();
  }

  Future<void> initialize({required final String documentPath}) async {
    _initializeArchetypeRegistry();
    _documentPath = documentPath;
    await _loadDocument(_documentPath);
  }

  Future<void> initializeCloud({required MorphrCloudOptions options}) async {
    _initializeArchetypeRegistry();
    _fileStorage = MorphrFileStorage(fileName: 'design.json');

    _cloud = MorphrCloud(options: options, fileStorage: _fileStorage!);

    await _cloud!.init();
    _isCloudEnabled = true;

    if (await _fileStorage!.exists()) {
      try {
        await _loadDocumentFromCloud();
        _syncCloudInBackground();
      } catch (e) {
        await syncCloud();
      }
    } else {
      await syncCloud();
    }
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

  Future<void> _syncCloudInBackground() async {
    Future.microtask(() async {
      try {
        await _cloud!.sync();
      } catch (_) {}
    });
  }

  Future<void> _loadDocument(final String documentPath) async {
    final file = await rootBundle.loadString(documentPath);
    _document = await compute(
      (file) =>
          figma.FileResponse.fromJson(jsonDecode(file)).document
              as figma.Document?,
      file,
    );
  }

  Future<void> _loadDocumentFromCloud() async {
    try {
      if (_fileStorage == null || _fileStorage!.localPath == null) {
        throw StateError("File storage not initialized.");
      }
      final file = await _fileStorage!.readAsString();
      _document = await compute(
        (file) =>
            figma.FileResponse.fromJson(jsonDecode(file)).document
                as figma.Document?,
        file,
      );
    } catch (_) {
      await _loadDocument(_fallbackPath);
    }
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
      await _loadDocument(_documentPath);
    }
  }

  void clear() {
    _document = null;
    _cloud = null;
    _fileStorage = null;
    _isCloudEnabled = false;
  }
}
