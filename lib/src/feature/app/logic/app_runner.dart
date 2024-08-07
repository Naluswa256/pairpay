import 'dart:async';

import 'package:bloc_concurrency/bloc_concurrency.dart' as bloc_concurrency;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart' as path_provider;
import 'package:sizzle_starter/src/core/constant/config.dart';
import 'package:sizzle_starter/src/core/utils/app_bloc_observer.dart';
import 'package:sizzle_starter/src/core/utils/logger.dart';
import 'package:sizzle_starter/src/feature/Dashboard/data/local/hive_helper/dashboard_database_service.dart';
import 'package:sizzle_starter/src/feature/app/model/user_model.dart';
import 'package:sizzle_starter/src/feature/app/widget/app.dart';
import 'package:sizzle_starter/src/feature/initialization/logic/initialization_processor.dart';
import 'package:sizzle_starter/src/feature/initialization/widget/initialization_failed_app.dart';

/// {@template app_runner}
/// A class which is responsible for initialization and running the app.
/// {@endtemplate}
final class AppRunner {
  /// {@macro app_runner}
  const AppRunner();

  /// Start the initialization and in case of success run application
  Future<void> initializeAndRun() async {
    final binding = WidgetsFlutterBinding.ensureInitialized();

    // Preserve splash screen
    binding.deferFirstFrame();

    // Override logging
    FlutterError.onError = logger.logFlutterError;
    WidgetsBinding.instance.platformDispatcher.onError =
        logger.logPlatformDispatcherError;

    // Setup bloc observer and transformer
    Bloc.observer = const AppBlocObserver();
    Bloc.transformer = bloc_concurrency.sequential();
    const config = Config();
    const initializationProcessor = InitializationProcessor(config);

    Future<void> initializeAndRun() async {
      try {
        final result = await initializationProcessor.initialize();
        final appDocumentDir =
        await path_provider.getApplicationDocumentsDirectory();
        Hive.init(appDocumentDir.path);

        Hive.registerAdapter(UserAdapter());
        final homeDataBaseService = result.dependencies.homeDatabaseService;
        await homeDataBaseService.initDataBase();
        await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
        runApp(App(result: result));
      } catch (e, stackTrace) {
        logger.error('Initialization failed', error: e, stackTrace: stackTrace);
        runApp(
          InitializationFailedApp(
            error: e,
            stackTrace: stackTrace,
            retryInitialization: initializeAndRun,
          ),
        );
      } finally {
        // Allow rendering
        binding.allowFirstFrame();
      }
    }

    // Run the app
    await initializeAndRun();
  }
}
