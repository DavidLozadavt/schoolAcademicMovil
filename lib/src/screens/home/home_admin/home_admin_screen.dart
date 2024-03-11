import 'package:flutter/material.dart';

class HomeAdminScreen extends StatelessWidget {
  const HomeAdminScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Color(0xFF333333), // Dark background
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Big and bold title
            Text(
              "Bienvenido Admin!",
              style: TextStyle(
                fontSize: 40,
                fontWeight: FontWeight.bold,
                color: Colors.white, // White text
              ),
            ),
            SizedBox(height: 20), // Add some space

            // Row with colorful icons
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.dashboard,
                  size: 30,
                  color: Colors.orange, // Orange icon
                ),
                SizedBox(width: 20), // Space between icons
                Icon(
                  Icons.settings,
                  size: 30,
                  color: Colors.teal, // Teal icon
                ),
                SizedBox(width: 20), // Space between icons
                Icon(
                  Icons.supervised_user_circle,
                  size: 30,
                  color: Colors.pink, // Pink icon
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
