import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:vtschool/src/screens/calendar/calendar_screen2.dart';
import 'package:vtschool/src/screens/calendar/calendar_screen3.dart';
import 'package:vtschool/src/screens/home/home_student/home_student_screen.dart';

import 'package:vtschool/src/screens/profile/myprofile_screen.dart';
import 'package:vtschool/src/widgets/item_navigation_button.dart';

class HomeStudent extends StatelessWidget {
  const HomeStudent({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        bottomNavigationBar: CupertinoTabScaffold(
          tabBar: CupertinoTabBar(
            backgroundColor: Colors.white,
            border: const Border(),
            height: 62,
            items: const [
              BottomNavigationBarItem(
                icon: ItemNavigationButton(
                  fileIcon: 'assets/images/ups.png',
                  title: 'Home',
                ),
                activeIcon: ItemNavigationButton(
                  fileIcon: 'assets/images/ups.png',
                  title: 'Home',
                  isActive: true,
                ),
              ),
              BottomNavigationBarItem(
                icon: ItemNavigationButton(
                  fileIcon: 'assets/images/ups.png',
                  title: 'Otro',
                ),
                activeIcon: ItemNavigationButton(
                  fileIcon: 'assets/images/ups.png',
                  title: 'Otro',
                  isActive: true,
                ),
              ),
              BottomNavigationBarItem(
                icon: ItemNavigationButton(
                  fileIcon: 'assets/images/ups.png',
                  title: 'Otro',
                ),
                activeIcon: ItemNavigationButton(
                  fileIcon: 'assets/images/ups.png',
                  title: 'Otro',
                  isActive: true,
                ),
              ),
              BottomNavigationBarItem(
                icon: ItemNavigationButton(
                  fileIcon: 'assets/images/ups.png',
                  title: 'Otro',
                ),
                activeIcon: ItemNavigationButton(
                  fileIcon: 'assets/images/ups.png',
                  title: 'Otro',
                  isActive: true,
                ),
              ),
              BottomNavigationBarItem(
                icon: ItemNavigationButton(
                  fileIcon: 'assets/images/ups.png',
                  title: 'Profile',
                ),
                activeIcon: ItemNavigationButton(
                  fileIcon: 'assets/images/ups.png',
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
                  builder: (BuildContext context) => const HomeStudentScreen(),
                );
              case 1:
                return CupertinoTabView(
                  builder: (BuildContext context) => CalendarView(),
                );
              case 2:
                return CupertinoTabView(
                  builder: (context) => CalendarWrapper(),
                );
              case 3:
                return CupertinoTabView(
                  builder: (BuildContext context) => const MyProfileScreen(),
                );
              case 4:
                return CupertinoTabView(
                  builder: (BuildContext context) => const MyProfileScreen(),
                );
              default:
                return CupertinoTabView(
                  builder: (BuildContext context) => const MyProfileScreen(),
                );
            }
          },
        ),
      ),
    );
  }
}
