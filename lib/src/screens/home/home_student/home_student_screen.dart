// ignore_for_file: file_names
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

import 'package:vtschool/src/config/theme/app_theme.dart';
import 'package:vtschool/src/screens/calendar/calendar_screen3.dart';
import 'package:vtschool/src/screens/home/home_student/home_student_controller.dart';
import 'package:vtschool/src/widgets/custom_alert.dart';

class HomeStudentScreen extends StatelessWidget {
  HomeStudentScreen({super.key});

  final HomeStudentController controller = Get.put(HomeStudentController());

  void showDialogPay(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return CustomAlert(
          title: 'Hola!!!',
          subtitle: ' Recuerde que su pensión  esta vencida.',
          imagePath: 'assets/images/Warning.png',
          color: const Color.fromARGB(255, 245, 239, 218),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if (controller.isLoading.value) {
        return const Center(child: CupertinoActivityIndicator());
      } else {
        return Scaffold(
          body: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  listColor[14],
                  listColor[11],
                ],
              ),
            ),
            child: Column(
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
                              '${controller.userProfile['persona']?['rutaFoto']}',
                              width: 60,
                              height: 60,
                              fit: BoxFit.cover,
                              errorBuilder: (context, error, stackTrace) {
                                return Image.asset(
                                  'assets/images/scl2.jpg',
                                  width: 60,
                                  height: 60,
                                  fit: BoxFit.cover,
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
                              Text(
                                '¡Hola! ',
                                style: TextStyle(
                                  color: listColor[12],
                                  fontFamily: 'CM Sans Serif',
                                  fontSize: 14.0,
                                  //height: 1.5,
                                ),
                              ),
                              Text(
                                '${controller.userProfile['persona']?['nombre1']} ${controller.userProfile['persona']?['apellido1']}',
                                style: TextStyle(
                                  color: listColor[12],
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
                            Icon(
                              Icons.notifications_none_outlined,
                              size: 28,
                              color: listColor[12],
                            ),
                            if (controller.notificationCount.value > 0)
                              Positioned(
                                right: 0,
                                child: CircleAvatar(
                                  radius: 6,
                                  backgroundColor: Colors.red,
                                  child: Text(
                                    '${controller.notificationCount.value}',
                                    style: const TextStyle(
                                        color: Colors.white, fontSize: 10),
                                  ),
                                ),
                              ),
                          ],
                        ),
                        onPressed: () {
                          Get.toNamed('/notification');
                          controller.clearNotificationCount();
                        },
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 50,
                ),
                Center(
                  child: Text(
                    '¡Tu semana al instante!',
                    style: TextStyle(
                      color: listColor[12],
                      fontFamily: 'CM Sans Serif',
                      fontSize: 20.0,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Center(
                  child: SizedBox(
                    width: 375,
                    height: 400,
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
        );
      }
    });
  }
}
