import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vtschool/src/providers/push_notification_controller.dart';

import 'package:vtschool/src/screens/notification/notification_controller.dart';
import 'package:vtschool/src/widgets/card_notifications.dart';
import 'package:vtschool/src/widgets/cont_sup.dart';

class NotificationScreen extends StatelessWidget {
   final PushNotificationController _pushNotificationController =
      Get.put(PushNotificationController());
  final NotificationsController _notificationsController =
      Get.put(NotificationsController());

  NotificationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Container(
            margin: const EdgeInsets.only(top: 40),
            height: 80,
            child: Row(
              children: [
                IconButton(
                  icon: const Icon(
                    Icons.arrow_back,
                    color: Colors.black,
                  ),
                  onPressed: () {
                    Get.back();
                    _pushNotificationController.clearNotificationCount();
                  },
                ),
                const Text(
                  'Notificaciones',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
              ],
            ),
          ),
          Obx(
            () => _notificationsController.isLoading.value
                ? const Expanded(
                  child: Center(
                      child: CircularProgressIndicator(),
                    ),
                )
                : Expanded(
                    child: _notificationsController.activities.isEmpty
                        ? const Center(
                            child: Text(
                              'No tienes notificaciones',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                              ),
                            ),
                          )
                        : ListView.builder(
                            itemCount:
                                _notificationsController.activities.length,
                            itemBuilder: ((context, index) {
                              return Dismissible(
                                key: Key(_notificationsController
                                    .activities[index]['id']
                                    .toString()),
                                direction: DismissDirection.endToStart,
                                confirmDismiss: (direction) async {
                                  if (direction ==
                                      DismissDirection.endToStart) {
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
                                                _notificationsController
                                                    .activities
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
                                    color:
                                        const Color.fromARGB(255, 243, 57, 57),
                                    borderRadius: BorderRadius.circular(10.0),
                                  ),
                                  alignment: Alignment.centerRight,
                                  margin: const EdgeInsets.symmetric(
                                      horizontal: 22.0, vertical: 3),
                                  child: const Icon(Icons.delete_outlined),
                                ),
                                child: Center(
                                  child: GestureDetector(
                                    onTap: () {
                                      Map<String, dynamic> decodedData = jsonDecode(
                                    _notificationsController
                                                  .activities[index]
                                              ['metadataInfo']);
                                      if (decodedData['id'] !=
                                          null && _notificationsController
                                                  .activities[index]['idTipoNotificacion'] == 3 || _notificationsController
                                                  .activities[index]['idTipoNotificacion'] == 5) {
                                        showNotificationDetails(
                                            context,
                                            _notificationsController
                                                .activities[index]);
                                      } else {
                                        if (_notificationsController
                                                    .activities[index]['estado']
                                                ['estado'] ==
                                            'ACTIVO') {
                                          _notificationsController
                                              .readNotifications(
                                                  '${_notificationsController.activities[index]['id']}');
                                        }
                                      }
                                    },
                                    child: CardNotifications(
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
                                ),
                              );
                            }),
                          ),
                  ),
          ),
        ],
      ),
    );
  }

  void showNotificationDetails(
      BuildContext context, Map<String, dynamic> notificationData) {
    Get.bottomSheet(
      notificationDetailsModal(context, notificationData),
      isScrollControlled: true,
    );
  }

  Widget notificationDetailsModal(BuildContext context, notificationData) {
    Map<String, dynamic> decodedData =
        jsonDecode(notificationData['metadataInfo']);
    String subject = decodedData['nombreMateria'];
    String standardScore = decodedData['calificacionEstandart'] ?? '';
    String numericalRating = decodedData['calificacionNumerica'].toString();
    Color themeColor = Theme.of(context).dialogBackgroundColor;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 28.0),
      height: 400,
      decoration: BoxDecoration(
        color: themeColor,
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(32),
          topRight: Radius.circular(32),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const ContSup(),
          const Padding(
            padding: EdgeInsets.all(20.0),
            child: Text(
              'Detalle',
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
              textAlign: TextAlign.center,
            ),
          ),
          const SizedBox(height: 20),
          Table(
            columnWidths: {
              0: notificationData['idTipoNotificacion'] == 4
                  ? const FlexColumnWidth(1.5)
                  : const FlexColumnWidth(1),
              1: const FlexColumnWidth(3),
            },
            children: [
              _buildTableRow(
                  'Asunto:', '${notificationData['asunto']}', 18, 14),
              _buildTableRow('Fecha:', '${notificationData['fecha']}', 18, 14),
              _buildTableRow('Materia:', subject, 18, 14),
              if (notificationData['idTipoNotificacion'] == 4)
                _buildTableRow('Calificación:', standardScore, 18, 14),
              if (notificationData['idTipoNotificacion'] == 4)
                _buildTableRow('Nota:', numericalRating, 18, 14),
            ],
          ),
          Expanded(
            child: Align(
              alignment: Alignment.bottomCenter,
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    if (notificationData['idTipoNotificacion'] != 4)
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.white,
                          textStyle: const TextStyle(fontSize: 12),
                        ),
                        onPressed: () {
                          Get.back();
                          Get.toNamed('/task_student');
                        },
                        child: const Text(
                          'Ir a mis actividades',
                          style: TextStyle(color: Colors.blue),
                        ),
                      ),
                    if (notificationData['estado']['estado'] == 'ACTIVO')
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.white,
                          textStyle: const TextStyle(fontSize: 12),
                        ),
                        onPressed: () {
                          Get.back();
                          _notificationsController
                              .readNotifications('${notificationData['id']}');
                        },
                        child: const Text(
                          'Marcar como leído',
                          style: TextStyle(color: Colors.green),
                        ),
                      ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  TableRow _buildTableRow(String title, String content, double titleFontSize,
      double contentFontSize) {
    return TableRow(
      children: [
        Padding(
          padding: const EdgeInsets.only(right: 8.0),
          child: Text(
            title,
            style: TextStyle(
                fontSize: titleFontSize,
                color: Colors.black,
                fontWeight: FontWeight.bold),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 8.0, top: 3.5),
          child: Text(
            content,
            style: TextStyle(fontSize: contentFontSize, color: Colors.black),
          ),
        ),
      ],
    );
  }
}
