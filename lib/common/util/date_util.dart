class DateUtil {
  DateUtil._();

  // DateTime to milliseconds
  static int dateTimeToMilliSeconds(DateTime dateTime) {
    return dateTime.millisecondsSinceEpoch;
  }

  // milliseconds to DateTime
  static DateTime? milliSecondsToDateTime(int? milliSeconds) {
    if (milliSeconds == null) {
      return null;
    }
    return DateTime.fromMillisecondsSinceEpoch(milliSeconds);
  }

  static String getFormattedDate(DateTime? dateTime) {
    if (dateTime == null) {
      return '없음';
    }
    return '${dateTime.year}년 ${dateTime.month}월 ${dateTime.day}일';
  }
}