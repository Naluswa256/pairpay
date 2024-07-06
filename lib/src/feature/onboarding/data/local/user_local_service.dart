// ignore_for_file: public_member_api_docs

import 'package:hive/hive.dart';
import 'package:sizzle_starter/src/feature/app/model/user_model.dart';

class UserService {
  static const String _userBoxName = 'userBox';
  static const String _userKey = 'user';

  Future<void> saveUser(User user) async {
    final box = await Hive.openBox<User>(_userBoxName);
    await box.put(_userKey, user);
  }

   Future<User?> getUser() async {
    final box = await Hive.openBox<User>(_userBoxName);
    final user = box.get(_userKey);
    return user;
  }
}
