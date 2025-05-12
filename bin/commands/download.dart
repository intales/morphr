// Copyright (c) 2025 Intales Srl. All rights reserved.
// Use of this source code is governed by a MIT license that can be found
// in the LICENSE file.

//ignore_for_file:avoid_print
import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:args/command_runner.dart';
import 'package:interact/interact.dart';

class DownloadCommand extends Command {
  @override
  final name = 'download';
  @override
  final description = 'Download Figma file as JSON';

  DownloadCommand() {
    argParser
      ..addOption('token', abbr: 't', help: 'Figma access token')
      ..addOption('file', abbr: 'f', help: 'Figma file ID');
  }

  @override
  Future<void> run() async {
    var token = argResults?['token'] as String?;
    var fileId = argResults?['file'] as String?;
    const outputDir = "assets/morphr";
    const output = "$outputDir/fallback.json";
    const imagesOutput = "$outputDir/images";

    print('\n🎨 Welcome to Morphr CLI! Let\'s download your Figma file!\n');

    token ??=
        Input(
          prompt: '🔑 Enter your Figma access token',
          validator: (value) {
            if (value.isEmpty) {
              throw ValidationError('❌ Token cannot be empty');
            }
            if (value.length < 10) {
              throw ValidationError('❌ Token seems too short');
            }
            return true;
          },
        ).interact();

    fileId ??=
        Input(
          prompt: '📁 Enter your Figma file ID',
          validator: (value) {
            if (value.isEmpty) {
              throw ValidationError('❌ File ID cannot be empty');
            }
            return true;
          },
        ).interact();

    print('\n📥 Downloading Figma file $fileId...');

    try {
      final responses = await Future.wait([
        http.get(
          Uri.parse("https://api.figma.com/v1/files/$fileId?geometry=paths"),
          headers: {"Content-Type": "application/json", "X-Figma-Token": token},
        ),
        http.get(
          Uri.parse("https://api.figma.com/v1/files/$fileId/images"),
          headers: {"Content-Type": "application/json", "X-Figma-Token": token},
        ),
      ]);

      final fileResponse = responses[0];
      final imagesResponse = responses[1];

      final imagesLinks =
          jsonDecode(imagesResponse.body)["meta"]["images"]
              as Map<String, dynamic>;

      await Future.wait(
        imagesLinks.entries.map((imageLink) async {
          final response = await http.get(Uri.parse(imageLink.value));
          final image = response.bodyBytes;
          final file = await File(
            "$imagesOutput/${imageLink.key}",
          ).create(recursive: true).then((file) => file.writeAsBytes(image));
          return MapEntry(imageLink.key, file.path);
        }),
      );

      if (!Directory(outputDir).existsSync()) {
        Directory(outputDir).createSync(recursive: true);
      }

      await File(output).writeAsString(fileResponse.body, encoding: utf8);
    } catch (e) {
      print('\n❌ Error downloading file: $e');
      exit(1);
    }
  }
}
