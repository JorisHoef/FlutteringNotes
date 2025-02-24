class Task {
  int id;
  String title;
  bool finished;
  String description;

  Task({
    required this.id,
    required this.title,
    this.finished = false,
    this.description = '',
  });
}