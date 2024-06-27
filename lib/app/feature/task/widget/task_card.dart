import 'package:flutter/material.dart';
import 'package:to_do_list/app/data/enum/task_status.dart';
import 'package:to_do_list/app/data/model/task.dart';
import 'package:to_do_list/common/util/date_util.dart';

/// [TaskCard] 할일 카드 위젯
/// * 할일 정보를 보여주는 카드 위젯
class TaskCard extends StatefulWidget {
  final Task task;
  final int position;
  final VoidCallback onStart;
  final VoidCallback onCompleted;
  final VoidCallback onTap;
  final VoidCallback onDelete;

  const TaskCard({
    super.key,
    required this.task,
    required this.position,
    required this.onStart,
    required this.onCompleted,
    required this.onTap,
    required this.onDelete,
  });

  @override
  State<TaskCard> createState() => _TaskCardState();
}

class _TaskCardState extends State<TaskCard>
    with SingleTickerProviderStateMixin {
  bool _showActions = false;
  AnimationController? _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );
  }

  @override
  void dispose() {
    _controller?.dispose();
    super.dispose();
  }

  void _onTab() {
    if (_showActions) {
      _toggleActions();
    } else {
      widget.onTap.call();
    }
  }

  void _toggleActions() {
    print('toggleActions');
    setState(() {
      _showActions = !_showActions;
      if (_showActions) {
        _controller?.forward();
      } else {
        _controller?.reverse();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(8),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: _onTab,
          borderRadius: BorderRadius.circular(8.0),
          child: Row(
            children: [
              ReorderableDragStartListener(
                index: widget.position,
                child: const Icon(
                  Icons.drag_indicator,
                  color: Colors.blueAccent,
                  size: 32,
                ),
              ),
              Expanded(
                child: GestureDetector(
                  onLongPress: _toggleActions,
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 300),
                    margin: const EdgeInsets.all(16.0),
                    transform:
                    Matrix4.translationValues(_showActions ? -10 : 0, 0, 0),
                    child: Container(
                      color: Colors.transparent,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            widget.task.title,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(
                              color: Colors.black,
                              fontSize: 18.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 4.0),
                            child: Text(
                              widget.task.content.isNotEmpty ? widget.task.content : '내용 없음',
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(
                                color: Colors.black54,
                                fontSize: 14.0,
                              ),
                            ),
                          ),
                          if (widget.task.dueDate != null)
                            Padding(
                              padding: const EdgeInsets.only(top: 2.0),
                              child: Text(
                                '마감일: ${DateUtil.getFormattedDate(widget.task.dueDate)}',
                                style: const TextStyle(
                                  color: Colors.red,
                                  fontSize: 10.0,
                                ),
                              ),
                            ),
                        ],
                      ),
                    )
                  ),
                ),
              ),
              if (_showActions)
                Row(
                  children: [
                    widget.task.status == TaskStatus.pending
                        ? IconButton(
                            icon: const Icon(Icons.not_started),
                            color: Colors.orange,
                            onPressed: () {
                              _toggleActions();
                              widget.onStart.call();
                            },
                          )
                        : const SizedBox.shrink(),
                    widget.task.status != TaskStatus.completed
                        ? IconButton(
                            icon: const Icon(Icons.check_circle),
                            color: Colors.green,
                            onPressed: () {
                              _toggleActions();
                              widget.onCompleted.call();
                            },
                          )
                        : const SizedBox.shrink(),
                    IconButton(
                      icon: const Icon(Icons.delete),
                      color: Colors.red,
                      onPressed: () {
                        _toggleActions();
                        widget.onDelete.call();
                      },
                    ),
                  ],
                ),
            ],
          ),
        ),
      ),
    );
  }
}
