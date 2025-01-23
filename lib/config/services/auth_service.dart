import 'dart:developer';

import 'package:citizen_app/config/services/supabase_service.dart';
import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class AuthService {

  //check for state changes
  checkForUserStateChanges() {
    SupabaseService.supabase.auth.onAuthStateChange.listen((data) {
      final AuthChangeEvent event = data.event;
      //this will handle the events when there are changes in the
      switch (event) {
        case AuthChangeEvent.initialSession:
          log("this is the initial session of the user");
        case AuthChangeEvent.passwordRecovery:
          // TODO: Handle this case.
        case AuthChangeEvent.signedIn:
          // TODO: Get the user data and update the user data.
          log("user already logged in");
        case AuthChangeEvent.signedOut:
          // TODO: Leave the user on the login screen.
        case AuthChangeEvent.tokenRefreshed:
          // TODO: Handle this case.
        case AuthChangeEvent.userUpdated:
          // TODO: Get the user data again.
        case AuthChangeEvent.userDeleted:
          // TODO: Handle this case.
        case AuthChangeEvent.mfaChallengeVerified:
          // TODO: Handle this case.
      }
    });
  }

}
