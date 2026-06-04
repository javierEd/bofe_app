import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:settings_ui/settings_ui.dart';

import '../build_context.dart';
import '../components/loading_overlay.dart';
import '../components/screen_title.dart';
import '../components/snackbar_alert.dart';
import '../constants.dart';
import '../preferences.dart';
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

  void _showLogoutDialog(BuildContext context) {
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
  }

  void _showThemeDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Select Theme'),
        content: RadioGroup(
          groupValue: Preferences.themeMode,
          onChanged: (value) {
            Preferences.themeMode = value!;
          },
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: ThemeMode.values
                .map<RadioListTile<ThemeMode>>(
                  (themeMode) => RadioListTile(title: Text(themeModeLabels[themeMode]!), value: themeMode),
                )
                .toList(),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return ScreenTitle(
      title: 'Settings',
      child: Scaffold(
        appBar: AppBar(title: const Text('Settings')),
        body: SettingsList(
          sections: [
            SettingsSection(
              title: Text('General'),
              tiles: [
                SettingsTile(
                  leading: const Icon(Icons.brightness_6_rounded),
                  title: const Text('Theme'),
                  value: Preferences.themeModeListenableBuilder(
                    builder: (context, value) => Text(themeModeLabels[value]!),
                  ),
                  onPressed: _showThemeDialog,
                ),
              ],
            ),
            SettingsSection(
              title: Text('Account'),
              tiles: SessionManager.hasToken
                  ? [
                      SettingsTile.navigation(
                        leading: const Icon(Icons.person_rounded),
                        title: const Text('Edit Profile'),
                        onPressed: (context) => context.router.goToEditProfile(),
                      ),
                      SettingsTile.navigation(
                        leading: const Icon(Icons.password_rounded),
                        title: const Text('Change Password'),
                        onPressed: (context) => context.router.goToChangePassword(),
                      ),
                      SettingsTile(
                        leading: const Icon(Icons.logout_rounded),
                        title: const Text('Logout'),
                        onPressed: _showLogoutDialog,
                      ),
                    ]
                  : [
                      SettingsTile.navigation(
                        leading: const Icon(Icons.login_rounded),
                        title: const Text('Login'),
                        onPressed: (context) => context.router.goToLogin(),
                      ),
                      SettingsTile.navigation(
                        leading: const Icon(Icons.person_add_rounded),
                        title: const Text('Register'),
                        onPressed: (context) => context.router.goToRegister(),
                      ),
                    ],
            ),
          ],
        ),
      ),
    );
  }
}
