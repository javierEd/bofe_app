import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../components/loading_overlay.dart';
import '../components/login_buttons.dart';
import '../components/snackbar_alert.dart';
import '../session_manager.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  Future<void> _attemptToLogout(BuildContext context) async {
    final loadingOverlay = showLoadingOverlay(context);
    final result = await SessionManager.attemptToLogout(context);

    if (context.mounted && result.parsedData?.finishSession != true) {
      final errors = result.exception?.graphqlErrors.first;

      showSnackBarAlert(context, errors?.message ?? 'Failed to logout');
    }

    loadingOverlay.hide();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Settings')),
      body: Center(
        child: Container(
          margin: const EdgeInsets.all(16),
          width: 640,
          child: Column(
            spacing: 16,
            children: [
              SessionManager.hasToken
                  ? SizedBox(
                      width: double.infinity,
                      child: OutlinedButton.icon(
                        onPressed: () {
                          showDialog(
                            context: context,
                            builder: (context) => AlertDialog(
                              title: const Text('Confirm your action'),
                              content: const Text('Are you sure you want to logout?'),
                              actions: [
                                OutlinedButton(child: const Text('Cancel'), onPressed: () => context.pop()),
                                FilledButton(
                                  child: const Text('Confirm'),
                                  onPressed: () {
                                    context.pop();
                                    _attemptToLogout(context);
                                  },
                                ),
                              ],
                            ),
                          );
                        },
                        icon: const Icon(Icons.logout_rounded),
                        label: const Text('Logout'),
                      ),
                    )
                  : const LoginButtons(),
            ],
          ),
        ),
      ),
    );
  }
}
