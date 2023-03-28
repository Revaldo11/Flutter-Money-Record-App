import 'package:intl/intl.dart';

class AppFormat {
  static String date(String date) {
    DateTime dateTime = DateTime.parse(date);
    return DateFormat('dd MMM yyyy', 'id_ID').format(dateTime); // 01 Jan 2021
  }

  static String currency(String number) {
    return NumberFormat.currency(
      locale: 'id_ID',
      symbol: 'Rp. ',
      decimalDigits: 0,
    ).format(double.parse(number)); // Rp. 1.000.000
  }
}
