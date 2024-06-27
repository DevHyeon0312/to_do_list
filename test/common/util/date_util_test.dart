import 'package:flutter_test/flutter_test.dart';
import 'package:to_do_list/common/util/date_util.dart';

void main() {
  group('DateUtil', () {
    test('dateTimeToMilliSeconds converts DateTime to milliseconds', () {
      final dateTime = DateTime(2023, 6, 25);
      final milliseconds = DateUtil.dateTimeToMilliSeconds(dateTime);

      expect(milliseconds, dateTime.millisecondsSinceEpoch);
    });

    test('milliSecondsToDateTime converts milliseconds to DateTime', () {
      final milliseconds = DateTime(2023, 6, 25).millisecondsSinceEpoch;
      final dateTime = DateUtil.milliSecondsToDateTime(milliseconds);

      expect(dateTime, DateTime(2023, 6, 25));
    });

    test('milliSecondsToDateTime returns null if milliseconds is null', () {
      final dateTime = DateUtil.milliSecondsToDateTime(null);

      expect(dateTime, null);
    });

    test('getFormattedDate returns formatted date string', () {
      final dateTime = DateTime(2023, 6, 25);
      final formattedDate = DateUtil.getFormattedDate(dateTime);

      expect(formattedDate, '2023년 6월 25일');
    });

    test('getFormattedDate returns "없음" if dateTime is null', () {
      final formattedDate = DateUtil.getFormattedDate(null);

      expect(formattedDate, '없음');
    });
  });
}
