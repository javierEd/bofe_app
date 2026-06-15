import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:settings_ui/settings_ui.dart';

import '../components.dart';
import '../l10n/app_localizations.g.dart';
import '../build_context.dart';
import '../components/loading_overlay.dart';
import '../components/screen_title.dart';
import '../preferences.dart';
import '../session_manager.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  Future<void> _attemptToLogout(BuildContext context) async {
    final loadingOverlay = showLoadingOverlay(context);
    final result = await SessionManager.attemptToLogout(context);

    if (context.mounted && result.parsedData?.finishSession != true) {
      final errors = result.exception?.graphqlErrors.first;

      showSnackBarAlert(context, errors?.message ?? context.l10n.failedToLogout);
    }

    loadingOverlay.hide();
  }

  void _showLogoutDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(context.l10n.confirm),
        content: Text(context.l10n.areYouSureYouWantToLogout),
        actions: [
          OutlinedButton(child: Text(context.l10n.cancel), onPressed: () => context.pop()),
          FilledButton(
            child: Text(context.l10n.ok),
            onPressed: () {
              context.pop();
              _attemptToLogout(context);
            },
          ),
        ],
      ),
    );
  }

  void _showLanguageDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(context.l10n.selectLanguage),
        content: RadioGroup(
          groupValue: Preferences.language,
          onChanged: (value) {
            Preferences.language = value!;
          },
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: AppLocalizations.supportedLocales
                .map<RadioListTile<Locale>>(
                  (locale) => RadioListTile(title: Text(context.l10n.languages(locale.languageCode)), value: locale),
                )
                .toList(),
          ),
        ),
      ),
    );
  }

  void _showThemeDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(context.l10n.selectTheme),
        content: RadioGroup(
          groupValue: Preferences.themeMode,
          onChanged: (value) {
            Preferences.themeMode = value!;
          },
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: ThemeMode.values
                .map<RadioListTile<ThemeMode>>(
                  (themeMode) => RadioListTile(title: Text(context.l10n.themes(themeMode.name)), value: themeMode),
                )
                .toList(),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final title = context.l10n.settings;

    return ScreenTitle(
      title: title,
      child: Scaffold(
        appBar: AppBar(title: Text(title)),
        body: SettingsList(
          sections: [
            SettingsSection(
              title: Text(context.l10n.general),
              tiles: [
                SettingsTile(
                  leading: const Icon(Icons.brightness_6_rounded),
                  title: Text(context.l10n.theme),
                  value: Preferences.listenableBuilder(
                    builder: (context, data) => Text(context.l10n.themes(data.themeMode.name)),
                  ),
                  onPressed: _showThemeDialog,
                ),
                SettingsTile(
                  leading: const Icon(Icons.language_rounded),
                  title: Text(context.l10n.language),
                  value: Preferences.listenableBuilder(
                    builder: (context, data) => Text(context.l10n.languages(data.language.languageCode)),
                  ),
                  onPressed: _showLanguageDialog,
                ),
              ],
            ),
            SettingsSection(
              title: Text(context.l10n.account),
              tiles: SessionManager.hasToken
                  ? [
                      SettingsTile.navigation(
                        leading: const Icon(Icons.person_rounded),
                        title: Text(context.l10n.editProfile),
                        onPressed: (context) => context.router.goToEditProfile(),
                      ),
                      SettingsTile.navigation(
                        leading: const Icon(Icons.email_rounded),
                        title: Text(context.l10n.emailAddress),
                        onPressed: (context) => context.router.goToSettingsEmail(),
                      ),
                      SettingsTile.navigation(
                        leading: const Icon(Icons.password_rounded),
                        title: Text(context.l10n.changePassword),
                        onPressed: (context) => context.router.goToChangePassword(),
                      ),
                      SettingsTile(
                        leading: const Icon(Icons.logout_rounded),
                        title: Text(context.l10n.logout),
                        onPressed: _showLogoutDialog,
                      ),
                    ]
                  : [
                      SettingsTile.navigation(
                        leading: const Icon(Icons.login_rounded),
                        title: Text(context.l10n.login),
                        onPressed: (context) => context.router.goToLogin(),
                      ),
                      SettingsTile.navigation(
                        leading: const Icon(Icons.person_add_rounded),
                        title: Text(context.l10n.register),
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
