import 'dart:io';

import 'package:citizen_app/core/data/models/auth_model.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:path/path.dart' as path;
import 'package:uuid/uuid.dart';
import '../../../../config/env_config/env_config.dart';
import '../../../../config/services/supabase_service.dart';
import '../../../../constants/api.dart';

class AuthDataSource {
  //login user
  Future<AuthModel>? loginUser() async {
    /// TODO: update the Web client ID with your own.
    ///
    /// Web Client ID that you registered with Google Cloud.
    String webClientId = EnvConfig.googleWebClientId;

    /// TODO: update the iOS client ID with your own.
    ///
    /// iOS Client ID that you registered with Google Cloud.
    String iosClientId = EnvConfig.googleIosClientId;

    // Google sign in on Android will work without providing the Android
    // Client ID registered on Google Cloud.

    final GoogleSignIn googleSignIn = GoogleSignIn(
      clientId: iosClientId,
      serverClientId: webClientId,
    );
    final googleUser = await googleSignIn.signIn();

    if (googleUser == null) {
      throw 'No google user credential found';
    }

    final googleAuth = await googleUser!.authentication;
    final accessToken = googleAuth.accessToken;
    final idToken = googleAuth.idToken;


    //get the user details
    String? name = googleUser.displayName;
    String? avatarUrl = googleUser.photoUrl;

    if (accessToken == null) {
      throw 'No Access Token found.';
    }
    if (idToken == null) {
      throw 'No ID Token found.';
    }

    AuthResponse response = await SupabaseService.supabase.auth.signInWithIdToken(
      provider: OAuthProvider.google,
      idToken: idToken,
      accessToken: accessToken,
    );

    AuthModel model = AuthModel(
        displayName: name ?? 'Anonymous',
        authResponse: response,
        photoUrl: avatarUrl ?? "");

    return model;
  }

  //check if the user exists in the db
  Future<List<Map<String, dynamic>>> getUsername(String username) async {
    return await SupabaseService.supabase
        .from(ApiConstants.profiles)
        .select()
        .eq("username", username);
  }

  //update the user details
  Future<List<Map<String, dynamic>>> saveUserToDb(Map<String, dynamic> userData) async {
    return await SupabaseService.supabase
        .from(ApiConstants.profiles)
        .insert(userData)
        .select();
  }

  //update the user details
  Future<List<Map<String, dynamic>>> updateUser(String userId, Map<String, dynamic> data) async {
    return await SupabaseService.supabase
        .from(ApiConstants.profiles)
        .update(data).eq("id", userId)
        .select();
  }




  //update the user avatar
  Future<String> uploadAvatar(String imagePath, String userId) async {
    //on complete, update the user data and fetch the user data again
    final avatarFile = File(imagePath);
    //get the file extension
    final fileExt = path.extension(avatarFile.path);
    final fileName = '${const Uuid().v4()}$fileExt';
    final String fullPath = await SupabaseService.supabase.storage.from('avatars').upload(
          'user_images/$userId/$fileName',
          avatarFile,
          fileOptions: const FileOptions(cacheControl: '3600', upsert: false),
        );

    //fetch the public url
    String userImageResponse = await SupabaseService.supabase.storage
        .from('avatars')
        .getPublicUrl('user_images/$userId/$fileName');
    return userImageResponse;
  }

  //get user by id
  Future<List<Map<String, dynamic>>> getUserById(String id) async {
    return await SupabaseService.supabase
        .from(ApiConstants.profiles)
        .select()
        .eq('id', id);
  }
}
