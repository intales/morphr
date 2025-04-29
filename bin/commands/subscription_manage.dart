// Copyright (c) 2025 Intales Srl. All rights reserved.
// Use of this source code is governed by a MIT license that can be found
// in the LICENSE file.

//ignore_for_file:avoid_print
import 'dart:io';

import 'package:args/command_runner.dart';
import 'package:interact/interact.dart';
import '../helpers/config_helper.dart';
import '../client.dart';

class SubscriptionManageCommand extends Command {
  @override
  final name = 'manage';
  @override
  final description = 'Create or update your Morphr subscription plan';

  SubscriptionManageCommand() {
    argParser
      ..addOption(
        'plan-id',
        abbr: 'p',
        help: 'Subscription plan ID (pro, business)',
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
    var planId = argResults?['plan-id'] as String?;
    final server = argResults?['server'] as String;
    final client = getClient(server: server);

    final token = ConfigHelper.getToken();
    if (token == null) {
      print(
        '❌ No authentication token found. Please login first with: "morphr login" or "morphr register"',
      );
      exit(1);
    }

    final availablePlans = {
      'pro': {
        'name': 'Pro',
        'description': 'Pro plan with 100 syncs/month',
        'id': 2,
      },
      'business': {
        'name': 'Business',
        'description': 'Business plan with 300 syncs/month',
        'id': 3,
      },
    };

    try {
      final subscriptionInfo = await client.get("subscription/info");
      final currentPlan = subscriptionInfo['plan']['name'];

      print('💳 Current plan: $currentPlan');

      if (planId == null) {
        final selection =
            Select(
              prompt: '📋 Select a subscription plan',
              options:
                  availablePlans.keys
                      .map(
                        (k) =>
                            '${availablePlans[k]!['name']} - ${availablePlans[k]!['description']}',
                      )
                      .toList(),
            ).interact();

        planId = availablePlans.keys.toList()[selection];
      } else if (!availablePlans.containsKey(planId)) {
        print(
          '❌ Invalid plan ID. Available plans: ${availablePlans.keys.join(', ')}',
        );
        exit(1);
      }

      print('🔄 Processing subscription request...');

      final response = await client.post(
        "subscription/manage",
        body: {"subscriptionPlanId": availablePlans[planId]!['id']},
      );

      final url = response["body"];
      final hasStripeAccount =
          subscriptionInfo['subscription']?['stripeSubscriptionId'] != null;
      final actionWord = hasStripeAccount ? "manage" : "create";

      print('✅ Subscription link generated successfully!');
      print(
        '📋 Please open the following URL in your browser to $actionWord your subscription:',
      );
      print('$url\n');
      print(
        '💡 You can CMD+click (Mac) or CTRL+click (Windows/Linux) to open the URL',
      );
    } catch (e) {
      print('\n❌ Error managing subscription: $e');
      exit(1);
    }
  }
}
