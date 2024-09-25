import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'dart:io';

import 'package:flutter_pdfview/flutter_pdfview.dart';
import 'package:vtschool/src/screens/activities_teacher/activities_teacher_controller.dart';
import 'package:vtschool/src/screens/subjects_teacher/subjects_teacher_controller.dart';

class CreateNewActivityScreen extends StatelessWidget {
  final ActivitiesTeacherController _createActivitiesController =
      Get.put(ActivitiesTeacherController());
  final SubjectsTeacherController _subjectsTeacherController =
      Get.put(SubjectsTeacherController());

  CreateNewActivityScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Banco De Actividad'),
        backgroundColor:  const Color(0xFFF5F5F5),
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
           
              const SizedBox(height: 20),
              _buildTextField(
                label: 'Título de la Actividad',
                onChanged: (value) {
                  _createActivitiesController.tituloActividad.value = value;
                },
              ),
              const SizedBox(height: 16),
              _buildTextField(
                label: 'Descripción de la Actividad',
                maxLines: 3,
                onChanged: (value) {
                  _createActivitiesController.descripcionActividad.value =
                      value;
                },
              ),
              const SizedBox(height: 16),
              Obx(
                () => _createActivitiesController.archivo.value != null
                    ? _buildFilePreview(
                        _createActivitiesController.archivo.value!)
                    : const Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          'No hay archivo seleccionado',
                          style: TextStyle(fontSize: 16, color: Colors.grey),
                        ),
                      ),
              ),
              const SizedBox(height: 16),
              _buildFileSelectionButton(),
              const SizedBox(height: 24),
              _buildActionButtons(context),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTextField({
    required String label,
    int maxLines = 1,
    required Function(String) onChanged,
  }) {
    return TextField(
      maxLines: maxLines,
      decoration: InputDecoration(
        labelText: label,
        labelStyle: const TextStyle(color: Colors.black),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12.0),
          borderSide: const BorderSide(color: Colors.blueAccent),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12.0),
          borderSide: const BorderSide(color: Colors.blueAccent),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12.0),
          borderSide: const BorderSide(color: Colors.grey),
        ),
      ),
      onChanged: onChanged,
    );
  }

 Widget _buildFileSelectionButton() {
  return GestureDetector(
    onTap: () {
      _createActivitiesController.seleccionarArchivo();
    },
    child: Container(
      decoration: BoxDecoration(
        color: Colors.blueGrey, 
        border: Border.all(
          color: Colors.blue,
          width: 0.5,
        ),
        borderRadius: BorderRadius.circular(12.0),
        // Usar un borde punteado
        shape: BoxShape.rectangle,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.2),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 100),
      child: const Column(
        children: [
          Icon(
            Icons.upload_file, 
            color: Colors.white, 
            size: 24,
          ),
          SizedBox(height: 8), 
          Text(
            'Seleccionar Archivo',
            style: TextStyle(
              fontSize: 16,
              color: Colors.white, // Color del texto
            ),
          ),
       
        ],
      ),
    ),
  );
}


  Widget _buildActionButtons(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: ElevatedButton(
            onPressed: () {
              if (_createActivitiesController.tituloActividad.value.isEmpty ||
                  _createActivitiesController.descripcionActividad.value.isEmpty) {
                Get.snackbar(
                    'Error', 'Por favor, completa todos los campos',
                    snackPosition: SnackPosition.TOP);
                return;
              }
              _createActivitiesController.createActivity(
                  '${_subjectsTeacherController.subject[0]['horario'][0]["materia"]["materia"]['id']}');
              },
            style: ElevatedButton.styleFrom(
              padding: const EdgeInsets.symmetric(vertical: 16),
            
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12.0),
              ),
            ),

            child: const Text('Crear Actividad'),
          ),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: ElevatedButton(
            onPressed: () {
              Get.back(); 
            },
            style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 16),
               
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12.0),
                )),
            child: const Text('Cancelar'),
          ),
        ),
      ],
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
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          ClipRRect(
            borderRadius: BorderRadius.circular(12.0),
            child: Image.file(
              file,
              height: 150,
              width: double.infinity,
              fit: BoxFit.cover,
            ),
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
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          ClipRRect(
            borderRadius: BorderRadius.circular(12.0),
            child: SizedBox(
              height: 300,
              child: PDFView(
                filePath: file.path,
              ),
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
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
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
