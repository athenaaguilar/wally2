import 'package:intl/intl.dart';

extension NumberExtension on int {
  String formatAmount() => NumberFormat('#,##0.00', 'en_US').format(this);
}
