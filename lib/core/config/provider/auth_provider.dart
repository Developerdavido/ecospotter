

import 'dart:developer';

import 'package:citizen_app/core/domain/usecases/auth/login_user.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../data/datasources/auth/auth_data_source.dart';
import '../locator.dart';

class AuthProvider {
  var auth = locator<AuthDataSource>();

  loginUser() async {
    AuthResponse response = await auth.loginUser();
    if(response.user != null) {
      log(response.user!.email!);
    }
  }
}