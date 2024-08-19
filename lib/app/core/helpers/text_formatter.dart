import 'package:intl/intl.dart';

final _formaterRealPattern =
    NumberFormat.currency(locale: 'pt_BR', symbol: r'R$');

class TextFormatter {
  TextFormatter._();
  static String formatReal(double value) => _formaterRealPattern.format(value);
}
