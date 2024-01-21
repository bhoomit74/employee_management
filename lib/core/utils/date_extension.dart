import 'package:employee_management/core/utils/date_util.dart';
import 'package:intl/intl.dart';

extension DateExtension on int? {
  String get formatted {
    if (this == null) {
      return "";
    }
    DateTime date = DateTime.fromMillisecondsSinceEpoch(this!);
    bool isToday = DateUtil.isSameDay(date, DateTime.now());
    return isToday ? "Today" : DateFormat("dd MMM yyyy").format(date);
  }

  DateTime toDateTime() {
    return DateTime.fromMillisecondsSinceEpoch(this ?? 0);
  }
}
