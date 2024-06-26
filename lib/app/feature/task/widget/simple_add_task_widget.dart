import 'package:flutter/material.dart';
import 'package:to_do_list/app/data/enum/task_category.dart';
import 'package:to_do_list/common/widget/single_text_field.dart';

class SimpleAddTaskWidget extends StatefulWidget {
  const SimpleAddTaskWidget({super.key, required this.onSubmit});

  final Function(String title, TaskCategory? category, DateTime? dueDate)
      onSubmit;

  @override
  State<SimpleAddTaskWidget> createState() => _SimpleAddTaskWidgetState();
}

class _SimpleAddTaskWidgetState extends State<SimpleAddTaskWidget> {
  final _titleController = TextEditingController();
  final FocusNode _titleFocusNode = FocusNode();
  TaskCategory? _selectedCategory = TaskCategory.none;
  DateTime? _selectedDate;
  bool _isTitleValid = false;

  @override
  void initState() {
    super.initState();
    _titleController.addListener(validation);
  }

  @override
  void dispose() {
    _titleController.removeListener(validation);
    _titleController.dispose();
    _titleFocusNode.dispose();
    super.dispose();
  }

  void validation() {
    if (_titleController.text.isNotEmpty) {
      _isTitleValid = true;
    } else {
      _isTitleValid = false;
    }
    setState(() {

    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
          bottom: MediaQuery.of(context).viewInsets.bottom + 16,
          top: 16,
          left: 16,
          right: 16,
      ),
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SingleTextField(
              controller: _titleController,
              focusNode: _titleFocusNode,
              hintText: '제목을 입력해주세요.',
              backgroundColor: const Color(0x50E0E0E0),
            ),
            const SizedBox(
              height: 16,
            ),
            Row(
              children: [
                SizedBox(
                  width: 100,
                  height: 30,
                  child: InputDecorator(
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.grey[100],
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12.0),
                        borderSide: BorderSide.none,
                      ),
                      contentPadding: const EdgeInsets.symmetric(
                          vertical: 0.0, horizontal: 8.0),
                    ),
                    child: DropdownButtonHideUnderline(
                      child: DropdownButton<TaskCategory>(
                        isDense: true,
                        value: _selectedCategory,
                        dropdownColor: Colors.white,
                        icon: const SizedBox.shrink(),
                        onChanged: (TaskCategory? newValue) {
                          setState(() {
                            _selectedCategory = newValue;
                          });
                        },
                        items: TaskCategory.values.map((TaskCategory category) {
                          return DropdownMenuItem<TaskCategory>(
                            value: category,
                            child: Text(
                              category.name,
                              overflow: TextOverflow.ellipsis,
                              maxLines: 1,
                              style: TextStyle(
                                fontSize: 14,
                                color: category == _selectedCategory
                                    ? Colors.blueAccent
                                    : Colors.black,
                              ),
                              textScaler: TextScaler.noScaling,
                            ),
                          );
                        }).toList(),
                        selectedItemBuilder: (BuildContext context) {
                          return TaskCategory.values
                              .map((TaskCategory category) {
                            return Text(
                              category.name,
                              overflow: TextOverflow.ellipsis,
                              maxLines: 1,
                              style: TextStyle(
                                fontSize: 14,
                                color: category == TaskCategory.none
                                    ? Colors.grey
                                    : Colors.blueAccent,
                              ),
                              textScaler: TextScaler.noScaling,
                            );
                          }).toList();
                        },
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 16.0),
                GestureDetector(
                  onTap: () async {
                    final DateTime? picked = await showDatePicker(
                      context: context,
                      initialDate: DateTime.now(),
                      firstDate: DateTime(2015, 8),
                      lastDate: DateTime(2101),
                    );
                    if (picked != null && picked != _selectedDate) {
                      setState(() {
                        _selectedDate = picked;
                      });
                    }
                  },
                  child: Row(
                    children: [
                      Icon(
                        Icons.calendar_today,
                        color: _selectedDate == null
                            ? Colors.grey
                            : Colors.blueAccent,
                        size: 24,
                      ),
                      const SizedBox(width: 4),
                      Text(
                        _selectedDate == null
                            ? '마감일 없음'
                            : '${_selectedDate!.year}년 ${_selectedDate!.month}월 ${_selectedDate!.day}일',
                        style: TextStyle(
                          color: _selectedDate == null
                              ? Colors.grey
                              : Colors.blueAccent,
                        ),
                      ),
                    ],
                  ),
                ),

                const Spacer(),
                IconButton(
                    onPressed: _isTitleValid ? () {
                      _titleFocusNode.unfocus();
                      final title = _titleController.text;
                      if (title.isNotEmpty) {
                        widget.onSubmit(title, _selectedCategory, _selectedDate);
                        Navigator.of(context).pop();
                      }
                    } : null,
                    icon: Icon(
                      Icons.save,
                      color: _isTitleValid ? Colors.blueAccent : Colors.grey,
                      size: 32,
                    )),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
