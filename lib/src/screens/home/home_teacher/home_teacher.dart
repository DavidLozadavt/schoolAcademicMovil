import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vtschool/src/screens/activities_teacher/activities_teacher_screen.dart';

import 'package:vtschool/src/screens/home/home_controller.dart';
import 'package:vtschool/src/screens/home/home_teacher/home_teacher_screen.dart';
import 'package:vtschool/src/screens/posts/posts_screen.dart';
import 'package:vtschool/src/screens/profile/profile_user_screen.dart';
import 'package:vtschool/src/screens/subjects_teacher/subjects_teacher_screen.dart';
import 'package:vtschool/src/widgets/item_navigation_button.dart';

class HomeTeacher extends StatelessWidget {
  HomeTeacher({super.key});
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
                  // backgroundColor: listColor[11].withOpacity(0.5),
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
                  //backgroundColor: listColor[11].withOpacity(0.5),
                  label: '',
                  icon: ItemNavigationButton(
                    fileIcon: 'assets/images/comentario.png',
                    title: 'Chats',
                  ),
                  activeIcon: ItemNavigationButton(
                    fileIcon: 'assets/images/comentario.png',
                    title: 'Chats',
                    isActive: true,
                  ),
                ),
                BottomNavigationBarItem(
                  //backgroundColor: listColor[11].withOpacity(0.5),
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
                  //backgroundColor: listColor[11].withOpacity(0.5),
                  label: '',
                  icon: ItemNavigationButton(
                    fileIcon: 'assets/images/posts.png',
                    title: 'Posts',
                  ),
                  activeIcon: ItemNavigationButton(
                    fileIcon: 'assets/images/posts.png',
                    title: 'Posts',
                    isActive: true,
                  ),
                  
                ),
                // BottomNavigationBarItem(
                //   backgroundColor: listColor[11].withOpacity(0.5),
                //   label: '',
                //   icon: const ItemNavigationButton(
                //     fileIcon: 'assets/images/payment.png',
                //     title: 'Pagos',
                //   ),
                //   activeIcon: const ItemNavigationButton(
                //     fileIcon: 'assets/images/payment.png',
                //     title: 'Pagos',
                //     isActive: true,
                //   ),
                // ),
                BottomNavigationBarItem(
                  //backgroundColor: listColor[11].withOpacity(0.5),
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
                HomeTeacherScreen(),
                ActivitiesTeacherScreen(),
                SubjectsTeacherScreen(),
                 PostsScreen(),
                ProfileUserScreen(),
             
              ],
            )),
        extendBody: true,
      ),
    );
  }
}
