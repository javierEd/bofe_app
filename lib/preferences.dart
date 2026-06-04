import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'constants.dart';

class Preferences {
  static final SharedPreferencesAsync _sharedPreferences = SharedPreferencesAsync();
  static final ValueNotifier<ThemeMode> _themeMode = ValueNotifier(ThemeMode.system);

  static set themeMode(ThemeMode value) {
    _themeMode.value = value;
    _sharedPreferences.setString(keyThemeMode, value.name);
  }

  static ThemeMode get themeMode => _themeMode.value;

  static ValueListenableBuilder<ThemeMode> themeModeListenableBuilder({
    required Widget Function(BuildContext, ThemeMode) builder,
  }) =>
      ValueListenableBuilder(valueListenable: _themeMode, builder: (context, value, child) => builder(context, value));

  static Future<void> init() async {
    final themeMode = await _sharedPreferences.getString(keyThemeMode);

    if (themeMode != null) {
      _themeMode.value = ThemeMode.values.byName(themeMode);
    }
  }
}
