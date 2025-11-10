import 'package:intl/intl.dart';

class NumberFormatter {
  NumberFormatter._();

  static String formatNumber(num number) {
    return NumberFormat('#,###').format(number);
  }

  static String formatDecimal(num number, {int decimalPlaces = 2}) {
    return NumberFormat('#,##0.${'0' * decimalPlaces}').format(number);
  }

  static String formatCurrency(num amount, {String symbol = '\$'}) {
    return '$symbol${formatNumber(amount)}';
  }
}
