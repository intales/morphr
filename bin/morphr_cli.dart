// Copyright (c) 2025 Intales Srl. All rights reserved.
// Use of this source code is governed by a MIT license that can be found
// in the LICENSE file.

//ignore_for_file:avoid_print
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:io';
import 'package:interact/interact.dart';
import 'package:args/command_runner.dart';
import 'commands/regsiter.dart';
import 'commands/verify.dart';
import 'commands/login.dart';
import 'commands/figma_connect.dart';

void main(List<String> arguments) {
  final runner = CommandRunner('morphr', 'CLI tool for Morphr library')
    ..addCommand(RegisterCommand())
    ..addCommand(VerifyCommand())
    ..addCommand(LoginCommand())
    ..addCommand(FigmaConnectCommand())
    ..addCommand(DownloadCommand());

  runner.run(arguments).catchError((error) {
    if (error is! UsageException) throw error;
    print(error);
    exit(64);
  });
}

class DownloadCommand extends Command {
  @override
  final name = 'download';
  @override
  final description = 'Download Figma file as JSON';

  DownloadCommand() {
    argParser
      ..addOption(
        'token',
        abbr: 't',
        help: 'Figma access token',
      )
      ..addOption(
        'file',
        abbr: 'f',
        help: 'Figma file ID',
      )
      ..addOption(
        'output',
        abbr: 'o',
        help: 'Output file path',
      );
  }

  @override
  Future<void> run() async {
    var token = argResults?['token'] as String?;
    var fileId = argResults?['file'] as String?;
    var output = argResults?['output'] as String?;

    print('\n🎨 Welcome to Morphr CLI! Let\'s download your Figma file!\n');

    token ??= Input(
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

    fileId ??= Input(
      prompt: '📁 Enter your Figma file ID',
      validator: (value) {
        if (value.isEmpty) {
          throw ValidationError('❌ File ID cannot be empty');
        }
        return true;
      },
    ).interact();

    output ??= Input(
      prompt: '💾 Where should I save the JSON file?',
      defaultValue: 'figma_file.json',
      validator: (value) {
        if (value.isEmpty) {
          throw ValidationError('❌ Output path cannot be empty');
        }
        return true;
      },
    ).interact();

    print('\n📥 Downloading Figma file $fileId...');

    try {
      final response = await http.get(
        Uri.parse("https://api.figma.com/v1/files/$fileId?geometry=paths"),
        headers: {
          "Content-Type": "application/json",
          "X-Figma-Token": token,
        },
      );

      final json = response.body;
      await File(output).writeAsString(json, encoding: utf8);

      print('\n✨ File successfully downloaded and saved to $output');
      print('🎉 Happy coding with Morphr!\n');
    } catch (e) {
      print('\n❌ Error downloading file: $e');
      exit(1);
    }
  }
}
