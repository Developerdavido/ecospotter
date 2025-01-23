

import 'package:citizen_app/core/data/models/auth_model.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../data/models/user_model.dart';

abstract class AuthRepository {

  //get the userId of the application
  Future<AuthModel?>? loginUser();

  //update the user data
  Future<List<Map<String, dynamic>>> saveUserToDb(Map<String, dynamic> userData);

  //update user  avatar
  Future<String> updateUserAvatar(String imagePath, String id);

  //get user  by id
  Future<List<Map<String, dynamic>>> getUserById(String id);

  //check if user exists
  Future<List<Map<dynamic,dynamic>>> checkIfUsernameExists(String username);

}