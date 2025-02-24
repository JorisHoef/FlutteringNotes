import 'package:flutter/material.dart';

import '../models/taskList_model.dart';

class TaskListCreationWidget extends StatefulWidget {
  final void Function(TaskList) onCreate;

  const TaskListCreationWidget({Key? key, required this.onCreate}) : super(key: key);

  @override
  _TaskListCreationWidgetState createState() => _TaskListCreationWidgetState();
}

class _TaskListCreationWidgetState extends State<TaskListCreationWidget> {
  final _formKey = GlobalKey<FormState>();
  String _title = '';

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Create New Task List'),
      content: Form(
        key: _formKey,
        child: TextFormField(
          decoration: const InputDecoration(labelText: 'Task List Title'),
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Please enter a title';
            }
            return null;
          },
          onSaved: (value) {
            _title = value ?? '';
          },
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text('Cancel'),
        ),
        ElevatedButton(
          onPressed: () {
            if (_formKey.currentState?.validate() ?? false) {
              _formKey.currentState?.save();
              // Create a new TaskList with a unique id (using timestamp for simplicity).
              final newTaskList = TaskList(
                id: DateTime.now().millisecondsSinceEpoch,
                title: _title,
              );
              widget.onCreate(newTaskList);
              Navigator.pop(context);
            }
          },
          child: const Text('Create'),
        ),
      ],
    );
  }
}