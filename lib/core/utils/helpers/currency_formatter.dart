import 'package:intl/intl.dart';

class CurrencyFormatter {
  CurrencyFormatter._();

  static final _usd = NumberFormat.currency(symbol: '\$', decimalDigits: 2);
  static final _compact = NumberFormat.compactCurrency(symbol: '\$');
  static final _number = NumberFormat('#,##0.##');

  static String format(double amount, {String symbol = '\$'}) {
    final formatter = NumberFormat.currency(symbol: symbol, decimalDigits: 2);
    return formatter.format(amount);
  }

  static String formatCompact(double amount) => _compact.format(amount);

  static String formatNumber(double value) => _number.format(value);

  static String formatPercent(double value, {int decimals = 1}) =>
      '${value.toStringAsFixed(decimals)}%';
}
