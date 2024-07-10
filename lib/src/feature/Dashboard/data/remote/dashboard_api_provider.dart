// ignore_for_file: lines_longer_than_80_chars

import 'package:sizzle_starter/src/core/components/rest_client/src/rest_client_dio.dart';
import 'package:sizzle_starter/src/core/utils/logger.dart';
import 'package:sizzle_starter/src/feature/app/model/user_model.dart';
import 'package:sizzle_starter/src/feature/onboarding/data/local/user_local_service.dart';

class DashboardApiProvider {
  final RestClientDio restClient;
  final UserService userService;

  DashboardApiProvider({required this.restClient, required this.userService});

  Future<Map<String, Object?>?> getSpecializations({int limit = 10, int page = 1}) async {
    try {
      final queryParams = {
        'limit': limit.toString(),
        'page': page.toString(),
      };

      return await restClient.get('v1/lawyer-specializations', queryParams: queryParams);
    } catch (e) {
      logger.error('Error fetching specializations: $e');
      rethrow;
    }
  }

  Future<Map<String, Object?>?> fetchLawyersBySpecialization({required String specializationId, int limit = 10, int page = 1}) async {
    try {
      final queryParams = {
        'limit': limit.toString(),
        'page': page.toString(),
      };

      return await restClient.get('v1/lawyers/specializations/$specializationId', queryParams: queryParams);
    } catch (e) {
      logger.error('Error fetching specializations: $e');
      rethrow;
    }
  }
  
   
  Future<Map<String, Object?>?> getAppointmentsByUser() async {
    try {
      final User? user = await userService.getUser(); 
      final userId = user!.id;
      return await restClient.get('v1/appointments/user/$userId');
    } catch (e) {
      logger.error('Error fetching appointments by user: $e');
      rethrow;
    }
  }

  Future<Map<String, Object?>?> getAppointmentsTodayByUser() async {
    try {
      final User? user = await userService.getUser(); 
      final userId = user!.id;
      return await restClient.get('v1/appointments/happening-today/user/$userId');
    } catch (e) {
      logger.error('Error fetching appointments today by user: $e');
      rethrow;
    }
  }

  Future<Map<String, Object?>?> getPopularLawyers() async {
    try {
      return await restClient.get('v1/lawyers/popular');
    } catch (e) {
      logger.error('Error fetching popular lawyers: $e');
      rethrow;
    }
  }

  Future<Map<String, Object?>?> searchSpecializations(String name, {int limit = 10, int page = 1}) async {
    try {
      final queryParams = {
        'name': name,
        'limit': limit.toString(),
        'page': page.toString(),
      };
      return await restClient.get('v1/lawyer-specializations/search', queryParams: queryParams);
    } catch (e) {
      logger.error('Error searching specializations: $e');
      rethrow;
    }
  }
  Future<Map<String, Object?>?> searchLawyersByName(String name, {int limit = 10, int page = 1}) async {
    try {
      final queryParams = {
        'name': name,
        'limit': limit.toString(),
        'page': page.toString(),
      };
      return await restClient.get('v1/lawyer/search', queryParams: queryParams);
    } catch (e) {
      logger.error('Error searching specializations: $e');
      rethrow;
    }
  }
  Future<Map<String, Object?>?> searchLawyersInSpecializationByName(String name,String specializationId, {int limit = 10, int page = 1}) async {
    try {
      final queryParams = {
        'name': name,
        'limit': limit.toString(),
        'page': page.toString(),
      };
      return await restClient.get('v1/lawyers/specializations/$specializationId/search', queryParams: queryParams);
    } catch (e) {
      logger.error('Error searching specializations: $e');
      rethrow;
    }
  }
}
