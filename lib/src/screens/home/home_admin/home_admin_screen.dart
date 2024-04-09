import 'package:flutter/material.dart';
import 'package:vtschool/src/screens/profile/logout_screen.dart';

class HomeAdminScreen extends StatelessWidget {
  const HomeAdminScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF282C34), // Deep, calming blue background
      appBar: AppBar(
        title: const Text(
          'Bienvenido, Admin!',
          style: TextStyle(
            fontSize: 24.0,
            fontWeight: FontWeight.bold,
            color: Colors.white, // White text
          ),
        ),
        centerTitle: true, // Center the title for better balance
        backgroundColor: const Color(0xFF455A64), // Darker blue for contrast
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () {
              logoutApp(context);
            },
            color: Colors.white, // White icon for better visibility
          ),
        ],
      ),

      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment
                .stretch, // Stretch widgets horizontally for full-width usage
            children: [
              const Text(
                '¡Hola!', // More informal greeting
                style: TextStyle(
                  fontSize: 48.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.white, // White text
                ),
              ),
              const SizedBox(height: 16.0), // Add some space
              const Text(
                '¿Qué te gustaría hacer hoy?', // Actionable prompt
                style: TextStyle(
                  fontSize: 20.0,
                  color:
                      Colors.white70, // Lighter white text for subtle guidance
                ),
              ),
              const SizedBox(height: 32.0), // More space for clarity

              // Interactive action cards with gradients and icons
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  InkWell(
                    onTap: () {
                      // Handle dashboard action
                    },
                    child: Card(
                      elevation: 4.0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12.0),
                      ),
                      child: Container(
                        padding: const EdgeInsets.all(16.0),
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: [
                              Colors.teal.shade300,
                              Colors.teal.shade700
                            ],
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                          ),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: const [
                            Icon(
                              Icons.dashboard,
                              size: 36.0,
                              color: Colors.white,
                            ),
                            SizedBox(height: 8.0),
                            Text(
                              'Panel',
                              style: TextStyle(
                                fontSize: 16.0,
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      // Handle settings action
                    },
                    child: Card(
                      elevation: 4.0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12.0),
                      ),
                      child: Container(
                        padding: const EdgeInsets.all(16.0),
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: [
                              Colors.pink.shade300,
                              Colors.pink.shade700
                            ],
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                          ),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: const [
                            Icon(
                              Icons.settings,
                              size: 36.0,
                              color: Colors.white,
                            ),
                            SizedBox(height: 8.0),
                            Text(
                              'Ajustes',
                              style: TextStyle(
                                fontSize: 16.0,
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      // Handle users action
                    },
                    child: Card(
                      elevation: 4.0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12.0),
                      ),
                      child: Container(
                        padding: const EdgeInsets.all(16.0),
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: [
                              Colors.orange.shade300,
                              Colors.orange.shade700
                            ],
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                          ),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: const [
                            Icon(
                              Icons.supervised_user_circle,
                              size: 36.0,
                              color: Colors.white,
                            ),
                            SizedBox(height: 8.0),
                            Text(
                              'Usuarios',
                              style: TextStyle(
                                fontSize: 16.0,
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 32.0), // More space

              // Floating action button for adding new items
              FloatingActionButton(
                onPressed: () {
                  // Handle new item addition
                },
                backgroundColor: const Color(0xFF00BCD4), // Cyan accent color
                child: const Icon(
                  Icons.add,
                  size: 32.0,
                  color: Colors.white,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
