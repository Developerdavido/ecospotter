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
}

