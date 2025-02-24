import 'package:flutter/material.dart';

import '../models/taskList_model.dart';
import '../widgets/tasklist_creation_widget.dart';
import 'tasklist_details_screen.dart';

class TaskListOverviewScreen extends StatefulWidget {
  const TaskListOverviewScreen({Key? key}) : super(key: key);

  @override
  _TaskListOverviewScreenState createState() => _TaskListOverviewScreenState();
}

class _TaskListOverviewScreenState extends State<TaskListOverviewScreen> {
  List<TaskList> taskLists = [];

  void _addTaskList(TaskList taskList) {
    setState(() {
      taskLists.add(taskList);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Task Lists Overview'),
      ),
      body: ListView.builder(
        itemCount: taskLists.length,
        itemBuilder: (context, index) {
          final taskList = taskLists[index];
          return ListTile(
            title: Text(taskList.title),
            trailing: const Icon(Icons.arrow_forward),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => TaskListDetailScreen(taskList: taskList),
                ),
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Open the tasklist creation dialog.
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