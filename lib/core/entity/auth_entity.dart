

import 'package:supabase_flutter/supabase_flutter.dart';

class AuthEntity {

  final String displayName;
  final String photoUrl;
  final AuthResponse authResponse;

  const AuthEntity({
    required this.photoUrl,
    required this.displayName,
    required this.authResponse,
  });
}