// Copyright (c) 2025 Intales Srl. All rights reserved.
// Use of this source code is governed by a MIT license that can be found
// in the LICENSE file.

//ignore_for_file:avoid_print
import 'dart:io';
import 'package:args/command_runner.dart';
import 'commands/register.dart';
import 'commands/verify.dart';
import 'commands/login.dart';
import 'commands/figma_connect.dart';
import 'commands/init.dart';
import 'commands/sync.dart';
import 'commands/subscription.dart';
import 'commands/download.dart';

void main(List<String> arguments) {
  final runner =
      CommandRunner('morphr', 'CLI tool for Morphr library')
        ..addCommand(RegisterCommand())
        ..addCommand(VerifyCommand())
        ..addCommand(LoginCommand())
        ..addCommand(FigmaConnectCommand())
        ..addCommand(InitCommand())
        ..addCommand(SyncCommand())
        ..addCommand(SubscriptionCommand())
        ..addCommand(DownloadCommand());

  runner.run(arguments).catchError((error) {
    if (error is! UsageException) throw error;
    print(error);
    exit(64);
  });
}
