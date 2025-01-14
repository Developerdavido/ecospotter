

import 'package:citizen_app/core/domain/repositories/auth_repository.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class LoginUser {
  final AuthRepository authRepository;

  LoginUser(this.authRepository);

  Future<AuthResponse> call() async {
    return await authRepository.loginUser();
  }
}