import 'package:intl/intl.dart';

class DateUtil {
  static String formatDateToString(int millisecondsSinceEpoch) {
    DateTime date = DateTime.fromMillisecondsSinceEpoch(millisecondsSinceEpoch);
    Duration duration = date.difference(DateTime.now());
    if (duration.inDays == 0) {
      return "Today";
    } else {
      return DateFormat("dd MMM yyyy").format(date);
    }
  }

  /*static DateTime getNextDate(int day) {
    DateTime currentDate = DateTime.now();
    if (currentDate.weekday == day) {
      return currentDate;
    } else if (currentDate.weekday < day) {
      return currentDate.add(Duration(days: day - currentDate.weekday));
    } else {
      return currentDate.add(Duration(days: 7 - currentDate.weekday + day));
    }
  }*/

  static DateTime getNextDate(int dayOfWeek) {
    int daysUntilNextDay = (dayOfWeek - DateTime.now().weekday + 7) % 7;
    return DateTime.now().add(Duration(days: daysUntilNextDay));
  }

  static DateTime getDateAfterWeek() {
    DateTime currentDate = DateTime.now();
    return currentDate.add(const Duration(days: 7));
  }

  static bool isSameDay(DateTime date1, DateTime date2) {
    return date1.year == date2.year &&
        date1.month == date2.month &&
        date1.day == date2.day;
  }
}
