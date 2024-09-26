import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vtschool/src/providers/push_notification_controller.dart';
import 'package:vtschool/src/screens/calendar/calendar_screen.dart';
import 'package:vtschool/src/screens/posts/histories_screen.dart';
import 'package:vtschool/src/screens/profile/profile_user_controller.dart';

class HomeTeacherScreen extends StatelessWidget {
  HomeTeacherScreen({super.key});
  final PushNotificationController _pushNotificationController =
      Get.put(PushNotificationController());
  final ProfileUserController _profileController =
      Get.put(ProfileUserController());
  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if (_profileController.isLoading.value) {
        return const Center(child: CircularProgressIndicator());
      } else {
        return Scaffold(
          body: Column(
            children: [
              const SizedBox(
                height: 15,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    padding: const EdgeInsets.all(20),
                    child: Row(
                      children: [
                        ClipOval(
                          child: Image.network(
                            '${_profileController.userProfile['persona']?['rutaFoto']}',
                            width: 60,
                            height: 60,
                            fit: BoxFit.cover,
                            errorBuilder: (context, error, stackTrace) {
                              return const Center(
                                child: CircularProgressIndicator(
                                  strokeWidth: 2.0,
                                ),
                              );
                            },
                          ),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              '¡Hola! ',
                              style: TextStyle(
                                color: Colors.black,
                                fontFamily: 'CM Sans Serif',
                                fontSize: 14.0,
                                //height: 1.5,
                              ),
                            ),
                            Text(
                              '${_profileController.userProfile['persona']?['nombre1']} ${_profileController.userProfile['persona']?['apellido1']}',
                              style: const TextStyle(
                                color: Colors.black,
                                fontFamily: 'CM Sans Serif',
                                fontSize: 20.0,
                                // height: 2,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 15),
                    child: IconButton(
                      icon: Stack(
                        children: [
                          const Icon(
                            Icons.notifications_none_outlined,
                            size: 28,
                            color: Colors.black,
                          ),
                          if (_pushNotificationController
                                  .notificationCount.value >
                              0)
                            Positioned(
                              right: 0,
                              child: CircleAvatar(
                                radius: 6,
                                backgroundColor: Colors.red,
                                child: Text(
                                  '${_pushNotificationController.notificationCount.value}',
                                  style: const TextStyle(
                                      color: Colors.white, fontSize: 10),
                                ),
                              ),
                            ),
                        ],
                      ),
                      onPressed: () {
                        Get.toNamed('/notification');
                        _pushNotificationController.clearNotificationCount();
                      },
                    ),
                  ),
                ],
              ),
              SingleChildScrollView(
                child: Column(
                  children: [
                    HistoriasWidget(),
                    const SizedBox(
                      height: 15,
                    ),
                    const Center(
                      child: Text(
                        '¡Tu semana al instante!',
                        style: TextStyle(
                          color: Colors.black,
                          fontFamily: 'CM Sans Serif',
                          fontSize: 20.0,
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Center(
                      child: SizedBox(
                        width: 375,
                        height: 390,
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(20),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.5),
                                spreadRadius: 2,
                                blurRadius: 5,
                                offset: const Offset(0, 3),
                              ),
                            ],
                          ),
                          padding: const EdgeInsets.all(18),
                          child: Calendar(),
                        ),
                      ),
                    ),
                   
                  ],
                ),
              ),
               
            ],
          ),
        );
      }
    });
  }
}
