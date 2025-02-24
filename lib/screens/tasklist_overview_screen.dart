import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

import '../models/taskList_model.dart';
import '../models/task_model.dart';
import '../widgets/tasklist_creation_widget.dart';
import 'task_edit_screen.dart';

class TaskListOverviewScreen extends StatefulWidget {
  const TaskListOverviewScreen({Key? key}) : super(key: key);

  @override
  _TaskListOverviewScreenState createState() => _TaskListOverviewScreenState();
}

class _TaskListOverviewScreenState extends State<TaskListOverviewScreen> {
  List<TaskList> taskLists = [];

  // Adds a new TaskList.
  void _addTaskList(TaskList taskList) {
    setState(() {
      taskLists.add(taskList);
    });
  }

  // Renames a TaskList via a dialog.
  void _renameTaskList(TaskList taskList) {
    final controller = TextEditingController(text: taskList.title);
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Rename Task List'),
        content: TextField(
          controller: controller,
          maxLines: 1,
          decoration: const InputDecoration(labelText: 'New Title'),
        ),
        actions: [
          TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Cancel')),
          ElevatedButton(
            onPressed: () {
              setState(() {
                taskList.title = controller.text;
              });
              Navigator.pop(context);
            },
            child: const Text('Save'),
          )
        ],
      ),
    );
  }

  // Deletes a TaskList after confirmation.
  void _deleteTaskList(TaskList taskList) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("Delete Task List"),
        content:
        const Text("Are you sure you want to delete this task list?"),
        actions: [
          TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text("Cancel")),
          ElevatedButton(
            onPressed: () {
              setState(() {
                taskLists.remove(taskList);
              });
              Navigator.pop(context);
            },
            child: const Text("Delete"),
          ),
        ],
      ),
    );
  }

  // Reorders TaskLists.
  void _onReorderTaskLists(int oldIndex, int newIndex) {
    setState(() {
      if (newIndex > oldIndex) newIndex -= 1;
      final TaskList moved = taskLists.removeAt(oldIndex);
      taskLists.insert(newIndex, moved);
    });
  }

  // Reorders tasks within a TaskList.
  void _onReorderTasks(TaskList taskList, int oldIndex, int newIndex) {
    setState(() {
      if (newIndex > oldIndex) newIndex -= 1;
      final Task moved = taskList.tasks.removeAt(oldIndex);
      taskList.tasks.insert(newIndex, moved);
    });
  }

  // Toggles finished status for an individual task.
  void _toggleTaskFinished(TaskList taskList, int taskIndex, bool? newValue) {
    setState(() {
      taskList.tasks[taskIndex].finished = newValue ?? false;
      // If any task becomes unfinished, unfinish the TaskList.
      if (!taskList.tasks[taskIndex].finished) {
        taskList.finished = false;
      } else if (taskList.tasks.isNotEmpty &&
          taskList.tasks.every((t) => t.finished)) {
        taskList.finished = true;
      }
    });
  }

  // Toggles the finished state for the entire TaskList.
  void _toggleTaskListFinished(TaskList taskList, bool? newValue) {
    setState(() {
      taskList.finished = newValue ?? false;
      for (var t in taskList.tasks) {
        t.finished = taskList.finished;
      }
    });
  }

  // Opens the edit screen for a task.
  void _editTask(TaskList taskList, int taskIndex) async {
    final task = taskList.tasks[taskIndex];
    final updatedTask = await Navigator.push<Task>(
      context,
      MaterialPageRoute(
        builder: (context) => TaskEditScreen(task: task),
      ),
    );
    if (updatedTask != null) {
      setState(() {
        taskList.tasks[taskIndex] = updatedTask;
        if (!updatedTask.finished) {
          taskList.finished = false;
        } else if (taskList.tasks.isNotEmpty &&
            taskList.tasks.every((t) => t.finished)) {
          taskList.finished = true;
        }
      });
    }
  }

  // Adds a new task to a TaskList and opens its edit screen.
  void _addTaskToList(TaskList taskList) {
    final newTask = Task(
      id: DateTime.now().millisecondsSinceEpoch,
      title: 'New Task',
      finished: false,
      description: '',
    );
    setState(() {
      taskList.tasks.add(newTask);
      taskList.finished = false;
    });
    Navigator.push<Task>(
      context,
      MaterialPageRoute(
        builder: (context) => TaskEditScreen(task: newTask),
      ),
    ).then((updatedTask) {
      if (updatedTask != null) {
        setState(() {
          final index = taskList.tasks.indexWhere((t) => t.id == newTask.id);
          if (index != -1) {
            taskList.tasks[index] = updatedTask;
            if (taskList.tasks.isNotEmpty &&
                taskList.tasks.every((t) => t.finished)) {
              taskList.finished = true;
            } else {
              taskList.finished = false;
            }
          }
        });
      }
    });
  }

  // Deletes an individual task after confirmation.
  void _deleteTask(TaskList taskList, int taskIndex) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("Delete Task"),
        content: const Text("Are you sure you want to delete this task?"),
        actions: [
          TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text("Cancel")),
          ElevatedButton(
            onPressed: () {
              setState(() {
                taskList.tasks.removeAt(taskIndex);
                // If no tasks remain, unfinish the TaskList.
                if (taskList.tasks.isEmpty) {
                  taskList.finished = false;
                }
              });
              Navigator.pop(context);
            },
            child: const Text("Delete"),
          ),
        ],
      ),
    );
  }

  // Builds an individual task tile for a TaskList.
  Widget _buildTaskTile(TaskList taskList, int taskIndex) {
    final task = taskList.tasks[taskIndex];
    Widget tile = ListTile(
      leading: Checkbox(
        value: task.finished,
        onChanged: (value) =>
            _toggleTaskFinished(taskList, taskIndex, value),
      ),
      title: Text(
        task.title,
        maxLines: 1,
        overflow: TextOverflow.fade,
        style: TextStyle(
          decoration: task.finished ? TextDecoration.lineThrough : null,
        ),
      ),
      subtitle: task.description.isNotEmpty
          ? Text(
        task.description,
        maxLines: 2,
        overflow: TextOverflow.fade,
      )
          : null,
      onTap: () => _editTask(taskList, taskIndex),
      trailing: IconButton(
        icon: const Icon(Icons.delete),
        onPressed: () => _deleteTask(taskList, taskIndex),
      ),
    );

    if (task.finished) {
      tile = Opacity(
        opacity: 0.5,
        child: Stack(
          children: [
            tile,
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
    // Wrap the tile with left padding and a vertical line to indicate it's a subtask.
    return Container(
      padding: const EdgeInsets.only(left: 16.0),
      decoration: const BoxDecoration(
        border: Border(
          left: BorderSide(color: Colors.grey, width: 2),
        ),
      ),
      child: tile,
    );
  }

  // Builds the header for a TaskList card.
  Widget _buildTaskListHeader(TaskList taskList) {
    return Row(
      children: [
        // Toggle for TaskList finished state.
        Checkbox(
          value: taskList.finished,
          onChanged: (value) => _toggleTaskListFinished(taskList, value),
        ),
        // TaskList title (one line).
        Expanded(
          child: Text(
            taskList.title,
            maxLines: 1,
            overflow: TextOverflow.fade,
            style: TextStyle(
              decoration:
              taskList.finished ? TextDecoration.lineThrough : null,
            ),
          ),
        ),
        // Rename icon.
        IconButton(
          icon: const Icon(Icons.edit, size: 20),
          onPressed: () => _renameTaskList(taskList),
        ),
        // Delete icon.
        IconButton(
          icon: const Icon(Icons.delete, size: 20),
          onPressed: () => _deleteTaskList(taskList),
        ),
      ],
    );
  }

  // Builds the TaskList card widget.
  Widget _buildTaskListCard(TaskList taskList) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      child: ExpansionTile(
        key: ValueKey(taskList.id),
        title: _buildTaskListHeader(taskList),
        children: [
          // Nested ReorderableListView for tasks.
          ReorderableListView(
            onReorder: (oldIndex, newIndex) =>
                _onReorderTasks(taskList, oldIndex, newIndex),
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            buildDefaultDragHandles: false,
            children: [
              for (int i = 0; i < taskList.tasks.length; i++)
                ReorderableDelayedDragStartListener(
                  key: ValueKey(taskList.tasks[i].id),
                  index: i,
                  child: _buildTaskTile(taskList, i),
                ),
            ],
          ),
          ListTile(
            leading: const Icon(Icons.add),
            title: const Text('Add new task'),
            onTap: () => _addTaskToList(taskList),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Task Lists Overview'),
      ),
      body: ReorderableListView(
        onReorder: _onReorderTaskLists,
        padding: const EdgeInsets.only(bottom: 80),
        children: [
          for (int i = 0; i < taskLists.length; i++)
          // Wrap each TaskList card in a ReorderableDelayedDragStartListener so the entire card is draggable.
            ReorderableDelayedDragStartListener(
              key: ValueKey(taskLists[i].id),
              index: i,
              child: _buildTaskListCard(taskLists[i]),
            ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Open the TaskList creation dialog.
          showDialog(
            context: context,
            builder: (context) {
              return TaskListCreationWidget(onCreate: _addTaskList);
            },
          );
        },
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
