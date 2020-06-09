//helper class to deal with any kind of logic "inconveniences"

class HelperService {
  //function to format double into string with fixed decimal numbers (defaulted 2)
  static String formatDouble(double n, {int decimalToKeep = 2}) {
    return n.toStringAsFixed(n.truncateToDouble() == n ? 0 : decimalToKeep);
  }
}
