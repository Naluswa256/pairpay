// ignore_for_file: unused_local_variable, lines_longer_than_80_chars

import 'package:dio/dio.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sizzle_starter/src/core/components/rest_client/src/auth/auth_interceptor.dart';
import 'package:sizzle_starter/src/core/components/rest_client/src/auth/refresh_client.dart';
import 'package:sizzle_starter/src/core/components/rest_client/src/auth/token_storage.dart';
import 'package:sizzle_starter/src/core/components/rest_client/src/rest_client_dio.dart';
import 'package:sizzle_starter/src/core/constant/config.dart';
import 'package:sizzle_starter/src/core/services/localStorage/shared_pref.service.dart';
import 'package:sizzle_starter/src/core/utils/logger.dart';
import 'package:sizzle_starter/src/feature/Dashboard/data/local/hive_helper/dashboard_database_provider.dart';
import 'package:sizzle_starter/src/feature/Dashboard/data/local/hive_helper/dashboard_database_service.dart';
import 'package:sizzle_starter/src/feature/Dashboard/data/remote/dashboard_api_provider.dart';
import 'package:sizzle_starter/src/feature/Dashboard/repository/dashboard_repository.dart';
import 'package:sizzle_starter/src/feature/Dashboard/screens/bloc/dashboard_bloc.dart';
import 'package:sizzle_starter/src/feature/Dashboard/screens/bottom_navigation_screens/Dashboard/bloc/all_specialization_bloc.dart';
import 'package:sizzle_starter/src/feature/Dashboard/screens/bottom_navigation_screens/Dashboard/bloc/lawyer_bloc.dart';
import 'package:sizzle_starter/src/feature/app/logic/tracking_manager.dart';
import 'package:sizzle_starter/src/feature/initialization/model/dependencies.dart';
import 'package:sizzle_starter/src/feature/onboarding/bloc/authenticaton_bloc.dart';
import 'package:sizzle_starter/src/feature/onboarding/bloc/bloc_controller.dart';
import 'package:sizzle_starter/src/feature/onboarding/data/local/user_local_service.dart';
import 'package:sizzle_starter/src/feature/onboarding/repository/auth_repository.dart';
import 'package:sizzle_starter/src/feature/settings/bloc/settings_bloc.dart';
import 'package:sizzle_starter/src/feature/settings/data/locale_datasource.dart';
import 'package:sizzle_starter/src/feature/settings/data/locale_repository.dart';
import 'package:sizzle_starter/src/feature/settings/data/theme_datasource.dart';
import 'package:sizzle_starter/src/feature/settings/data/theme_mode_codec.dart';
import 'package:sizzle_starter/src/feature/settings/data/theme_repository.dart';

/// {@template initialization_processor}
/// A class which is responsible for processing initialization steps.
/// {@endtemplate}
final class InitializationProcessor {
  /// {@macro initialization_processor}
  const InitializationProcessor(this.config);

  /// Application configuration
  final Config config;

  Future<Dependencies> _initDependencies() async {
    final sharedPreferences = await SharedPreferences.getInstance();
    final errorTrackingManager = await _initErrorTrackingManager();
    final settingsBloc = await _initSettingsBloc(sharedPreferences);
    final userService = UserService();
    final tokenStorage =
        TokenStorageService(sharedPreferences: sharedPreferences);
    final inMemoryTokenStorage = InMemoryTokenStorage(tokenStorage);
    final restClient = _initRestClient(inMemoryTokenStorage);
    final authBlocController = await _initAuthenticationBlocController(
        sharedPreferences, tokenStorage, inMemoryTokenStorage, restClient);
    final dashboardApiProvider = DashboardApiProvider(restClient: restClient, userService: userService);
    final homeDatabaseService = HomeDataBaseService();
    final homeDatabaseProvider =
        HomeDataBaseProvider(homeDataBaseService: homeDatabaseService);
    final homeRepository =
        HomeRepository(dashboardApiProvider, homeDatabaseProvider);
    final homeBloc = HomeBloc(homeRepository);
    final specializationBloc = SpecializationBloc(apiProvider: dashboardApiProvider);
    final lawyerBloc = LawyerBloc(apiProvider: dashboardApiProvider);
    return Dependencies(
        sharedPreferences: sharedPreferences,
        settingsBloc: settingsBloc,
        errorTrackingManager: errorTrackingManager,
        authenticationBloc: authBlocController.authenticationBloc,
        homeBloc: homeBloc,
        specializationBloc:specializationBloc,
        homeDatabaseService: homeDatabaseService,
        lawyerBloc: lawyerBloc
        );
  }

  RestClientDio _initRestClient(
    InMemoryTokenStorage inMemorytokenStorage,
  ) {
    final dio = Dio();

    dio.interceptors.add(
      PrettyDioLogger(
        requestHeader: true,
        requestBody: true,
      ),
    );

    final restClient = RestClientDio(
      baseUrl: 'https://lawyer-consult-api.onrender.com',
      dio: dio,
    );

    dio.interceptors.add(AuthInterceptor(
      storage: inMemorytokenStorage,
      refreshClient:
          DioRefreshTokenClient(tokenStorage: inMemorytokenStorage, dio: dio),
      buildHeaders: (tokenPair) => {
        'Authorization': 'Bearer ${tokenPair.accessToken}',
      },
    ));

    return restClient;
  }

  Future<ErrorTrackingManager> _initErrorTrackingManager() async {
    final errorTrackingManager = SentryTrackingManager(
      logger,
      sentryDsn: config.sentryDsn,
      environment: config.environment.value,
    );

    if (config.enableSentry) {
      await errorTrackingManager.enableReporting();
    }

    return errorTrackingManager;
  }

  Future<AuthenticationBlocController> _initAuthenticationBlocController(
      SharedPreferences prefs,
      TokenStorageService tokenStorage,
      InMemoryTokenStorage inMemoryTokenStorage,
      RestClientDio restClient) async {
    final userService = UserService();
    return AuthenticationBlocController(
        restClient: restClient,
        sharedPreferences: prefs,
        tokenStorage: tokenStorage,
        userService: UserService());
  }

  Future<SettingsBloc> _initSettingsBloc(SharedPreferences prefs) async {
    final localeRepository = LocaleRepositoryImpl(
      localeDataSource: LocaleDataSourceLocal(sharedPreferences: prefs),
    );

    final themeRepository = ThemeRepositoryImpl(
      themeDataSource: ThemeDataSourceLocal(
        sharedPreferences: prefs,
        codec: const ThemeModeCodec(),
      ),
    );

    final theme = await themeRepository.getTheme();

    final initialState = SettingsState.idle(appTheme: theme);

    final settingsBloc = SettingsBloc(
      themeRepository: themeRepository,
      initialState: initialState,
    );
    return settingsBloc;
  }

  /// Initializes dependencies and returns the result of the initialization.
  ///
  /// This method may contain additional steps that need initialization
  /// before the application starts
  /// (for example, caching or enabling tracking manager)
  Future<InitializationResult> initialize() async {
    final stopwatch = Stopwatch()..start();

    logger.info('Initializing dependencies...');
    // initialize dependencies
    final dependencies = await _initDependencies();
    logger.info('Dependencies initialized');

    stopwatch.stop();
    final result = InitializationResult(
      dependencies: dependencies,
      msSpent: stopwatch.elapsedMilliseconds,
    );
    return result;
  }
}
