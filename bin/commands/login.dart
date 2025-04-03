// Copyright (c) 2025 Intales Srl. All rights reserved.
// Use of this source code is governed by a MIT license that can be found
// in the LICENSE file.

//ignore_for_file:avoid_print
import 'dart:convert';
import 'dart:io';

import 'package:args/command_runner.dart';
import 'package:interact/interact.dart';
import 'package:http/http.dart' as http;
import '../helpers/config_helper.dart';
import 'verify.dart';

class LoginCommand extends Command {
  @override
  final name = 'login';
  @override
  final description = 'Login to Morphr Cloud';

  LoginCommand() {
    argParser
      ..addOption(
        'email',
        abbr: 'e',
        help: 'Email address',
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
    print('\n🔑 Login to Morphr Cloud!\n');

    var email = argResults?['email'] as String?;
    var password = null as String?;
    var server = argResults?['server'] as String;

    final config = ConfigHelper.loadConfig();
    if (email == null && config.containsKey('email')) {
      email = config['email'] as String;
      print('📧 Using email from configuration: $email');
    }

    email ??= Input(
      prompt: '📧 Enter your email address',
      validator: (value) {
        if (value.isEmpty) {
          throw ValidationError('❌ Email cannot be empty');
        }
        if (!value.contains('@') || !value.contains('.')) {
          throw ValidationError('❌ Invalid email format');
        }
        return true;
      },
    ).interact();

    password ??= Password(
      prompt: '🔑 Enter your password',
    ).interact();

    print('\n🔄 Logging in...');

    try {
      final response = await http.post(
        Uri.parse("$server/login"),
        headers: {
          "Content-Type": "application/json",
        },
        body: jsonEncode({
          "email": email,
          "password": password,
        }),
      );

      final responseBody = jsonDecode(response.body);

      if (response.statusCode != 200) {
        final errorMessage = responseBody is String
            ? responseBody
            : (responseBody is Map && responseBody.containsKey('message')
                ? responseBody['message']
                : 'Error during login');

        print('\n❌ Login failed: $errorMessage');
        exit(1);
      }

      if (responseBody['verified'] == true) {
        ConfigHelper.updateConfig({
          'access_token': responseBody['accessToken'],
          'refresh_token': responseBody['refreshToken'],
          'email': email,
        });

        if (responseBody.containsKey('user') && responseBody['user'] != null) {
          final user = responseBody['user'];
          print('\n✅ Login successful!');
          print('👤 Welcome back, ${user['name']}!');
        } else {
          print('\n✅ Login successful!');
        }
      } else {
        if (responseBody.containsKey('userId')) {
          ConfigHelper.updateConfig({
            'userId': responseBody['userId'],
            'email': email,
            'server': server,
          });

          print('\n⚠️ Your account is not verified.');
          print('📝 Please check your email for a verification code.');
          print('🔐 Use "morphr verify" to complete the verification process.');

          final verify = Confirm(
            prompt: 'Do you want to verify your account now?',
            defaultValue: true,
          ).interact();

          if (verify) {
            final runner = CommandRunner('morphr', 'Morphr CLI')
              ..addCommand(VerifyCommand());
            await runner.run(['verify', '-s', server]);
          }
        } else {
          print(
              '\n❌ Login failed: ${responseBody['message'] ?? 'Unknown error'}');
        }
      }
    } catch (e) {
      print('\n❌ Error during login: $e');
      exit(1);
    }
  }
}
