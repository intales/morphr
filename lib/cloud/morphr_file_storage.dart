// Copyright (c) 2025 Intales Srl. All rights reserved.
// Use of this source code is governed by a MIT license that can be found
// in the LICENSE file.

import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as path;

class MorphrFileStorage {
  final String fileName;
  String? _localPath;

  MorphrFileStorage({
    required this.fileName,
  });

  Future<String> init() async {
    final directory = await _getDocumentsDirectory();
    final morphrDir = Directory(path.join(directory.path, 'morphr'));

    if (!await morphrDir.exists()) {
      await morphrDir.create(recursive: true);
    }

    final filePath = path.join(morphrDir.path, fileName);
    _localPath = filePath;
    return filePath;
  }

  Future<bool> exists() async {
    if (_localPath == null) {
      throw Exception('Chiamare prima init() per inizializzare lo storage');
    }

    return File(_localPath!).exists();
  }

  /// Legge il contenuto del file locale come stringa.
  Future<String> readAsString() async {
    if (_localPath == null) {
      throw Exception('Chiamare prima init() per inizializzare lo storage');
    }

    final file = File(_localPath!);
    if (!await file.exists()) {
      return "";
    }

    return file.readAsString();
  }

  Future<void> writeAsString(String content) async {
    if (_localPath == null) {
      throw Exception('Chiamare prima init() per inizializzare lo storage');
    }

    final file = File(_localPath!);

    if (await file.exists()) {
      await file.delete();
    }

    await file.writeAsString(content, flush: true);
  }

  Future<String?> createBackup() async {
    if (_localPath == null) {
      return null;
    }

    final file = File(_localPath!);
    if (!await file.exists()) {
      return null;
    }

    final backupPath = '$_localPath.backup';
    await file.copy(backupPath);
    return backupPath;
  }

  String? get localPath => _localPath;

  static Future<Directory> _getDocumentsDirectory() async {
    if (Platform.isIOS || Platform.isAndroid) {
      return getApplicationDocumentsDirectory();
    } else if (Platform.isWindows || Platform.isLinux || Platform.isMacOS) {
      return getApplicationSupportDirectory();
    } else {
      return getTemporaryDirectory();
    }
  }
}
