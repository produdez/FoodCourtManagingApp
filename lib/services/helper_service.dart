class HelperService {
  static String formatDouble(double n,{int decimalToKeep = 2}) {
    return n.toStringAsFixed(n.truncateToDouble() == n ? 0 : decimalToKeep);
  }
}