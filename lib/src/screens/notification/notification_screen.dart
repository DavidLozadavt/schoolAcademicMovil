import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:vtschool/src/config/theme/app_theme.dart';
import 'package:vtschool/src/screens/notification/notification_controller.dart';
import 'package:vtschool/src/widgets/card_notifications.dart';

class NotificationScreen extends StatelessWidget {
  final NotificationsController _notificationsController =
      Get.put(NotificationsController());

  NotificationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(() {
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
              Container(
                margin: const EdgeInsets.only(top: 40),
                height: 80,
                child: Row(
                  children: [
                    IconButton(
                      icon: Icon(
                        Icons.arrow_back,
                        color: listColor[10],
                      ),
                      onPressed: () {
                        Get.back();
                      },
                    ),
                    Text(
                      'Notificaciones',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: listColor[10],
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: ListView.builder(
                  itemCount: _notificationsController.activities.length,
                  itemBuilder: ((context, index) {
                    return Dismissible(
                      key: Key(_notificationsController.activities[index]['id']
                          .toString()),
                      direction: DismissDirection.endToStart,
                      confirmDismiss: (direction) async {
                        if (direction == DismissDirection.endToStart) {
                          return await showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                title: const Text("Confirmación"),
                                content: const Text(
                                    "¿Está seguro que deseas eliminar esta notificación?"),
                                actions: <Widget>[
                                  TextButton(
                                    onPressed: () => Get.back(),
                                    child: const Text("Cancelar"),
                                  ),
                                  TextButton(
                                    onPressed: () {
                                      Get.back();
                                      _notificationsController.activities
                                          .removeAt(index);
                                    },
                                    child: const Text("Eliminar"),
                                  ),
                                ],
                              );
                            },
                          );
                        } else {
                          return false;
                        }
                      },
                      background: Container(
                        decoration: BoxDecoration(
                          color: const Color.fromARGB(255, 243, 57, 57),
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        alignment: Alignment.centerRight,
                        margin: const EdgeInsets.symmetric(
                            horizontal: 22.0, vertical: 3),
                        child: const Icon(Icons.delete_rounded),
                      ),
                      child: _notificationsController.activities[index]
                              ['estado']['estado'] == 'ACTIVO'
                          ? Center(
                              child: GestureDetector(
                                onTap: () {
                                  _notificationsController.readNotifications(
                                      '${_notificationsController.activities[index]['id']}');
                                },
                                child: CardNotifications(
                                  idActivity:
                                      '${_notificationsController.activities[index]['id']}',
                                  affair:
                                      '${_notificationsController.activities[index]['asunto']}',
                                  date:
                                      '${_notificationsController.activities[index]['fecha']}',
                                  hour:
                                      '${_notificationsController.activities[index]['hora']}',
                                  status:
                                      '${_notificationsController.activities[index]['estado']['estado']}',
                                ),
                              ),
                            )
                          : Center(
                              child: CardNotifications(
                                idActivity:
                                    '${_notificationsController.activities[index]['id']}',
                                affair:
                                    '${_notificationsController.activities[index]['asunto']}',
                                date:
                                    '${_notificationsController.activities[index]['fecha']}',
                                hour:
                                    '${_notificationsController.activities[index]['hora']}',
                                status:
                                    '${_notificationsController.activities[index]['estado']['estado']}',
                              ),
                            ),
                    );
                  }),
                ),
              ),
            ],
          ),
        ),
      );
    });
  }
}
