import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:vtschool/src/errors/failure.dart';
import 'package:vtschool/src/providers/activity_provider.dart';
//import 'package:vtschool/src/providers/notifications_provider.dart';

class TaskStudentController extends GetxController {
  //final NotificationsProvider _notificationsProvider = NotificationsProvider();
  final ActivityProvider _activityProvider = ActivityProvider();
  TextEditingController commentController = TextEditingController();

  var isLoading = true.obs;

  var activities = <Map<String, dynamic>>[].obs;
  var activitiesStudent = <Map<String, dynamic>>[].obs;

  var filteredActivities = <Map<String, dynamic>>[].obs;
  var filteredActivitiesStudent = <Map<String, dynamic>>[].obs;

  var activitiesById = <Map<String, dynamic>>[].obs;
  var activityQuestionnaire = {}.obs;
  var typeActivitiesById = {}.obs;
  RxString selectedFilePath = ''.obs;
  Rx<File> filePath = Rx<File>(File(''));
  final List<dynamic> selectedAnswer = <dynamic>[].obs;
  var valuesInputQuestionnaire = [].obs;
  RxList<int> selectedOptions = RxList<int>([]);
  var answerRating = {}.obs;

  @override
  void onInit() {
    super.onInit();
    
    getActivitiesStudent();
  }

  Future<void> refreshItems() async {
    await Future.delayed(const Duration(seconds: 1));
    getActivitiesStudent();
  }

  Future<void> getActivitiesStudent() async {
    try {
      await _activityProvider.getActivitiesStudent();
      activitiesStudent.assignAll(_activityProvider.activitiesStudent);
      filteredActivitiesStudent.assignAll(activitiesStudent);
      isLoading(true);
    } finally {
      isLoading(false);
    }
  }


  replyActivity(String id) async {
    try {
      if (commentController.text.isEmpty && filePath.value.path.isEmpty) {
        Get.snackbar(
          '¡Error!',
          'Debes escribir una respuesta o subir un archivo',
        );
      } else {
        if (commentController.text.isNotEmpty &&
            filePath.value.path.isNotEmpty) {
          await _activityProvider.replyActivity(
              id, commentController.text, filePath.value);
          Get.back();
          Get.snackbar('¡OK!', 'Actividad contestada');
        } else if (filePath.value.path.isEmpty) {
          await _activityProvider.replyActivity(
              id, commentController.text, null);
          Get.back();
          Get.snackbar('¡OK!', 'Actividad contestada');
        } else if (commentController.text.isEmpty) {
          await _activityProvider.replyActivity(id, null, filePath.value);
          Get.back();
          Get.snackbar('¡OK!', 'Actividad contestada');
        }
      }
    } on Failure catch (e) {
      Get.snackbar(
        '¡Error!',
        '${e.message}!',
      );
    }
  }

  Future<void> replyQuestionnaire(String idQualification,
      {Widget? alert}) async {
    try {
      final response = await _activityProvider.replyQuestionnaire(
          idQualification, selectedAnswer);

      answerRating.value = response;
      await Get.bottomSheet(
        alert!,
        isScrollControlled: true,
        backgroundColor: Colors.transparent,
      );
    } catch (e) {
      //print('Error al enviar la evidencia: $e');
    }
  }

  void filterActivitiesStudent(String query) {
    if (query.isEmpty) {
      filteredActivitiesStudent.assignAll(activitiesStudent);
    } else {
      filteredActivitiesStudent.assignAll(activitiesStudent.where((activity) {
        final String affair =
            activity['actividad']['tituloActividad'].toString().toLowerCase();
        final String nameTeacher =
            activity['persona']['nombre1'].toString().toLowerCase();
        final String lastNameTeacher =
            activity['persona']['apellido1'].toString().toLowerCase();
        final String subject =
            activity['actividad']['autor'].toString().toLowerCase();
        return affair.contains(query.toLowerCase()) ||
            nameTeacher.contains(query.toLowerCase()) ||
            lastNameTeacher.contains(query.toLowerCase()) ||
            subject.contains(query.toLowerCase());
      }));
    }
  }

  void setSelectedFilePath(String path) {
    selectedFilePath.value = path;
  }

  void setFilePath(File path) {
    filePath.value = path;
  }

  void reiniciarRespuestas() {
    selectedAnswer.clear();
    valuesInputQuestionnaire.clear();
  }
  void saveAnswers(
      {int? idQuestion, String? idAnswer, String? description, int? idTypeQuestion,
      String? valueInput}) {
    var existingIndex = selectedAnswer
        .indexWhere((answer) => answer['idPregunta'] == idQuestion);
         
    if (idTypeQuestion == 3) {
      if (existingIndex != -1) {
        selectedAnswer[existingIndex] = {
          'idPregunta': idQuestion,
          'respuesta': idAnswer,
          'descripcionRespuesta': description,
        };
      } else {
        selectedAnswer.add({
          'idPregunta': idQuestion,
          'respuesta': idAnswer,
          'descripcionRespuesta': description,
        });
      }
    } else {
      if (existingIndex != -1) {
      selectedAnswer[existingIndex] = {
        'idPregunta': idQuestion,
        'respuesta': valueInput
      };
    } else {
      selectedAnswer
          .add({'idPregunta': idQuestion, 'respuesta': valueInput});
    }
    }
  }

}
