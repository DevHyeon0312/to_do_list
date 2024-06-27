///
/// [TaskStatus] task status enum
/// * [pending] 대기
/// * [ongoing] 진행중
/// * [completed] 완료
///
enum TaskStatus {
  pending,
  ongoing,
  completed;

  String get name {
    switch (this) {
      case TaskStatus.pending:
        return '대기';
      case TaskStatus.ongoing:
        return '진행중';
      case TaskStatus.completed:
        return '완료';
    }
  }
}
