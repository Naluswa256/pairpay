
// ignore_for_file: unused_element

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sizzle_starter/src/core/utils/logger.dart';

/// {@template preferences_dao}
/// Class that provides seamless access to the shared preferences.
///
/// Inspired by https://pub.dev/packages/typed_preferences
/// {@endtemplate}
abstract base class PreferencesDao {
  final SharedPreferences _sharedPreferences;

  /// {@macro preferences_dao}
  const PreferencesDao({required SharedPreferences sharedPreferences})
      : _sharedPreferences = sharedPreferences;

  /// Obtain [bool] entry from the preferences.
  PreferencesEntry<bool> boolEntry(String key) => TypedEntry<bool>(
        key: key,
        sharedPreferences: _sharedPreferences,
      );

  /// Obtain [double] entry from the preferences.
  PreferencesEntry<double> doubleEntry(String key) => TypedEntry<double>(
        key: key,
        sharedPreferences: _sharedPreferences,
      );

  /// Obtain [int] entry from the preferences.
  PreferencesEntry<int> intEntry(String key) => TypedEntry<int>(
        key: key,
        sharedPreferences: _sharedPreferences,
      );

  /// Obtain [String] entry from the preferences.
  PreferencesEntry<String> stringEntry(String key) => TypedEntry<String>(
        key: key,
        sharedPreferences: _sharedPreferences,
      );

  /// Obtain [Iterable<String>] entry from the preferences.
  PreferencesEntry<Iterable<String>> iterableStringEntry(String key) =>
      TypedEntry<Iterable<String>>(
        key: key,
        sharedPreferences: _sharedPreferences,
      );
}

/// {@template preferences_entry}
/// [PreferencesEntry] describes a single entry in the preferences.
/// This is used to get and set values in the preferences.
/// {@endtemplate}
abstract base class PreferencesEntry<T extends Object> {
  /// {@macro preferences_entry}
  const PreferencesEntry();

  /// The key of the entry in the preferences.
  String get key;

  /// Obtain the value of the entry from the preferences.
  T? read();

  /// Set the value of the entry in the preferences.
  Future<void> set(T value);

  /// Remove the entry from the preferences.
  Future<void> remove();

  /// Set the value of the entry in the preferences if the value is not null.
  Future<void> setIfNullRemove(T? value) =>
      value == null ? remove() : set(value);
}

/// {@template typed_entry}
/// A [PreferencesEntry] that is typed to a specific type [T].
/// {@endtemplate}
final class TypedEntry<T extends Object> extends PreferencesEntry<T> {
  /// {@macro typed_entry}
  TypedEntry({
    required SharedPreferences sharedPreferences,
    required this.key,
  }) : _sharedPreferences = sharedPreferences,
       _listeners = <VoidCallback>[];


  final SharedPreferences _sharedPreferences;
  final List<VoidCallback> _listeners;

  @override
  final String key;

  @override
  T? read() {
    try {
      final value = _sharedPreferences.get(key);
      logger.info('Read value for key "$key": $value');

      if (value == null) return null;

      if (value is T) return value;

      throw Exception(
        'The value of $key is not of type ${T.runtimeType.toString()}',
      );
    } catch (e, stackTrace) {
      logger.error('Error reading value for key "$key"', error: e, stackTrace: stackTrace);
      rethrow;
    }
  }

  @override
  Future<void> set(T value) async {
    try {
      await switch (value) {
        final int value => _sharedPreferences.setInt(key, value),
        final double value => _sharedPreferences.setDouble(key, value),
        final String value => _sharedPreferences.setString(key, value),
        final bool value => _sharedPreferences.setBool(key, value),
        final Iterable<String> value => _sharedPreferences.setStringList(
            key,
            value.toList(),
          ),
        _ => throw Exception(
            '$T is not a valid type for a preferences entry value.',
          ),
      };
      logger.info('Set value for key "$key": $value');
      _notifyListeners();
    } catch (e, stackTrace) {
      logger.error('Error setting value for key "$key"', error: e, stackTrace: stackTrace);
      rethrow;
    }
  }

  @override
  Future<void> remove() async {
    try {
      await _sharedPreferences.remove(key);
      logger.info('Removed value for key "$key"');
       _notifyListeners();
    } catch (e, stackTrace) {
      logger.error('Error removing value for key "$key"', error: e, stackTrace: stackTrace);
      rethrow;
    }
  }
  /// Adds a listener to be notified when the value of this entry changes.
  ///
  /// The listener will be called synchronously whenever the value is set or removed.
  void addListener(VoidCallback listener) {
    _listeners.add(listener);
  }

  /// Removes a listener from this entry.
  ///
  /// The listener will no longer be called when the value changes.
  void removeListener(VoidCallback listener) {
    _listeners.remove(listener);
  }

  void _notifyListeners() {
    for (final listener in _listeners) {
      listener();
    }
  }
}
