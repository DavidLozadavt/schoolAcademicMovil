import 'package:flutter/material.dart';
import 'package:vtschool/Src/Models/student.dart';

class TaskScreen extends StatelessWidget {
  final List<Task> tasks;

  const TaskScreen(this.tasks, {super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Tareas Pendientes'),
      ),
      body: ListView.builder(
        itemCount: tasks.length,
        itemBuilder: (context, index) {
          Task task = tasks[index];
          return Card(
            child: ListTile(
              title: Text(task.title),
              subtitle: Text(task.description),
            ),
          );
        },
      ),
    );
  }
}
