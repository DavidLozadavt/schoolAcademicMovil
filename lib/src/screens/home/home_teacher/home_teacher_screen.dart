import 'package:flutter/material.dart';

class HomeTeacherScreen extends StatelessWidget {
  const HomeTeacherScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Color(0xFFAACCFF), // Light blue background
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Text with apple icon for teachers
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.school,
                  size: 30,
                  color: Colors.green, // Green school icon
                ),
                SizedBox(width: 10), // Add some space
                Text(
                  "Bienvenido Profesor!",
                  style: TextStyle(
                    fontSize: 36,
                    fontWeight: FontWeight.bold,
                    color: Colors.purple, // Purple text
                  ),
                ),
              ],
            ),
            SizedBox(height: 20), // Add some space

            // Row with task-related icons
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.book,
                  size: 30,
                  color: Colors.orange, // Orange book icon
                ),
                SizedBox(width: 20), // Space between icons
                Icon(
                  Icons.assignment,
                  size: 30,
                  color: Colors.teal, // Teal assignment icon
                ),
                SizedBox(width: 20), // Space between icons
                Icon(
                  Icons.grading,
                  size: 30,
                  color: Colors.pink, // Pink grading icon
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
