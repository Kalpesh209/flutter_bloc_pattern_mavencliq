class DateTimeHelper {
  static DateTime getDateTimeNow() => DateTime.now();

  static DateTime getDateTimeNowIso8601() => DateTime.now().toUtc();
}