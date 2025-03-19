import 'dart:convert';
import 'dart:io';

import 'package:args/command_runner.dart';
import 'package:interact/interact.dart';
import 'package:http/http.dart' as http;
import '../helpers/config_helper.dart';
import 'figma_connect.dart';

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
    print('\n🔐 Verify your Morphr account!\n');

    final config = ConfigHelper.loadConfig();

    final userId = config['userId'] as int;
    var code = argResults?['code'] as String?;
    var server = argResults?['server'] as String;

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

    print('\n🔄 Verifying your account...');

    try {
      final response = await http.post(
        Uri.parse("$server/verify"),
        headers: {
          "Content-Type": "application/json",
        },
        body: jsonEncode({
          "userId": userId,
          "code": code,
        }),
      );

      final responseBody = jsonDecode(response.body);

      if (response.statusCode != 200) {
        final errorMessage = responseBody is String
            ? responseBody
            : (responseBody is Map && responseBody.containsKey('message')
                ? responseBody['message']
                : 'Errore durante la verifica');

        print('\n❌ Verifica fallita: $errorMessage');
        exit(1);
      }

      if (responseBody['success'] == true) {
        ConfigHelper.updateConfig({
          'access_token': responseBody['accessToken'],
          'refresh_token': responseBody['refreshToken'],
        });
        print('\n✅ Your account is now active!');

        final verify = Confirm(
          prompt: 'Do you want to connect Figma to your account now?',
          defaultValue: true,
        ).interact();

        if (verify) {
          final runner = CommandRunner('morphr', 'Morphr CLI')
            ..addCommand(FigmaConnectCommand());
          await runner.run(['figma-connect', '-s', server]);
        } else {
          print(
              '🔗 To connect Figma to your account use "morphr figma-connect."');
        }
      } else {
        print('\n❌ Verify process failed: ${responseBody['message']}');
      }
    } catch (e) {
      print('\n❌ Error while verifying user: $e');
      exit(1);
    }
  }
}
