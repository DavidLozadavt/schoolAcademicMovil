import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vtschool/src/screens/activity_student/activities_student_screen.dart';

import 'package:vtschool/src/screens/chat/chats_screen.dart';
import 'package:vtschool/src/screens/home/home_controller.dart';
import 'package:vtschool/src/screens/home/home_student/home_student_screen.dart';
import 'package:vtschool/src/screens/payments/enrollments_person_screen.dart';
import 'package:vtschool/src/screens/posts/posts_screen.dart';
import 'package:vtschool/src/screens/profile/profile_user_screen.dart';
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
                    title: 'HOME',
                  ),
                  activeIcon: ItemNavigationButton(
                    fileIcon: 'assets/images/home.png',
                    title: 'HOME',
                    isActive: true,
                  ),
                ),
                BottomNavigationBarItem(
                  //backgroundColor: Colors.white,
                  label: '',
                  icon: ItemNavigationButton(
                    fileIcon: 'assets/images/comentario.png',
                    title: 'CHATS',
                    //messageCount: 50,
                  ),
                  activeIcon: ItemNavigationButton(
                    fileIcon: 'assets/images/comentario.png',
                    title: 'CHATS',
                    isActive: true,
                    //messageCount: 50,
                  ),
                ),
                 BottomNavigationBarItem(
                  // backgroundColor: Colors.white,
                   label: '',
                   icon: ItemNavigationButton(
                     fileIcon: 'assets/images/note.png',
                     title: 'ACTIVIDADES',
                   ),
                   activeIcon: ItemNavigationButton(
                     fileIcon: 'assets/images/note.png',
                     title: 'ACTIVIDADES',
                     isActive: true,
                   ),
                 ),
                 BottomNavigationBarItem(
                   //backgroundColor: Colors.white,
                   label: '',
                   icon: ItemNavigationButton(
                     fileIcon: 'assets/images/payment.png',
                     title: 'PAGOS',
                   ),
                   activeIcon: ItemNavigationButton(
                     fileIcon: 'assets/images/payment.png',
                     title: 'PAGOS',
                     isActive: true,
                   ),
                 ),
                 BottomNavigationBarItem(
                  //backgroundColor: listColor[11].withOpacity(0.5),
                  label: '',
                  icon: ItemNavigationButton(
                    fileIcon: 'assets/images/posts.png',
                    title: 'PUBLICACIONES',
                  ),
                  activeIcon: ItemNavigationButton(
                    fileIcon: 'assets/images/posts.png',
                    title: 'PUBLICACIONES',
                    isActive: true,
                  ),
                  
                ),
                BottomNavigationBarItem(
                 // backgroundColor: Colors.white,
                  label: '',
                  icon: ItemNavigationButton(
                    fileIcon: 'assets/images/profile.png',
                    title: 'PERFIL',
                  ),
                  activeIcon: ItemNavigationButton(
                    fileIcon: 'assets/images/profile.png',
                    title: 'PERFIL',
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
                ActivitiesStudentScreen(),
                EnrollmentsPersonScreen(),
                                 PostsScreen(),
                ProfileUserScreen(),
                
              ],
            )),
        extendBody: true,
         floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.amber[100],
          onPressed: () {
            Get.toNamed('/support');
          },
          tooltip: 'Support',
          child: const Icon(Icons.support_agent_rounded),
        ),
      ),
    );
  }
}
