import 'package:flutter_test/flutter_test.dart';
import 'package:to_do_list/app/data/enum/task_category.dart';

void main() {
  group('TaskCategory enum', () {
    test('TaskCategory.name returns correct Korean names', () {
      expect(TaskCategory.none.name, '카테고리 없음');
      expect(TaskCategory.personal.name, '개인');
      expect(TaskCategory.work.name, '업무');
      expect(TaskCategory.wishlist.name, '위시리스트');
      expect(TaskCategory.etc.name, '기타');
    });

    test('TaskCategory.fromString returns correct enum values', () {
      expect(TaskCategory.fromString('personal'), TaskCategory.personal);
      expect(TaskCategory.fromString('work'), TaskCategory.work);
      expect(TaskCategory.fromString('wishlist'), TaskCategory.wishlist);
      expect(TaskCategory.fromString('etc'), TaskCategory.etc);
      expect(TaskCategory.fromString('unknown'), TaskCategory.none);
      expect(TaskCategory.fromString(''), TaskCategory.none);
    });

    test('TaskCategory.fromString handles null and empty string', () {
      expect(TaskCategory.fromString(''), TaskCategory.none);
    });
  });
}