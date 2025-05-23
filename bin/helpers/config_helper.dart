// Copyright (c) 2025 Intales Srl. All rights reserved.
// Use of this source code is governed by a MIT license that can be found
// in the LICENSE file.

//ignore_for_file:avoid_print
import 'dart:convert';
import 'dart:io';
import 'package:path/path.dart' as path;

class ConfigHelper {
  static const String _configDirName = '.morphr';

  static const String _configFileName = 'config.json';

  static String _getHomeDir() {
    if (Platform.isWindows) {
      return Platform.environment['USERPROFILE'] ?? '';
    } else {
      return Platform.environment['HOME'] ?? '';
    }
  }

  static String getConfigDir() {
    final homeDir = _getHomeDir();
    if (homeDir.isEmpty) {
      throw Exception('Cannot get user home directory.');
    }

    return path.join(homeDir, _configDirName);
  }

  static String getConfigFilePath() {
    return path.join(getConfigDir(), _configFileName);
  }

  static Map<String, dynamic> loadConfig() {
    final configFile = File(getConfigFilePath());

    if (!configFile.existsSync()) {
      return {};
    }

    try {
      final content = configFile.readAsStringSync();
      return jsonDecode(content) as Map<String, dynamic>;
    } catch (e) {
      print('Error while reading config: $e');
      return {};
    }
  }

  static void saveConfig(Map<String, dynamic> config) {
    final configDir = Directory(getConfigDir());
    final configFile = File(getConfigFilePath());

    if (!configDir.existsSync()) {
      configDir.createSync(recursive: true);
    }

    try {
      configFile.writeAsStringSync(jsonEncode(config));
    } catch (e) {
      print('Error while saving config: $e');
    }
  }

  static void updateConfig(Map<String, dynamic> updates) {
    final config = loadConfig();
    config.addAll(updates);
    saveConfig(config);
  }

  static String? getToken() {
    final configFile = File(getConfigFilePath());

    if (!configFile.existsSync()) {
      return null;
    }
    try {
      final content = configFile.readAsStringSync();
      final json = jsonDecode(content) as Map<String, dynamic>;
      return json['access_token'];
    } catch (e) {
      print('Error while reading config: $e');
      return null;
    }
  }
}
