import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart' show ThemeMode, Color;
import 'package:sizzle_starter/src/core/utils/preferences_dao.dart';
import 'package:sizzle_starter/src/feature/app/model/app_theme.dart';

/// {@template theme_datasource}
/// [ThemeDataSource] is a data source that provides theme data.
///
/// This is used to set and get theme.
/// {@endtemplate}
abstract interface class ThemeDataSource {
  /// Set theme
  Future<void> setTheme(AppTheme theme);

  /// Get current theme from cache
  Future<AppTheme?> getTheme();
}

/// {@macro theme_datasource}
final class ThemeDataSourceLocal extends PreferencesDao
    implements ThemeDataSource {
  /// {@macro theme_datasource}
  const ThemeDataSourceLocal({
    required super.sharedPreferences,
    required this.codec,
  });

  /// Codec for [ThemeMode]
  final Codec<ThemeMode, String> codec;

  PreferencesEntry<String> get _themeMode => stringEntry('theme.mode');

  @override
  Future<void> setTheme(AppTheme theme) async {
    await _themeMode.setIfNullRemove(codec.encode(theme.mode));
  }

  @override
  Future<AppTheme?> getTheme() async {
    final type = _themeMode.read();

    if (type == null) return null;

    return AppTheme(mode: codec.decode(type));
  }
}
