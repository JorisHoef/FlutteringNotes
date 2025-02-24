import 'package:flutter/material.dart';

import '../models/taskList_model.dart';
import '../models/task_model.dart';

class TaskListDetailScreen extends StatefulWidget {
  final TaskList taskList;

  const TaskListDetailScreen({Key? key, required this.taskList}) : super(key: key);

  @override
  _TaskListDetailScreenState createState() => _TaskListDetailScreenState();
}

class _TaskListDetailScreenState extends State<TaskListDetailScreen> {
  late List<Task> tasks;

  @override
  void initState() {
    super.initState();
    tasks = widget.taskList.tasks;
  }

  void _addTask() {
    setState(() {
      // Create a new task with a temporary id.
      tasks.add(Task(
        id: DateTime.now().millisecondsSinceEpoch,
        title: 'New Task',
      ));
    });
  }

  void _onReorder(int oldIndex, int newIndex) {
    setState(() {
      if (newIndex > oldIndex) {
        newIndex -= 1;
      }
      final Task item = tasks.removeAt(oldIndex);
      tasks.insert(newIndex, item);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.taskList.title),
      ),
      body: ReorderableListView(
        onReorder: _onReorder,
        padding: const EdgeInsets.all(16.0),
        children: [
          for (int index = 0; index < tasks.length; index++)
            ListTile(
              key: ValueKey(tasks[index].id),
              title: Text(tasks[index].title),
              trailing: const Icon(Icons.drag_handle),
            ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _addTask,
        child: const Icon(Icons.add),
      ),
    );
  }
}