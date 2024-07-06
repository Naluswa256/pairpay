import 'package:sizzle_starter/src/core/components/rest_client/src/exception/network_exception.dart';
import 'package:sizzle_starter/src/core/helper/connection_helper.dart';
import 'package:sizzle_starter/src/core/helper/convertor.dart';
import 'package:sizzle_starter/src/core/utils/logger.dart';
import 'package:sizzle_starter/src/feature/Dashboard/data/local/hive_helper/dashboard_database_provider.dart';
import 'package:sizzle_starter/src/feature/Dashboard/data/remote/dashboard_api_provider.dart';
import 'package:sizzle_starter/src/feature/Dashboard/models/specialization_model.dart';
import 'package:sizzle_starter/src/feature/Dashboard/models/appointment_model.dart';
import 'package:sizzle_starter/src/feature/app/model/user_model.dart';
import 'package:sizzle_starter/src/feature/Dashboard/resources/data_state.dart';

class HomeRepository {
  // Remote Source
  final DashboardApiProvider _apiProvider;
  // Local Source
  final HomeDataBaseProvider _dbProvider;

  HomeRepository(
    this._apiProvider,
    this._dbProvider,
  );

  /// Fetch Specializations, Appointments by User, Appointments Today by User, and Popular Lawyers
  Future<DataState<Map<String, dynamic>>> fetchData() async {
    // Connection checker
    final bool isInternetConnected = await InternetConnectionHelper.checkInternetConnection();

    /// Check if any data is available in the local database
    final bool isDataAvailable = await _dbProvider.isSpecializationsDataAvailable() &&
        await _dbProvider.isAppointmentsDataAvailable() &&
        await _dbProvider.isAppointmentsTodayDataAvailable() &&
        await _dbProvider.isPopularLawyersDataAvailable();

    if (isInternetConnected) {
      try {
        // Log the start of the API calls
        logger.info('Starting API calls to fetch data');

        // Fetch data from API in parallel
        final results = await Future.wait([
          _apiProvider.getSpecializations(),
          _apiProvider.getAppointmentsByUser(),
          _apiProvider.getAppointmentsTodayByUser(),
          _apiProvider.getPopularLawyers(),
        ]);

        // Log the completion of the API calls
        logger.info('API calls completed');

        // Handle and cache results
        final specializationResponse = SpecializationResponse.fromJson(convertMap(results[0]));
        await _dbProvider.insertSpecializations(specialization: specializationResponse);
        

        final appointmentsByUserResponse = AppointmentResponse.fromJson(convertMap(results[1]));
        await _dbProvider.insertAppointmentsByUser(appointment: appointmentsByUserResponse);
       

        final appointmentsTodayByUserResponse = AppointmentResponse.fromJson(convertMap(results[2]));
        await _dbProvider.insertAppointmentsTodayByUser(appointment: appointmentsTodayByUserResponse);
       

        final popularLawyersResponse = UserResponse.fromJson(convertMap(results[3]));
        await _dbProvider.insertPopularLawyers(user: popularLawyersResponse);
      

        // Fetch cached data to return
        final cachedSpecializations = await _dbProvider.getSpecializations();
        final cachedAppointmentsByUser = await _dbProvider.getAppointmentsByUser();
        final cachedAppointmentsTodayByUser = await _dbProvider.getAppointmentsTodayByUser();
        final cachedPopularLawyers = await _dbProvider.getPopularLawyers();
         logger.info('cached appointments by user : ${cachedAppointmentsByUser?.results.first.toJson()}');
        // Return combined results from the cache
        return DataSuccess({
          'specializations': cachedSpecializations,
          'appointmentsByUser': cachedAppointmentsByUser,
          'appointmentsTodayByUser': cachedAppointmentsTodayByUser,
          'popularLawyers': cachedPopularLawyers,
        });
      } catch (e, stackTrace) {
        // Log the error with stack trace
        logger.error('Error fetching data: $e');
        logger.error('Stack trace: $stackTrace');

        if (isDataAvailable) {
          // If local data is available, return it on error
          final specializationResponse = await _dbProvider.getSpecializations();
          final appointmentsByUserResponse = await _dbProvider.getAppointmentsByUser();
          final appointmentsTodayByUserResponse = await _dbProvider.getAppointmentsTodayByUser();
          final popularLawyersResponse = await _dbProvider.getPopularLawyers();

          return DataSuccess({
            'specializations': specializationResponse,
            'appointmentsByUser': appointmentsByUserResponse,
            'appointmentsTodayByUser': appointmentsTodayByUserResponse,
            'popularLawyers': popularLawyersResponse,
          });
        } else {
          // Return error state
          return DataFailed(_getErrorMessage(e));
        }
      }
    } else {
      // If no internet connection, return local data if available
      if (isDataAvailable) {
        final specializationResponse = await _dbProvider.getSpecializations();
        final appointmentsByUserResponse = await _dbProvider.getAppointmentsByUser();
        final appointmentsTodayByUserResponse = await _dbProvider.getAppointmentsTodayByUser();
        final popularLawyersResponse = await _dbProvider.getPopularLawyers();

        return DataSuccess({
          'specializations': specializationResponse,
          'appointmentsByUser': appointmentsByUserResponse,
          'appointmentsTodayByUser': appointmentsTodayByUserResponse,
          'popularLawyers': popularLawyersResponse,
        });
      } else {
        // Return no network connection error state
        return const DataFailed('No Network Connection!');
      }
    }
  }

  String _getErrorMessage(Object e) {
    if (e is CustomBackendException) {
      return e.message;
    } else if (e is RestClientException) {
      return e.message;
    } else {
      return 'An unexpected error occurred. Please try again.';
    }
  }
}
