class DateUtil {
  /// Returns the next occurrence of the specified [dayOfWeek] from the current date.
  /// [dayOfWeek] is represented as an integer (1 for Monday, 2 for Tuesday, ..., 7 for Sunday).
  static DateTime getNextDate(int dayOfWeek) {
    const int daysInAWeek = 7;
    final DateTime currentDate = DateTime.now();

    // Calculate the number of days until the next occurrence of the specified day.
    int daysUntilNextDay =
        (dayOfWeek - currentDate.weekday + daysInAWeek) % daysInAWeek;

    // Add the calculated days to the current date to get the next occurrence.
    DateTime nextDate = currentDate.add(Duration(days: daysUntilNextDay));

    return nextDate;
  }

  /// Returns the date after one week from the current date.
  static DateTime getDateAfterWeek() {
    final DateTime currentDate = DateTime.now();

    // Add a week (7 days) to the current date to get the date after one week.
    DateTime dateAfterWeek = currentDate.add(const Duration(days: 7));

    return dateAfterWeek;
  }

  static bool isSameDay(DateTime date1, DateTime? date2) {
    if (date2 == null) {
      return false;
    }
    return date1.year == date2.year &&
        date1.month == date2.month &&
        date1.day == date2.day;
  }
}
