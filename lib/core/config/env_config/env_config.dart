

import 'package:flutter_dotenv/flutter_dotenv.dart';

class EnvConfig {

  static final EnvConfig _instance = EnvConfig._internal();

  factory EnvConfig() => _instance;

  EnvConfig._internal();

  static Future<void> initialize() async {
    await dotenv.load(fileName: ".env");
  }

  static String get supabaseUrl => dotenv.env['SUPABASE_URL'] ?? "";
  static String get supabaseAnonKey => dotenv.env['SUPABASE_ANON_KEY'] ?? "";
  static String get googleWebClientId => dotenv.env['GOOGLE_WEB_CLIENT_ID'] ?? "";
  static String get googleIosClientId => dotenv.env['GOOGLE_IOS_CLIENT_ID'] ?? "";
}