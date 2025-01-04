

import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

class CacheHelper {
  CacheHelper._internal();

  static final instance = CacheHelper._internal();

  static const _firstTimerKey = 'first-timer-key';
  static const firebaseTokenKey = 'firebase-token-key';

  late SharedPreferences _prefs;

  bool _isFirstTimer = true;

  /// Returns [true] if the user is a first timer, otherwise [false].
  bool get isFirstTimer => _isFirstTimer;

  void init(SharedPreferences prefs, {bool opening = true}) {
    _prefs = prefs;
    if(opening) _isFirstTimer = _checkIfUserIsFirstTimer();
  }

  /// Cache the first timer.
  ///
  /// This should be called only once after the user taps the Get Started
  /// Button on the Onboarding page. It stores [false], meaning the user is
  /// no longer a first timer.
  Future<void> cacheFirstTimer() async {
    await _prefs.setBool(_firstTimerKey, false);
  }


  //set string values
  Future<void> cacheString(String key, String value) async {
    await _prefs.setString(key, value);
  }

  String? readString(String key) {
    return _prefs.getString(key);
  }


  Future<void> cacheModel(String key, value) async {
    var encodedValue = json.encode(value);
    cacheString(key, encodedValue);
  }

  Future readModel(String key) async {
    var encodedValue = readString(key);
    return encodedValue == null ? null : json.decode(encodedValue);
  }

  /// Check if the user is a first timer.
  bool _checkIfUserIsFirstTimer() {
    final result = _prefs.getBool(_firstTimerKey);

    return result ?? false;
  }
}