import 'package:flutter_test/flutter_test.dart';
import 'package:to_do_list/app/data/enum/task_status.dart';

void main() {
  group('TaskStatus enum', () {
    test('TaskStatus.name returns correct Korean names', () {
      expect(TaskStatus.pending.name, '대기');
      expect(TaskStatus.ongoing.name, '진행중');
      expect(TaskStatus.completed.name, '완료');
    });
  });
}