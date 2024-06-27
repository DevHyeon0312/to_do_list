import 'package:floor/floor.dart';

@Entity(tableName: 'task_table', primaryKeys: ['id'])
class DbTaskEntity {
  final int id;
  final int sortId;
  final String title;
  final String content;
  final String category;
  final int? dueDateMilliSeconds;
  final String link;
  final bool isOnGoing;
  final bool isCompleted;

  DbTaskEntity({
    required this.id,
    required this.sortId,
    required this.title,
    required this.content,
    required this.category,
    required this.dueDateMilliSeconds,
    required this.link,
    required this.isOnGoing,
    required this.isCompleted,
  });

  @override
  String toString() {
    return 'DbTaskEntity{id: $id, title: $title, content: $content, category: $category, dueDateMilliSeconds: $dueDateMilliSeconds, link: $link, isOnGoing: $isOnGoing, isCompleted: $isCompleted}';
  }
}