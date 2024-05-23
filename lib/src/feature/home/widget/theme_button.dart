import 'package:flutter/material.dart';

import 'package:sizzle_starter/src/feature/settings/widget/settings_scope.dart';

class ThemeToggleButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final themeController = SettingsScope.themeOf(context);

    return IconButton(
      padding: EdgeInsets.zero,
      icon: Icon(
        themeController.theme.mode == ThemeMode.light
            ? Icons.nightlight_round
            : Icons.wb_sunny_rounded,
      ),
      onPressed: () {
        final newThemeMode = themeController.theme.mode == ThemeMode.light
            ? ThemeMode.dark
            : ThemeMode.light;
        themeController.setThemeMode(newThemeMode);
      },
    );
  }
}
