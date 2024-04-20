import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vtschool/src/config/theme/app_theme.dart';
import 'package:vtschool/src/screens/chat/chats_screen.dart';
import 'package:vtschool/src/screens/home/home_admin/home_admin_screen.dart';
import 'package:vtschool/src/screens/home/home_controller.dart';
import 'package:vtschool/src/screens/profile/profile_user_screen.dart';
import 'package:vtschool/src/widgets/item_navigation_button.dart';

class HomeAdmin extends StatelessWidget {
  final HomeController controller = Get.put(HomeController());

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        bottomNavigationBar: Obx(() => BottomNavigationBar(
              currentIndex: controller.currentIndex.value,
              onTap: controller.changePage,
              items: [
                BottomNavigationBarItem(
                  backgroundColor: listColor[11].withOpacity(0.5),
                  label: '',
                  icon: const ItemNavigationButton(
                    fileIcon: 'assets/images/home.png',
                    title: 'Home',
                  ),
                  activeIcon: const ItemNavigationButton(
                    fileIcon: 'assets/images/home.png',
                    title: 'Home',
                    isActive: true,
                  ),
                ),
                BottomNavigationBarItem(
                   backgroundColor: listColor[11].withOpacity(0.5),
                  label: '',
                  icon: const ItemNavigationButton(
                    fileIcon: 'assets/images/comentario.png',
                    title: 'Chats',
                    messageCount: 50,
                  ),
                  activeIcon: const ItemNavigationButton(
                    fileIcon: 'assets/images/comentario.png',
                    title: 'Chats',
                    isActive: true,
                    messageCount: 50,
                  ),
                ),
                BottomNavigationBarItem(
                   backgroundColor: listColor[11].withOpacity(0.5),
                  label: '',
                  icon: const ItemNavigationButton(
                    fileIcon: 'assets/images/note.png',
                    title: 'Mis notas',
                  ),
                  activeIcon: const ItemNavigationButton(
                    fileIcon: 'assets/images/note.png',
                    title: 'Mis notas',
                    isActive: true,
                  ),
                ),
                BottomNavigationBarItem(
                   backgroundColor: listColor[11].withOpacity(0.5),
                  label: '',
                  icon: const ItemNavigationButton(
                    fileIcon: 'assets/images/payment.png',
                    title: 'Pagos',
                  ),
                  activeIcon: const ItemNavigationButton(
                    fileIcon: 'assets/images/payment.png',
                    title: 'Pagos',
                    isActive: true,
                  ),
                ),
                BottomNavigationBarItem(
                   backgroundColor: listColor[11].withOpacity(0.5),
                  label: '',
                  icon: const ItemNavigationButton(
                    fileIcon: 'assets/images/profile.png',
                    title: 'Profile',
                  ),
                  activeIcon: const ItemNavigationButton(
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
                const HomeAdminScreen(),
                Chats(),
                ProfileUserScreen(),
                ProfileUserScreen(),
                ProfileUserScreen(),
              ],
            )),
        extendBody: true,
      ),
    );
  }
}
