import 'dart:convert';

import 'package:intl/intl.dart';

abstract class Utils {
  static dayOfEvent(date) {
    String formattedDate = DateFormat('dd').format(date);
    return formattedDate;
  }

  static monthOfEvent(date){
    String formattedDate = DateFormat('MMM').format(date);
    return formattedDate;
  }

  static fullDate(date){
    String formattedDate = DateFormat('dd/MMM/yyyy').format(date);
    return formattedDate;
  }

  static time(date){
    String formattedDate = DateFormat('h:mm a').format(date);
    return formattedDate;
  }

  //auth utils
  //professions
  static final List<String> professions = [
    'Student',
    'Researcher',
    'Nature Enthusiast',
    'Other'
  ];

  //gender
  static final List<String> gender = ['Male', 'Female'];

  static final List<String> animals = [
    'Large Mammals',
    'Small Mammals',
    'Fishes',
    'Birds',
    'Herpetofauna'
  ];

  Map<int, dynamic> alphabetMap = {
    0 : "a)",
    1 : "b)",
    2 : "c)",
    3 : "d)",
    4 : "e)",
    5 : "f)",
    6 : "g)",
  };

  //this is for the animal activity
  static Map<String, dynamic>? extractMessageMapFromJson(String jsonString) {
    try {
      final outerJson = jsonDecode(jsonString) as Map<String, dynamic>;
      final candidates = outerJson['candidates'] as List<dynamic>;
      if (candidates.isEmpty) return null;

      final content = candidates[0]['content'] as Map<String, dynamic>;
      final parts = content['parts'] as List<dynamic>;
      if (parts.isEmpty) return null;

      final text = parts[0]['text'] as String;
      final startIndex = text.indexOf('{');
      final endIndex = text.lastIndexOf('}');
      if (startIndex == -1 || endIndex == -1) return null;

      final innerJsonString = text.substring(startIndex, endIndex + 1);
      return jsonDecode(innerJsonString) as Map<String, dynamic>;
    } catch (e) {
      print('Error parsing JSON: $e');
      return null;
    }
  }


}

