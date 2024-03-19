import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:vtschool/src/models/student.dart';
import 'package:vtschool/src/screens/home/home_student/home_student_screen.dart';
import 'package:vtschool/src/screens/notas/Student_notas.dart';
import 'package:vtschool/src/screens/notas/Task.dart';
import 'package:vtschool/src/screens/profile/myprofile_screen.dart';
import 'package:vtschool/src/screens/profile/profile_user_screen.dart';
import 'package:vtschool/src/screens/wompi/wompi_servise.dart';
import 'package:vtschool/src/widgets/item_navigation_button.dart';

class HomeStudent extends StatelessWidget {
   HomeStudent({super.key});

   List<Task> tasks = [
    Task('Examen de Calculo', 'Revisar apuntes de Calculo'),
    Task('Taller de Ingles', 'Revisar apuntes de  Ingles'),
    Task('Tarea de Informatica', 'Revisar apuntes Informatica'),
  ];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        bottomNavigationBar: CupertinoTabScaffold(
          tabBar: CupertinoTabBar(
            backgroundColor: Colors.transparent,
            border: const Border(),
            height: 62,
            items: const [
              BottomNavigationBarItem(
                icon: ItemNavigationButton(
                  fileIcon: 'assets/images/home.png',
                  title: 'Home',
                ),
                activeIcon: ItemNavigationButton(
                  fileIcon: 'assets/images/home.png',
                  title: 'Home',
                  isActive: true,
                ),
              ),
              BottomNavigationBarItem(
                icon: ItemNavigationButton(
                  fileIcon: 'assets/images/task.png',
                  title: 'Mis tareas',
                ),
                activeIcon: ItemNavigationButton(
                  fileIcon: 'assets/images/task.png',
                  title: 'Mis tareas',
                  isActive: true,
                ),
              ),
              BottomNavigationBarItem(
                icon: ItemNavigationButton(
                  fileIcon: 'assets/images/note.png',
                  title: 'Mis notas',
                ),
                activeIcon: ItemNavigationButton(
                  fileIcon: 'assets/images/note.png',
                  title: 'Mis notas',
                  isActive: true,
                ),
              ),
              BottomNavigationBarItem(
                icon: ItemNavigationButton(
                  fileIcon: 'assets/images/payment.png',
                  title: 'Pagos',
                ),
                activeIcon: ItemNavigationButton(
                  fileIcon: 'assets/images/payment.png',
                  title: 'Pagos',
                  isActive: true,
                ),
              ),
              BottomNavigationBarItem(
                icon: ItemNavigationButton(
                  fileIcon: 'assets/images/profile.png',
                  title: 'Profile',
                ),
                activeIcon: ItemNavigationButton(
                  fileIcon: 'assets/images/profile.png',
                  title: 'Profile',
                  isActive: true,
                ),
              ),
            ],
          ),
          tabBuilder: (context, index) {
            switch (index) {
              case 0:
                return CupertinoTabView(
                  builder: (BuildContext context) => HomeStudentScreen(),
                );
              case 1:
                return CupertinoTabView(
                  builder: (BuildContext context) =>   TaskScreen(tasks),
                );
              case 2:
                return CupertinoTabView(
                  builder: (context) =>  const StudentPage(),
                );
              case 3:
                return CupertinoTabView(
                  builder: (BuildContext context) => const PagosPage(),
                );
              case 4:
                return CupertinoTabView(
                  builder: (BuildContext context) => ProfileUserScreen(),
                );
              default:
                return CupertinoTabView(
                  builder: (BuildContext context) => HomeStudentScreen(),
                );
            }
          },
        ),
      ),
    );
  }
}