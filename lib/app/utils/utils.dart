export 'package:jawa_app/app/utils/connection.dart';
export 'package:jawa_app/app/utils/regex.dart';
export 'package:jawa_app/app/utils/validators.dart';

class Utils {
  static bool compareDates(DateTime d1, DateTime d2) {
    if (d1.year == d2.year && d1.month == d2.month && d1.day == d2.day) {
      return true;
    } else {
      return false;
    }
  }
}
