import 'dart:convert';
import 'dart:io';

import 'package:args/command_runner.dart';
import 'package:http/http.dart' as http;
import 'package:interact/interact.dart';
import '../helpers/config_helper.dart';
import 'init.dart';

class FigmaConnectCommand extends Command {
  @override
  final name = 'figma-connect';
  @override
  final description = 'Connect your Morphr account with Figma';

  FigmaConnectCommand() {
    argParser.addOption(
      'server',
      abbr: 's',
      help: 'Morphr Cloud server (only for testing)',
      defaultsTo: 'https://cloud.morphr.dev',
    );
  }

  @override
  Future<void> run() async {
    print('\n🔗 Connect Morphr Cloud with Figma\n');

    final config = ConfigHelper.loadConfig();
    var server = argResults?['server'] as String;

    if (!config.containsKey('access_token') ||
        !config.containsKey('refresh_token')) {
      print('❌ You must be logged in to connect with Figma.');
      print('💡 Use "morphr login" first.');
      exit(1);
    }

    final accessToken = config['access_token'] as String;

    print('🔄 Initiating Figma authorization flow...');

    try {
      final response = await http.post(
        Uri.parse("$server/oauth/figma/start"),
        headers: {
          "Content-Type": "application/json",
          "Authorization": "Bearer $accessToken",
        },
      );

      final responseBody = jsonDecode(response.body);

      if (response.statusCode != 200) {
        final errorMessage = responseBody is String
            ? responseBody
            : (responseBody is Map && responseBody.containsKey('message')
                ? responseBody['message']
                : 'Error starting OAuth flow');

        print('\n❌ Failed to start Figma authorization: $errorMessage');
        exit(1);
      }

      final authUrl = responseBody['auth_url'] as String;
      final state = responseBody['state'] as String;

      ConfigHelper.updateConfig({
        'figma_state': state,
      });

      print('\n✅ Authorization initiated successfully!');
      print('\n📋 Please open the following URL in your browser:');
      print('\n$authUrl\n');
      print(
          '💡 You can CMD+click (Mac) or CTRL+click (Windows/Linux) to open the URL');

      print(
          '📝 The authorization process will complete automatically in the background.');

      final createProject = Confirm(
        prompt: 'Do you want to create a new project now?',
        defaultValue: true,
      ).interact();

      if (createProject) {
        final runner = CommandRunner('morphr', 'Morphr CLI')
          ..addCommand(InitCommand());
        await runner.run(['init', '-s', server]);
      }
    } catch (e) {
      print('\n❌ Error during Figma authorization: $e');
      exit(1);
    }
  }
}
