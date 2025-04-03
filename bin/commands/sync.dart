// Copyright (c) 2025 Intales Srl. All rights reserved.
// Use of this source code is governed by a MIT license that can be found
// in the LICENSE file.

//ignore_for_file:avoid_print
import 'dart:async';
import 'dart:io';

import 'package:args/command_runner.dart';
import '../client.dart';

class SyncCommand extends Command {
  @override
  final name = 'sync';
  @override
  final description = 'Synchronize with the latest Figma design';

  SyncCommand() {
    argParser
      ..addOption(
        "project-id",
        abbr: "p",
        help: "Morphr Cloud project identifier",
        mandatory: false,
      )
      ..addOption(
        'server',
        abbr: 's',
        help: 'Morphr Cloud server (only for testing)',
        defaultsTo: 'https://cloud.morphr.dev',
      );
  }

  @override
  Future<void>? run() async {
    final server = argResults?['server'] as String;
    var projectId = argResults?["project-id"] as String?;

    print("🔄 Syncing Morphr with Figma...");

    projectId ??= await _getProjectIdFromOptions();
    if (projectId?.isEmpty ?? true) {
      exit(1);
    }

    final hash = await _syncProject(server, projectId!);
    if (hash?.isEmpty ?? true) {
      exit(1);
    }

    print("✅ Synced!");
  }

  Future<String?> _getProjectIdFromOptions() async {
    try {
      final optionsFile = File('lib/morphr_options.dart');
      if (!await optionsFile.exists()) {
        return null;
      }

      final content = await optionsFile.readAsString();

      final match = RegExp(r'projectId:\s*"([^"]+)"').firstMatch(content);

      if (match != null && match.groupCount >= 1) {
        return match.group(1);
      }

      return null;
    } catch (e) {
      print('⚠️ Error reading project configuration: $e');
      return null;
    }
  }

  Future<String?> _syncProject(
    String server,
    String projectId,
  ) async {
    final client = getClient(server: server);
    try {
      final response = await client.post(
        "projects/$projectId/sync",
      );

      return response['figmaFileHash'].toString();
    } catch (e) {
      print('Error creating project: $e');
      return null;
    }
  }
}
