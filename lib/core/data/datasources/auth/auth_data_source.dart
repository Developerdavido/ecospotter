

import 'package:citizen_app/core/config/services/supabase_service.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../../config/env_config/env_config.dart';

class AuthDataSource {

  //login daa
  Future<AuthResponse> loginUser() async {
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
    final googleAuth = await googleUser!.authentication;
    final accessToken = googleAuth.accessToken;
    final idToken = googleAuth.idToken;

    //get the user details
    String? name = googleUser.displayName;

    if (accessToken == null) {
      throw 'No Access Token found.';
    }
    if (idToken == null) {
      throw 'No ID Token found.';
    }

    return SupabaseService.supabase.auth.signInWithIdToken(
      provider: OAuthProvider.google,
      idToken: idToken,
      accessToken: accessToken,
    );

  }
}