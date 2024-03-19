import 'package:flutter/material.dart';
import 'package:vtschool/src/config/theme/app_theme.dart';
import 'package:vtschool/src/models/student.dart';

class TaskScreen extends StatelessWidget {
  final List<Task> tasks;

  const TaskScreen(this.tasks, {super.key});

  @override
  Widget build(BuildContext context) {
    return 
    Scaffold(
      body: Container(
        padding: const EdgeInsets.all(25),
        decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  listColor[3],
                  listColor[2],
                ],
              ),
            ),
        child:
            ListView.builder(
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
      ),
    );
  }
}
