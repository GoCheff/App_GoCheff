import 'package:intl/intl.dart';

String toReal(double value) {
  return NumberFormat.currency(locale: 'pt_BR', symbol: 'R\$').format(value);
}
