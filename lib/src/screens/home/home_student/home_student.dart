import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:vtschool/src/screens/chat/chats_screen.dart';
import 'package:vtschool/src/screens/home/home_controller.dart';
import 'package:vtschool/src/screens/home/home_student/home_student_screen.dart';
import 'package:vtschool/src/screens/payments/payments_screen.dart';
import 'package:vtschool/src/screens/profile/profile_user_screen.dart';
import 'package:vtschool/src/screens/ratings/ratings_student.dart';
import 'package:vtschool/src/widgets/item_navigation_button.dart';

class HomeStudent extends StatelessWidget {
  HomeStudent({super.key});
  final HomeController controller = Get.put(HomeController());

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        bottomNavigationBar: Obx(() => BottomNavigationBar(
              elevation: 0,
              currentIndex: controller.currentIndex.value,
              onTap: controller.changePage,
              items: const [
                BottomNavigationBarItem(
                  // backgroundColor: Colors.white,
                  label: '',
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
                  //backgroundColor: Colors.white,
                  label: '',
                  icon: ItemNavigationButton(
                    fileIcon: 'assets/images/comentario.png',
                    title: 'Chats',
                    //messageCount: 50,
                  ),
                  activeIcon: ItemNavigationButton(
                    fileIcon: 'assets/images/comentario.png',
                    title: 'Chats',
                    isActive: true,
                    //messageCount: 50,
                  ),
                ),
                BottomNavigationBarItem(
                 // backgroundColor: Colors.white,
                  label: '',
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
                  //backgroundColor: Colors.white,
                  label: '',
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
                 // backgroundColor: Colors.white,
                  label: '',
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
            )),
        body: Obx(() => IndexedStack(
              index: controller.currentIndex.value,
              children: [
                HomeStudentScreen(),
                Chats(),
                const StudentPage(),
                const PaymentsScreen(),
                ProfileUserScreen(),
                
              ],
            )),
        extendBody: true,
      ),
    );
  }
}
