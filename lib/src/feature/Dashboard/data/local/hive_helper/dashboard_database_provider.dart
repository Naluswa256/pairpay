

// ignore_for_file: lines_longer_than_80_chars

import 'package:sizzle_starter/src/core/constant/db_keys.dart';
import 'package:sizzle_starter/src/core/utils/logger.dart';
import 'package:sizzle_starter/src/feature/Dashboard/data/local/hive_helper/dashboard_database_service.dart';
import 'package:sizzle_starter/src/feature/Dashboard/models/appointment_model.dart';
import 'package:sizzle_starter/src/feature/Dashboard/models/specialization_model.dart';
import 'package:sizzle_starter/src/feature/app/model/user_model.dart';

class HomeDataBaseProvider {
  // Local Source For Home
  final HomeDataBaseService _homeDataBaseService;

  HomeDataBaseProvider({
    required HomeDataBaseService homeDataBaseService,
  }) : _homeDataBaseService = homeDataBaseService;

   /// Read Specializations From DB
  Future<SpecializationResponse?> getSpecializations() async {
    try {
      return await _homeDataBaseService.getAll<SpecializationResponse>(DbKeys.dbSpecializations);
    } catch (e) {
      logger.error('Error retrieving specializations: $e');
      return null;
    }
  }
  
    Future<AppointmentResponse?> getAppointmentsByUser() async {
    try {
      return await _homeDataBaseService.getAll<AppointmentResponse>(DbKeys.dbAppointmentsByUser);
    } catch (e) {
      // Log or handle the error appropriately
      logger.error('Error retrieving appointments: $e');
      return null;
    }
  }
    Future<AppointmentResponse?> getAppointmentsTodayByUser() async {
    try {
      return await _homeDataBaseService.getAll<AppointmentResponse>(DbKeys.dbAppointmentsTodayByUser);
    } catch (e) {
      // Log or handle the error appropriately
      logger.error('Error retrieving appointments: $e');
      return null;
    }
  }
  Future<UserResponse?> getPopularLawyers() async {
    try {
      return await _homeDataBaseService.getAll<UserResponse>(DbKeys.dbPopularLawyers);
    } catch (e) {
      logger.error('Error retrieving users: $e');
      return null;
    }
  }

   /// Insert Specializations To DB
  Future<void> insertSpecializations({required SpecializationResponse specialization}) async {
    try {
      await _homeDataBaseService.insertItem<SpecializationResponse>(
        key: DbKeys.dbSpecializations,
        object: specialization,
      );
    } catch (e) {
      logger.error('Error inserting specializations: $e');
    }
  }

  /// Insert Appointments To DB
  Future<void> insertAppointmentsByUser({required AppointmentResponse appointment}) async {
    try {
      await _homeDataBaseService.insertItem<AppointmentResponse>(
        key: DbKeys.dbAppointmentsByUser,
        object: appointment,
      );
    } catch (e) {
      logger.error('Error inserting appointments: $e');
    }
  }
    Future<void> insertAppointmentsTodayByUser({required AppointmentResponse appointment}) async {
    try {
      await _homeDataBaseService.insertItem<AppointmentResponse>(
        key: DbKeys.dbAppointmentsTodayByUser,
        object: appointment,
      );
    } catch (e) {
      logger.error('Error inserting appointments: $e');
    }
  }

  /// Insert Users To DB
  Future<void> insertPopularLawyers({required UserResponse user}) async {
    try {
      await _homeDataBaseService.insertItem<UserResponse>(
        key: DbKeys.dbPopularLawyers,
        object: user,
      );
    } catch (e) {
      logger.error('Error inserting users: $e');
    }
  }

  /// Check if Specializations Data Available
  Future<bool> isSpecializationsDataAvailable() async =>
      _homeDataBaseService.isDataAvailable(DbKeys.dbSpecializations);

  /// Check if Appointments Data Available
  Future<bool> isAppointmentsDataAvailable() async =>
      _homeDataBaseService.isDataAvailable(DbKeys.dbAppointmentsByUser);
 Future<bool> isAppointmentsTodayDataAvailable() async =>
      _homeDataBaseService.isDataAvailable(DbKeys.dbAppointmentsTodayByUser);
  /// Check if Users Data Available
  Future<bool> isPopularLawyersDataAvailable() async =>
      _homeDataBaseService.isDataAvailable(DbKeys.dbPopularLawyers);
}