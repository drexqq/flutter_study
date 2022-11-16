import 'package:intl/intl.dart';

class DataUtils {
  static final intl = NumberFormat("#,###", "ko_KR");
  static String calcWon(String price) =>
      num.tryParse(price) != null ? "${intl.format(int.parse(price))}원" : price;
}
