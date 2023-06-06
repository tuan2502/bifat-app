
import 'package:intl/intl.dart';


class FormatValue {
  static final _currencyFormat = new NumberFormat("#,##0", "vi_VN");

  static String formatMoney(value) {
    return "${_currencyFormat.format(value)} VNĐ";
  }
}