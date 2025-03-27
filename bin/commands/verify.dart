import 'dart:io';

import 'package:args/command_runner.dart';
import 'package:interact/interact.dart';
import '../helpers/config_helper.dart';
import '../client.dart';

class VerifyCommand extends Command {
  @override
  final name = 'verify';
  @override
  final description = 'Verify a Morphr Cloud account';

  VerifyCommand() {
    argParser
      ..addOption(
        'code',
        abbr: 'c',
        help: 'Verification code',
      )
      ..addOption(
        'server',
        abbr: 's',
        help: 'Morphr Cloud server (only for testing)',
        defaultsTo: 'https://cloud.morphr.dev',
      );
  }

  @override
  Future<void> run() async {
    var code = argResults?['code'] as String?;
    var server = argResults?['server'] as String;
    final config = ConfigHelper.loadConfig();
    final userId = config['userId'] as int;
    final client = getClient(server: server);

    code ??= Input(
      prompt: '🔑 Enter the verification code that you have received by email',
      validator: (value) {
        if (value.isEmpty) {
          throw ValidationError('❌ Code cannot be empty');
        }
        if (value.length != 6) {
          throw ValidationError('❌ Code should be 6 characters long');
        }
        return true;
      },
    ).interact();

    print('🔄 Verifying your account...');

    try {
      final response = await client.post(
        "verify",
        requiresAuth: false,
        body: {
          "userId": userId,
          "code": code,
        },
      );

      if (response['success'] == true) {
        ConfigHelper.updateConfig({
          'access_token': response['accessToken'],
          'refresh_token': response['refreshToken'],
        });

        print('✅ Your account is now active!');
        print(
            '🔗 To connect Figma to your account use "morphr figma-connect."');
      } else {
        print('❌ Error while verifying user: ${response['message']}');
      }
    } catch (e) {
      print('❌ Error while verifying user: $e');
      exit(1);
    }
  }
}
