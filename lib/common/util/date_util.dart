class DateUtil {
  DateUtil._();

  // DateTime to milliseconds
  static int dateTimeToMilliSeconds(DateTime dateTime) {
    return dateTime.millisecondsSinceEpoch;
  }

  // milliseconds to DateTime
  static DateTime milliSecondsToDateTime(int milliSeconds) {
    return DateTime.fromMillisecondsSinceEpoch(milliSeconds);
  }

}