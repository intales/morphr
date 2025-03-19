import 'dart:convert';
import 'package:http/http.dart' as http;
import 'dart:io';
import 'package:interact/interact.dart';
import 'package:args/command_runner.dart';
import '../helpers/config_helper.dart';

class RegisterCommand extends Command {
  @override
  final name = 'register';
  @override
  final description = 'Register a new user on Morphr Cloud';

  RegisterCommand() {
    argParser
      ..addOption(
        'email',
        abbr: 'e',
        help: 'Email address',
      )
      ..addOption(
        'name',
        abbr: 'n',
        help: 'User name',
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
    print('\n👤 Welcome on Morphr Cloud! Let\'s create your new account!\n');

    var email = argResults?['email'] as String?;
    var name = argResults?['name'] as String?;
    var password = null as String?;
    var server = argResults?['server'] as String;

    email ??= Input(
      prompt: '📧 Enter your email address',
      validator: (value) {
        if (value.isEmpty) {
          throw ValidationError('❌ Email address cannot be empty');
        }
        if (!value.contains('@') || !value.contains('.')) {
          throw ValidationError('❌ Email address is not vaild');
        }
        return true;
      },
    ).interact();

    name ??= Input(
      prompt: '📝 Enter your name',
      validator: (value) {
        if (value.isEmpty) {
          throw ValidationError('❌ Name cannot be empty');
        }
        return true;
      },
    ).interact();

    password ??= Password(
      prompt: '🔑 Create a password',
    ).interact();

    final confirmPassword = Password(
      prompt: '🔑 Confirm your new password',
    ).interact();

    print('\n📤 Account registration in progress...');

    try {
      final response = await http.post(
        Uri.parse("$server/register"),
        headers: {
          "Content-Type": "application/json",
        },
        body: jsonEncode({
          "email": email,
          "name": name,
          "password": password,
          "confirmPassword": confirmPassword,
        }),
      );

      final responseBody = jsonDecode(response.body);

      if (response.statusCode != 200) {
        final errorMessage = responseBody is String
            ? responseBody
            : (responseBody is Map && responseBody.containsKey('message')
                ? responseBody['message']
                : 'Error during registration process.');

        print('\n❌ Registration failed: $errorMessage');
        exit(1);
      }

      final userId = responseBody['userId'];

      ConfigHelper.updateConfig({
        'userId': userId,
      });

      print('\n✅ Registration completed successfully!');
      print('📧 We have sent you an email with a verification code.');
      print('📝 Use the "morphr verify" command to verify your new account.\n');
    } catch (e) {
      print('\n❌ Error during registration process: $e');
      exit(1);
    }
  }
}
