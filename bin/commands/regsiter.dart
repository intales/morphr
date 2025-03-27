import 'dart:io';
import 'package:interact/interact.dart';
import 'package:args/command_runner.dart';
import '../helpers/config_helper.dart';
import '../client.dart';

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
    String? email = argResults?['email'] as String?;
    String? name = argResults?['name'] as String?;
    String? server = argResults?['server'] as String;
    String? password;
    String? confirmPassword;
    final client = getClient(server: server);

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

    password = Password(
      prompt: '🔑 Create a password',
    ).interact();

    while (password?.isEmpty ?? true) {
      print("❌ Password cannot be empty");
      password = Password(
        prompt: '🔑 Create a password',
      ).interact();
    }

    confirmPassword = Password(
      prompt: '🔑 Confirm your new password',
    ).interact();

    while (password != confirmPassword) {
      print("❌ Password don't match");
      confirmPassword = Password(
        prompt: '🔑 Confirm your new password',
      ).interact();
    }

    print('📤 Account registration in progress...');

    try {
      final response = await client.post(
        "register",
        requiresAuth: false,
        body: {
          "email": email,
          "name": name,
          "password": password,
          "confirmPassword": confirmPassword,
        },
      );
      final userId = response['userId'];

      ConfigHelper.updateConfig({
        'userId': userId,
      });

      print('✅ Registration completed successfully!');
      print('📧 We have sent you an email with a verification code.');
      print('📝 Use the "morphr verify" command to verify your new account.');
    } catch (e) {
      print('\n❌ Error during registration process: $e');
      exit(1);
    }
  }
}
