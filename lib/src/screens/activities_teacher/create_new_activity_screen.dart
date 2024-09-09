
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:vtschool/src/screens/activities_teacher/activities_teacher_controller.dart';
import 'package:vtschool/src/screens/subjects_teacher/subjects_teacher_controller.dart';

class CreateNewActivityScreen extends StatelessWidget {
  final ActivitiesTeacherController _createActivitiescontroller =
      Get.put(ActivitiesTeacherController());
  final SubjectsTeacherController _subjectsTeacherController =
      Get.put(SubjectsTeacherController());
  CreateNewActivityScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Crear Actividad'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              TextField(
                decoration: const InputDecoration(
                  labelText: 'Título de la Actividad',
                  border: OutlineInputBorder(),
                ),
                onChanged: (value) {
                 _createActivitiescontroller.tituloActividad.value = value;
                },
              ),
              const SizedBox(height: 16),
              TextField(
                decoration: const InputDecoration(
                  labelText: 'Descripción de la Actividad',
                  border: OutlineInputBorder(),
                ),
                maxLines: 3,
                onChanged: (value) {
                 _createActivitiescontroller.descripcionActividad.value = value;
                },
              ),
              const SizedBox(height: 16),
              Obx(() => Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                     _createActivitiescontroller.archivo.value != null
                          ? 'Archivo seleccionado: ${_createActivitiescontroller.archivo.value!.path.split('/').last}'
                          : 'No hay archivo seleccionado',
                      style: const TextStyle(fontSize: 16),
                    ),
                  )),
              const SizedBox(height: 8),
              ElevatedButton.icon(
                onPressed: () {
                  _createActivitiescontroller.seleccionarArchivo();
                },
                icon: const Icon(Icons.attach_file),
                label: const Text('Seleccionar Archivo'),
              ),
              const SizedBox(height: 24),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    if (_createActivitiescontroller.tituloActividad.value.isEmpty ||
                        _createActivitiescontroller.descripcionActividad.value.isEmpty) {
                      Get.snackbar(
                          'Error', 'Por favor, completa todos los campos',
                          snackPosition: SnackPosition.TOP);
                      return;
                    }
                    _createActivitiescontroller.createActivity(
                        '${_subjectsTeacherController.subject[0]['horario'][0]["materia"]["materia"]['id']}');
                  },
                  child: const Text('Crear Actividad'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
