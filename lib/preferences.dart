import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'l10n/app_localizations.g.dart';
import 'constants.dart';

class Preferences {
  static final SharedPreferencesAsync _sharedPreferences = SharedPreferencesAsync();

  static final ValueNotifier<PreferencesData> _data = ValueNotifier(
    PreferencesData(language: const Locale('en'), themeMode: ThemeMode.system),
  );

  static Future<Locale> _getStoredLanguage() async {
    final code = await _sharedPreferences.getString(keyLanguage) ?? 'en';
    final language = Locale(code);

    if (!AppLocalizations.supportedLocales.contains(language)) {
      return AppLocalizations.supportedLocales.first;
    }

    return language;
  }

  static Future<ThemeMode> _getStoredTheme() async {
    try {
      return ThemeMode.values.byName(await _sharedPreferences.getString(keyThemeMode) ?? 'system');
    } catch (e) {
      return ThemeMode.system;
    }
  }

  static set language(Locale value) {
    _data.value = _data.value.copyWith(language: value);
    _sharedPreferences.setString(keyLanguage, value.languageCode);
  }

  static Locale get language => _data.value.language;

  static set themeMode(ThemeMode value) {
    _data.value = _data.value.copyWith(themeMode: value);
    _sharedPreferences.setString(keyThemeMode, value.name);
  }

  static ThemeMode get themeMode => _data.value.themeMode;

  static ValueListenableBuilder<PreferencesData> listenableBuilder({
    required Widget Function(BuildContext context, PreferencesData data) builder,
  }) => ValueListenableBuilder(valueListenable: _data, builder: (context, value, child) => builder(context, value));

  static Future<void> init() async {
    final language = await _getStoredLanguage();
    final themeMode = await _getStoredTheme();

    _data.value = PreferencesData(language: language, themeMode: themeMode);
  }
}

class PreferencesData {
  PreferencesData({required this.language, required this.themeMode});

  Locale language;
  ThemeMode themeMode;

  PreferencesData copyWith({Locale? language, ThemeMode? themeMode}) {
    return PreferencesData(language: language ?? this.language, themeMode: themeMode ?? this.themeMode);
  }
}
