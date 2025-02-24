import 'task_model.dart';

class TaskList {
  int id;
  String title;
  List<Task> tasks;

  TaskList({required this.id, required this.title, List<Task>? tasks})
      : tasks = tasks ?? [];
}
