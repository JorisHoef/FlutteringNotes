import 'package:flutter/material.dart';

import '../models/taskList_model.dart';
import '../models/task_model.dart';
import 'task_edit_screen.dart';

class TaskListDetailScreen extends StatefulWidget {
  final TaskList taskList;

  const TaskListDetailScreen({Key? key, required this.taskList})
      : super(key: key);

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
        finished: false,
        description: '',
      ));
    });
  }

  /// Toggles the finished status of a task.
  void _toggleFinished(int index, bool? newValue) {
    setState(() {
      tasks[index].finished = newValue ?? false;
    });
  }

  /// Opens a new screen to edit the task’s title and description.
  void _editTask(int index) async {
    final updatedTask = await Navigator.push<Task>(
      context,
      MaterialPageRoute(
        builder: (context) => TaskEditScreen(task: tasks[index]),
      ),
    );
    if (updatedTask != null) {
      setState(() {
        tasks[index] = updatedTask;
      });
    }
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

  Widget _buildTaskTile(Task task, int index) {
    // Build the base ListTile without a trailing drag handle.
    Widget tile = ListTile(
      leading: Checkbox(
        value: task.finished,
        onChanged: (value) => _toggleFinished(index, value),
      ),
      title: Text(task.title),
      subtitle: task.description.isNotEmpty
          ? Text(
        task.description,
        maxLines: 2,
        overflow: TextOverflow.fade,
      )
          : null,
      onTap: () => _editTask(index),
    );

    // If the task is finished, overlay a strikethrough and reduce opacity,
    // but let the interactive parts (e.g. checkbox) remain responsive.
    if (task.finished) {
      tile = Opacity(
        opacity: 0.5,
        child: Stack(
          children: [
            tile,
            // Overlay a strikethrough line.
            Positioned.fill(
              child: IgnorePointer(
                child: CustomPaint(
                  painter: StrikethroughPainter(),
                ),
              ),
            ),
          ],
        ),
      );
    }

    return tile;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.taskList.title),
      ),
      body: ReorderableListView(
        buildDefaultDragHandles: false, // Disable default drag handles.
        onReorder: _onReorder,
        padding: const EdgeInsets.all(16.0),
        children: [
          for (int index = 0; index < tasks.length; index++)
          // Wrap each tile in a ReorderableDelayedDragStartListener with a key.
            ReorderableDelayedDragStartListener(
              key: ValueKey(tasks[index].id),
              index: index,
              child: _buildTaskTile(tasks[index], index),
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

/// A CustomPainter that draws a horizontal line through the center.
class StrikethroughPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final Paint paint = Paint()
      ..color = Colors.black54
      ..strokeWidth = 2.0;
    canvas.drawLine(
      Offset(0, size.height / 2),
      Offset(size.width, size.height / 2),
      paint,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}