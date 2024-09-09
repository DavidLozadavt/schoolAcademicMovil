import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';  

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
                  _createActivitiescontroller.descripcionActividad.value =
                      value;
                },
              ),
              const SizedBox(height: 16),
              Obx(
                () => _createActivitiescontroller.archivo.value != null
                    ? _buildFilePreview(
                        _createActivitiescontroller.archivo.value!)
                    : const Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          'No hay archivo seleccionado',
                          style: TextStyle(fontSize: 16),
                        ),
                      ),
              ),
              const SizedBox(height: 16),
              TextButton(
                onPressed: () {
                  _createActivitiescontroller.seleccionarArchivo();
                },
                style: TextButton.styleFrom(
                  padding: const EdgeInsets.symmetric(
                    vertical: 14,
                    horizontal: 24,
                  ),
                  backgroundColor: Colors.grey.shade200,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                ),
                child: const Text(
                  'Seleccionar Archivo',
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.black87,
                  ),
                ),
              ),
              const SizedBox(height: 24),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {
                        if (_createActivitiescontroller
                                .tituloActividad.value.isEmpty ||
                            _createActivitiescontroller
                                .descripcionActividad.value.isEmpty) {
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
                  const SizedBox(width: 16),
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {
                        Get.back(); // Acciones para cancelar la creación
                      },
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.redAccent),
                      child: const Text('Cancelar'),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildFilePreview(File file) {
    String fileExtension = file.path.split('.').last.toLowerCase();

    if (fileExtension == 'jpg' || fileExtension == 'jpeg' || fileExtension == 'png') {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Vista previa del archivo:',
            style: TextStyle(fontSize: 16),
          ),
          const SizedBox(height: 8),
          Image.file(
            file,
            height: 150,
            width: double.infinity,
            fit: BoxFit.cover,
          ),
          const SizedBox(height: 8),
        ],
      );
    } else if (fileExtension == 'pdf') {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Vista previa del archivo PDF:',
            style: TextStyle(fontSize: 16),
          ),
          const SizedBox(height: 8),
          Container(
            height: 300,
            child: PDFView(
              filePath: file.path,
            ),
          ),
        ],
      );
    } else {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Archivo seleccionado:',
            style: TextStyle(fontSize: 16),
          ),
          const SizedBox(height: 8),
          Text(
            file.path.split('/').last,
            style: const TextStyle(fontSize: 16),
          ),
        ],
      );
    }
  }
}
