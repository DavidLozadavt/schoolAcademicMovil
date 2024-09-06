import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:path/path.dart' as path;

import 'package:vtschool/src/config/theme/app_theme.dart';
import 'package:vtschool/src/screens/activities_teacher/activities_teacher_controller.dart';

class CreateNewActivityScreen extends StatelessWidget {
  final ActivitiesTeacherController _activitiesTeacherController =
      Get.put(ActivitiesTeacherController());
  CreateNewActivityScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(bottom: 20.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                margin: const EdgeInsets.only(top: 10.0),
                height: 80,
                child: Row(
                  children: [
                    IconButton(
                      icon: const Icon(
                        Icons.arrow_back,
                        color: Colors.black,
                      ),
                      onPressed: () {
                         _activitiesTeacherController.selectedFilePath.value = '';
                         _activitiesTeacherController.filePath.value = File('');
                        Get.back();
                      },
                    ),
                    const Text(
                      'Crear nueva actividad',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 15,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: Column(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        color: listColor[10],
                        borderRadius: BorderRadius.circular(10.0),
                        boxShadow: [
                          BoxShadow(
                            color: listColor[13].withOpacity(0.5),
                            spreadRadius: 1,
                            blurRadius: 5,
                            offset: const Offset(0, 2),
                          ),
                        ],
                      ),
                      child: TextField(
                        // controller: _paymentsController.nameController,
                        textCapitalization: TextCapitalization.sentences,
                        onChanged: (value) {},
                        keyboardType: TextInputType.text,
                        maxLines: null,
                        maxLengthEnforcement: MaxLengthEnforcement.enforced,
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: listColor[10],
                          hintText: "Título actividad",
                          labelText: 'Título',
                          hintStyle: TextStyle(color: listColor[13]),
                          labelStyle:
                              TextStyle(color: listColor[13], fontSize: 16),
                          prefixIcon: Icon(
                            Icons.person_pin_circle_outlined,
                            color: listColor[13],
                          ),
                          border: OutlineInputBorder(
                            borderSide:
                                BorderSide(color: listColor[14], width: 5),
                            borderRadius: const BorderRadius.all(
                              Radius.circular(10.0),
                            ),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: listColor[13]),
                            borderRadius: const BorderRadius.all(
                              Radius.circular(10.0),
                            ),
                          ),
                          contentPadding: const EdgeInsets.symmetric(
                              vertical: 7.0, horizontal: 20),
                        ),
                        style: TextStyle(
                          color: listColor[13],
                        ),
                      ),
                    ),
                    const SizedBox(height: 25),
                    Container(
                      decoration: BoxDecoration(
                        color: listColor[10],
                        borderRadius: BorderRadius.circular(10.0),
                        boxShadow: [
                          BoxShadow(
                            color: listColor[13].withOpacity(0.5),
                            spreadRadius: 1,
                            blurRadius: 5,
                            offset: const Offset(0, 2),
                          ),
                        ],
                      ),
                      child: TextField(
                        // controller: _paymentsController.nameController,
                        textCapitalization: TextCapitalization.sentences,
                        onChanged: (value) {},
                        keyboardType: TextInputType.text,
                        maxLines: null,
                        maxLengthEnforcement: MaxLengthEnforcement.enforced,
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: listColor[10],
                          hintText: "Descripción de la actividad",
                          labelText: 'Descripción',
                          hintStyle: TextStyle(color: listColor[13]),
                          labelStyle:
                              TextStyle(color: listColor[13], fontSize: 16),
                          prefixIcon: Icon(
                            Icons.person_pin_circle_outlined,
                            color: listColor[13],
                          ),
                          border: OutlineInputBorder(
                            borderSide:
                                BorderSide(color: listColor[14], width: 5),
                            borderRadius: const BorderRadius.all(
                              Radius.circular(10.0),
                            ),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: listColor[13]),
                            borderRadius: const BorderRadius.all(
                              Radius.circular(10.0),
                            ),
                          ),
                          contentPadding: const EdgeInsets.symmetric(
                              vertical: 7.0, horizontal: 20),
                        ),
                        style: TextStyle(
                          color: listColor[13],
                        ),
                      ),
                    ),
                    const SizedBox(height: 25),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        ElevatedButton(
                          onPressed: () async {
                            FilePickerResult? result =
                                await FilePicker.platform.pickFiles();
                            if (result != null) {
                              File file = File(result.files.single.path!);
                              String filePath = result.files.single.path!;
                              _activitiesTeacherController
                                  .setSelectedFilePath(filePath);
                              _activitiesTeacherController.setFilePath(file);
                            }
                          },
                          child: const Text('Seleccionar archivo'),
                        ),
                        const SizedBox(width: 5),
                        Obx(() {
                          if (_activitiesTeacherController
                              .selectedFilePath.value.isNotEmpty) {
                            String fileName = path.basename(
                                _activitiesTeacherController
                                    .selectedFilePath.value);
                            return Flexible(
                              child: ElevatedButton(
                                onPressed: null,
                                child: Text(fileName),
                              ),
                            );
                          } else {
                            return const ElevatedButton(
                              onPressed: null,
                              child: Text('Archivo'),
                            );
                          }
                        }),
                      ],
                    ),
                    const SizedBox(height: 25),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.white,
                        disabledBackgroundColor: Colors.blue,
                      ),
                      onPressed: () {
                        //hacer aqui o cuando sea un 200 en el servicio en el controller 
                         _activitiesTeacherController.selectedFilePath.value = '';
                         _activitiesTeacherController.filePath.value = File('');
                      },
                      child: const Text('Guardar'),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    ));
  }
}
