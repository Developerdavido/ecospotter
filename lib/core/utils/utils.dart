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


}

