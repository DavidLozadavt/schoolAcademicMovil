import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:vtschool/src/config/theme/app_theme.dart';
import 'package:vtschool/src/screens/notas/task_student_controller.dart';
import 'package:vtschool/src/widgets/card_task_student.dart';
import 'package:vtschool/src/widgets/custom_alert.dart';

class TaskStudentScreen extends StatelessWidget {
  final TaskStudentController _taskStudentController =
      Get.put(TaskStudentController());

  TaskStudentScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => _taskStudentController.isLoading.value
          ? const Center(
              child: CupertinoActivityIndicator(),
            )
          : Scaffold(
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
                    Text(
                      'Mis tareas',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: listColor[10],
                      ),
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    /* Container(
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
                ),*/
                    Expanded(
                      child: ListView.builder(
                        itemCount: _taskStudentController.activities.length,
                        itemBuilder: ((context, index) {
                          Map<String, dynamic> decodedData = jsonDecode(
                              _taskStudentController.activities[index]
                                  ['metadataInfo']);
                          int idActividad = decodedData['idActividad'];
                          String initialDate = decodedData['fechaInicial'];
                          String finalDate = decodedData['fechaFinal'];
                          DateTime dateToday = DateTime.now();
                          DateTime final_date = DateTime.parse(finalDate);
                          int comparacion = final_date.compareTo(dateToday);
                          return Center(
                            child: GestureDetector(
                              onTap: () {
                                if (comparacion > 0) {
                                } else {
                                  showDialogPay(context);
                                }
                              },
                              child: CardTaskStudent(
                                idActivity:
                                    '${_taskStudentController.activities[index]['id']}',
                                affair:
                                    '${_taskStudentController.activities[index]['asunto']}',
                                urlPhotoSender:
                                    '${_taskStudentController.activities[index]['personaRemitente']['rutaFoto']}',
                                nameOfsender:
                                    '${_taskStudentController.activities[index]['personaRemitente']['nombre1']} ${_taskStudentController.activities[index]['personaRemitente']['apellido1']}',
                                initialDate: initialDate,
                                finalDate: finalDate,
                              ),
                            ),
                          );
                        }),
                      ),
                    ),
                  ],
                ),
              ),
            ),
    );
  }

  void showDialogPay(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Alerta"),
          content: const Text("La fecha de la actividad ya paso"),
          actions: <Widget>[
            TextButton(
              onPressed: () => Get.back(),
              child: const Text("Salir"),
            ),
          ],
        );
      },
    );
  }
}
