///
/// task category enum
/// * [none] 없음
/// * [personal] 개인
/// * [work] 업무
/// * [wishlist] 위시리스트
/// * [etc] 기타
enum TaskCategory {
  none,
  personal,
  work,
  wishlist,
  etc;

  String get name {
    switch (this) {
      case TaskCategory.none:
        return '없음';
      case TaskCategory.personal:
        return '개인';
      case TaskCategory.work:
        return '업무';
      case TaskCategory.wishlist:
        return '위시리스트';
      case TaskCategory.etc:
        return '기타';
    }
  }

  static TaskCategory fromString(String value) {
    switch (value) {
      case 'personal':
        return TaskCategory.personal;
      case 'work':
        return TaskCategory.work;
      case 'wishlist':
        return TaskCategory.wishlist;
      case 'etc':
        return TaskCategory.etc;
      default:
        return TaskCategory.none;
    }
  }
}