
import 'package:intl/intl.dart';

class DateTimeUtils {

  static final String _DATE_FORMAT = 'yy-MM-dd';

  static int getTimestampNow(){
    return DateTime.now().millisecondsSinceEpoch;
  }

  static String getDateToday(){
    DateTime now = DateTime.now();
    DateFormat formatter = DateFormat(_DATE_FORMAT);
    return formatter.format(now);
  }
}