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
      tasks.add(Task(
        id: DateTime.now().millisecondsSinceEpoch,
        title: 'New Task',
      ));
    });
  }

  /// Opens a dialog to rename the task at [index].
  void _renameTask(int index) {
    final task = tasks[index];
    final controller = TextEditingController(text: task.title);

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Rename Task'),
        content: TextField(
          controller: controller,
          decoration: const InputDecoration(labelText: 'Task Title'),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              setState(() {
                tasks[index].title = controller.text;
              });
              Navigator.pop(context);
            },
            child: const Text('Save'),
          ),
        ],
      ),
    );
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
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  IconButton(
                    icon: const Icon(Icons.edit),
                    onPressed: () => _renameTask(index),
                  ),
                  const Icon(Icons.drag_handle),
                ],
              ),
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