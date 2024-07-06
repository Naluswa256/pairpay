// ignore_for_file: lines_longer_than_80_chars, unused_field

import 'dart:async';
import 'package:hive/hive.dart';
import 'package:sizzle_starter/src/core/constant/db_keys.dart';
import 'package:sizzle_starter/src/core/utils/logger.dart';
import 'package:sizzle_starter/src/feature/Dashboard/models/specialization_model.dart';
import 'package:sizzle_starter/src/feature/Dashboard/models/appointment_model.dart';
import 'package:sizzle_starter/src/feature/app/model/user_model.dart';

class HomeDataBaseService {
  /// Box Keys
  static const String _specializationsKey = DbKeys.dbSpecializations;
  static const String _appointmentsByUserKey = DbKeys.dbAppointmentsByUser;
  static const String _popularLawyersKey = DbKeys.dbPopularLawyers;
  static const String _appointmentsTodayByUser =
      DbKeys.dbAppointmentsTodayByUser;

  /// Boxes
  late final Box<SpecializationResponse> _specializationsBox;
  late final Box<AppointmentResponse> _appointmentsByUserBox;
  late final Box<UserResponse> _popularLawyersBox;
  late final Box<AppointmentResponse> _appointmentsTodayByUserBox;

  final Completer<void> _initCompleter = Completer<void>();

  HomeDataBaseService();

  /// Initialize Database
  Future<void> initDataBase() async {
    try {
      Hive.registerAdapter(SpecializationResponseAdapter());
      Hive.registerAdapter(AppointmentResponseAdapter());
      Hive.registerAdapter(UserResponseAdapter());
      Hive.registerAdapter(AppointmentAdapter());
      Hive.registerAdapter(ReviewUserAdapter());
      Hive.registerAdapter(AvailableSlotAdapter());
      Hive.registerAdapter(EmploymentHistoryAdapter());
      Hive.registerAdapter(EducationAdapter());
      Hive.registerAdapter(SocialMediaLinkedAccountAdapter());
      Hive.registerAdapter(ReviewAdapter());
      Hive.registerAdapter(PackageAdapter());
      Hive.registerAdapter(AttendeeAdapter());
      Hive.registerAdapter(SpecializationAdapter());
      Hive.registerAdapter(SpecializationPopulatedAdapter());
      _specializationsBox =
          await Hive.openBox<SpecializationResponse>(_specializationsKey);
      _appointmentsByUserBox =
          await Hive.openBox<AppointmentResponse>(_appointmentsByUserKey);
      _popularLawyersBox = await Hive.openBox<UserResponse>(_popularLawyersKey);
      _appointmentsTodayByUserBox =
          await Hive.openBox<AppointmentResponse>(_appointmentsTodayByUser);
      logger.info('Success on initializing database');
      _initCompleter.complete();
    } catch (e) {
      // Handle initialization errors
      logger.error('Error initializing database: $e');
      _initCompleter.completeError(e);
    }
  }

  Future<void> _ensureInitialized() async {
    if (!_initCompleter.isCompleted) {
      await _initCompleter.future;
    }
  }

  /// Get all items from the specified box
  Future<T?> getAll<T>(String key) async {
    await _ensureInitialized();
    try {
      switch (key) {
        case _specializationsKey:
          if (_specializationsBox.isOpen && _specializationsBox.isNotEmpty) {
            return _specializationsBox.get(key) as T?;
          } else {
            return null;
          }

        case _appointmentsByUserKey:
          if (_appointmentsByUserBox.isOpen &&
              _appointmentsByUserBox.isNotEmpty) {
            return _appointmentsByUserBox.get(key) as T?;
          } else {
            return null;
          }

        case _popularLawyersKey:
          if (_popularLawyersBox.isOpen && _popularLawyersBox.isNotEmpty) {
            return _popularLawyersBox.get(key) as T?;
          } else {
            return null;
          }
        case _appointmentsTodayByUser:
          if (_appointmentsTodayByUserBox.isOpen &&
              _appointmentsTodayByUserBox.isNotEmpty) {
            return _appointmentsTodayByUserBox.get(key) as T?;
          } else {
            return null;
          }

        default:
          throw Exception('Unknown key: $key');
      }
    } catch (e) {
      // Handle read errors
      logger.error('Error reading from database: $e');
      return null;
    }
  }

  /// Insert an item into the specified box
  Future<void> insertItem<T>({required String key, required T object}) async {
    await _ensureInitialized();
    try {
      switch (key) {
        case _specializationsKey:
          await _specializationsBox.put(
              _specializationsKey, object as SpecializationResponse,);
          break;
        case _appointmentsByUserKey:
          await _appointmentsByUserBox.put(
              _appointmentsByUserKey, object as AppointmentResponse,);
          break;
        case _popularLawyersKey:
          await _popularLawyersBox.put(
              _popularLawyersKey, object as UserResponse,);
          break;
        case _appointmentsTodayByUser:
          await _appointmentsTodayByUserBox.put(
              _appointmentsTodayByUser, object as AppointmentResponse,);
          break;
        default:
          throw Exception('Unknown key: $key');
      }
    } catch (e) {
      // Handle insertion errors
      logger.error('Error inserting into database: $e');
    }
  }

  /// Check if data is available in the specified box
  Future<bool> isDataAvailable(String key) async {
    await _ensureInitialized();
    try {
      switch (key) {
        case _specializationsKey:
          return _specializationsBox.isNotEmpty;
        case _appointmentsByUserKey:
          return _appointmentsByUserBox.isNotEmpty;
        case _appointmentsTodayByUser:
          return _appointmentsTodayByUserBox.isNotEmpty;
        case _popularLawyersKey:
          return _popularLawyersBox.isNotEmpty;
        default:
          throw Exception('Unknown key: $key');
      }
    } catch (e) {
      // Handle error checking box emptiness
      logger.error('Error checking if box is empty: $e');
      return false; // Return false on error to assume data is not available
    }
  }
}
