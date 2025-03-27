import 'dart:io';

import 'package:args/command_runner.dart';
import '../helpers/config_helper.dart';
import '../client.dart';

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
    final config = ConfigHelper.loadConfig();
    var server = argResults?['server'] as String;
    final client = getClient(server: server);

    if (!config.containsKey('access_token') ||
        !config.containsKey('refresh_token')) {
      print('❌ You must be logged in to connect with Figma.');
      print('💡 Use "morphr login" or "morphr register" first.');
      exit(1);
    }

    print('🔄 Initiating Figma authorization flow...');

    try {
      final response = await client.post("oauth/figma/start");
      final authUrl = response['auth_url'] as String;

      print('✅ Authorization initiated successfully!');
      print('📋 Please open the following URL in your browser:');
      print('$authUrl\n');
      print(
          '💡 You can CMD+click (Mac) or CTRL+click (Windows/Linux) to open the URL');
    } catch (e) {
      print('\n❌ Error during Figma authorization: $e');
      exit(1);
    }
  }
}
