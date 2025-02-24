import 'task_model.dart';

class TaskList {
  final int id;
  String title;
  bool finished;
  List<Task> tasks;

  TaskList({
    required this.id,
    required this.title,
    this.finished = false,
    List<Task>? tasks,
  }) : tasks = tasks ?? [];
}