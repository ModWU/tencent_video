import 'package:intl/intl.dart';

class TimeUtils {
  TimeUtils._();

  static String getStandardNowTime() {
    final DateTime time = DateTime.now();
    final DateFormat formatter = DateFormat('yyyy-MM-dd HH:mm:ss');
    return formatter.format(time);
  }
}
