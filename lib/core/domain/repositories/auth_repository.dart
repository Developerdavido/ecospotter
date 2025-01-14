

import 'package:supabase_flutter/supabase_flutter.dart';

import '../../data/models/user_model.dart';

abstract class AuthRepository {

  //get the userId of the application
  Future<AuthResponse> loginUser();

  //update the user data
  Future<UserModel> updateUser(Map<String, dynamic> userData);

  //update user  avatar
  Future<String> updateUserAvatar(String id);

}