

class NumberFormatter {
  static String formatCount(int number) {
    if (number < 1000) {
      return number.toString();
    } else if (number < 1000000) {
      double result = number / 1000;
      // Handle numbers like 1.0K to just show 1K
      if (result == result.roundToDouble()) {
        return '${result.toInt()}K';
      }
      // Show one decimal place for numbers like 1.2K
      return '${result.toStringAsFixed(1)}K';
    } else {
      double result = number / 1000000;
      if (result == result.roundToDouble()) {
        return '${result.toInt()}M';
      }
      return '${result.toStringAsFixed(1)}M';
    }
  }
}

// Extension method for easier use
extension NumberFormatting on int {
  String get formatted => NumberFormatter.formatCount(this);
}