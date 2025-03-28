// Copyright (c) 2025 Intales Srl. All rights reserved.
// Use of this source code is governed by a MIT license that can be found
// in the LICENSE file.

import 'dart:convert';
import 'package:crypto/crypto.dart';
import 'package:diff_match_patch/diff_match_patch.dart';
import 'package:morphr/cloud/morphr_cloud_client.dart';
import 'package:morphr/cloud/morphr_cloud_options.dart';
import 'package:morphr/cloud/morphr_file_storage.dart';

class MorphrCloud {
  final MorphrCloudClient _client;
  final MorphrCloudOptions _options;
  final MorphrFileStorage _fileStorage;
  String? _lastKnownHash;

  MorphrCloud({
    required MorphrCloudOptions options,
    required MorphrFileStorage fileStorage,
  })  : _client = MorphrCloudClient.withApiKey(
          baseUrl: options.endpoint,
          clientId: options.clientId,
          clientSecret: options.clientSecret,
        ),
        _options = options,
        _fileStorage = fileStorage;

  Future<void> init() async {
    await _fileStorage.init();
  }

  Future<void> sync({bool skipBackup = false}) async {
    try {
      if (!(await _fileStorage.exists())) {
        await _fileStorage.writeAsString('');
      }

      final String localContent = await _fileStorage.readAsString();

      final localHash = _calculateFileHash(localContent);

      final syncResponse = await _client.syncDev(
        projectId: int.parse(_options.projectId),
        figmaFileHash: _lastKnownHash ?? localHash,
      );

      final patchesJson = syncResponse['patches'] as List;
      final serverHash = syncResponse['figmaFileHash'] as String;

      if (patchesJson.isEmpty) {
        _lastKnownHash = serverHash;
        return;
      }

      final dmp = DiffMatchPatch();
      final patches = patchesJson.map<Patch>((patchJson) {
        return _patchFromJson(patchJson as Map<String, dynamic>);
      }).toList();

      if (!skipBackup && localContent.isNotEmpty) {
        await _fileStorage.createBackup();
      }

      String newContent = localContent;
      final patchResults = dmp.patch_apply(patches, newContent);
      newContent = patchResults[0] as String;

      await _fileStorage.writeAsString(newContent);

      _lastKnownHash = serverHash;
    } catch (e) {
      if (e is! MorphrCloudException) {
        throw MorphrCloudException('Error while syncing: $e');
      }
      rethrow;
    }
  }

  String _calculateFileHash(String content) {
    final bytes = utf8.encode(content);
    final digest = sha256.convert(bytes);
    return digest.toString();
  }

  Patch _patchFromJson(Map<String, dynamic> json) {
    final patch = Patch();

    patch.start1 = json['start1'] as int;
    patch.start2 = json['start2'] as int;
    patch.length1 = json['length1'] as int;
    patch.length2 = json['length2'] as int;

    final diffsList = json['diffs'] as List;
    patch.diffs = diffsList.map<Diff>((diffJson) {
      final diffMap = diffJson as Map<String, dynamic>;
      return Diff(diffMap['operation'] as int, diffMap['text'] as String);
    }).toList();

    return patch;
  }

  String? get lastKnownHash => _lastKnownHash;

  MorphrFileStorage get fileStorage => _fileStorage;
}
