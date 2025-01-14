import 'package:citizen_app/core/config/services/supabase_service.dart';
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

        case AuthChangeEvent.passwordRecovery:
          // TODO: Handle this case.
        case AuthChangeEvent.signedIn:
          // TODO: Get the user data and update the user data.
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
