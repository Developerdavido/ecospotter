

import 'package:supabase_flutter/supabase_flutter.dart';

import '../env_config/env_config.dart';

class SupabaseService {

  static final SupabaseService _instance = SupabaseService._internal();

  factory SupabaseService ()=> _instance;

  SupabaseService._internal();


  static final supabase = Supabase.instance.client;

  static Future<void> initialize() async {
    //initialize the supabase client
    await Supabase.initialize(
      url: EnvConfig.supabaseUrl,
      anonKey: EnvConfig.supabaseAnonKey,
    );

  }

}