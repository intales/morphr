import 'dart:io';

import 'package:args/command_runner.dart';
import '../helpers/config_helper.dart';
import '../client.dart';

class SubscriptionCommand extends Command {
  @override
  final name = 'subscription';
  @override
  final description = 'Display user subscription information';

  SubscriptionCommand() {
    argParser.addOption(
      'server',
      abbr: 's',
      help: 'Morphr Cloud server (only for testing)',
      defaultsTo: 'https://cloud.morphr.dev',
    );
  }

  @override
  Future<void> run() async {
    final server = argResults?['server'] as String;
    final client = getClient(server: server);

    final token = ConfigHelper.getToken();
    if (token == null) {
      print(
          '❌ No authentication token found. Please login first with: "morphr login" or "morphr register"');
      exit(1);
    }

    print('🔍 Fetching subscription information...');

    try {
      final response = await client.get('subscription/info');

      _displaySubscriptionInfo(response);
    } catch (e) {
      print('❌ Error fetching subscription information: $e');
      exit(1);
    }
  }

  void _displaySubscriptionInfo(Map<String, dynamic> data) {
    print('\n===== Subscription Information =====\n');

    final plan = data['plan'] as Map<String, dynamic>;
    print('📋 Plan Details:');
    print('  Name: ${plan['name']}');
    print('  Description: ${plan['description']}');
    print('  Sync Limit: ${plan['syncLimit']}');

    final usage = data['usage'] as Map<String, dynamic>;
    print('\n📊 Usage:');
    print('  Sync Count: ${usage['syncCount']}');
    print('  Project Count: ${usage['projectCount']}');
    print('  Remaining Syncs: ${usage['syncRemaining']}');

    final billingPeriod = usage['billingPeriod'] as Map<String, dynamic>;
    print(
        '  Billing Period: ${_formatDate(billingPeriod['start'])} to ${_formatDate(billingPeriod['end'])}');

    final subscription = data['subscription'] as Map<String, dynamic>?;
    if (subscription != null) {
      print('\n💳 Subscription Details:');

      if (subscription['permanent'] == true) {
        print('  ✅ Permanent Subscription');
      } else {
        print('  Status: ${subscription['status']}');
        print('  Start Date: ${_formatDate(subscription['startDate'])}');
        print('  End Date: ${_formatDate(subscription['endDate'])}');
      }

      print('  Type: ${subscription['type']}');
    }

    print('\n✨ You can upgrade your plan at https://morphr.dev/pricing');
  }

  String _formatDate(String isoDate) {
    final date = DateTime.parse(isoDate);
    return '${date.year}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}';
  }
}
