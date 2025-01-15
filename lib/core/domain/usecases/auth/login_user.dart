

import 'package:citizen_app/core/data/models/auth_model.dart';
import 'package:citizen_app/core/domain/repositories/auth_repository.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class LoginUser {
  final AuthRepository authRepository;

  LoginUser(this.authRepository);

  Future<AuthModel> call() async {
    return await authRepository.loginUser();
  }
}