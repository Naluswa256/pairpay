import 'package:shared_preferences/shared_preferences.dart';
import 'package:sizzle_starter/src/feature/app/logic/tracking_manager.dart';
import 'package:sizzle_starter/src/feature/onboarding/bloc/authenticaton_bloc.dart';
import 'package:sizzle_starter/src/feature/settings/bloc/settings_bloc.dart';

/// {@template dependencies}
/// Dependencies container
/// {@endtemplate}
base class Dependencies {
  /// {@macro dependencies}
  const Dependencies({
    required this.sharedPreferences,
    required this.settingsBloc,
    required this.errorTrackingManager,
    required this.authenticationBloc,
  });

  /// [SharedPreferences] instance, used to store Key-Value pairs.
  final SharedPreferences sharedPreferences;

  /// [SettingsBloc] instance, used to manage theme and locale.
  final SettingsBloc settingsBloc;

  /// [ErrorTrackingManager] instance, used to report errors.
  final ErrorTrackingManager errorTrackingManager;
  /// [AuthenticationBloc] instance, used to handle authentication.
  final AuthenticationBloc authenticationBloc;
}

/// {@template initialization_result}
/// Result of initialization
/// {@endtemplate}
final class InitializationResult {
  /// {@macro initialization_result}
  const InitializationResult({
    required this.dependencies,
    required this.msSpent,
  });

  /// The dependencies
  final Dependencies dependencies;

  /// The number of milliseconds spent
  final int msSpent;


  @override
  String toString() => '$InitializationResult('
      'dependencies: $dependencies, '
      'msSpent: $msSpent'
      ')';
}
