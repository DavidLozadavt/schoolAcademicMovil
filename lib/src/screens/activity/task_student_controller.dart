import 'dart:io';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:vtschool/src/errors/failure.dart';
import 'package:vtschool/src/providers/activity_provider.dart';
import 'package:vtschool/src/providers/notifications_provider.dart';

class TaskStudentController extends GetxController {
  final NotificationsProvider _notificationsProvider = NotificationsProvider();
  final ActivityProvider _activityProvider = ActivityProvider();
  TextEditingController commentController = TextEditingController();

  var isLoading = true.obs;
  var activities = <Map<String, dynamic>>[].obs;
  var filteredActivities = <Map<String, dynamic>>[].obs;
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
    getNotifications();
  }

  Future<void> getNotifications() async {
    
    try {
      await _notificationsProvider.getNotifications();
      activities.assignAll(_notificationsProvider.activities);
      filteredActivities.assignAll(activities);
      isLoading(true);
    } finally {
      isLoading(false);
    }
  }

  Future<void> getActivityById(String id) async {
    try {
      await _activityProvider.getActivityById(id);
      activitiesById.assignAll(_activityProvider.activitiesById);
    } finally {}
  }

  Future<void> getTypeActivity(String id) async {
    try {
      final typeActivityData = await _activityProvider.getTypeActivity(id);
      typeActivitiesById(typeActivityData);
    } finally {}
  }

  Future<void> getActivityQuestionnaire(String id) async {
    try {
      final questionnaireActivity =
          await _activityProvider.getActivityQuestionnaire(id);
      activityQuestionnaire(questionnaireActivity);
    } finally {}
  }

  /*Future<void> replyActivity(String id, String? comment, File? file) async {
    try {
      await _activityProvider.replyActivity(id, comment, file);
    } catch (e) {
      print('Error al enviar la evidencia: $e');
    }
  }*/

  replyActivityP(String id) async {
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
      //print('4444444444444 $answerRating');
      await Get.bottomSheet(
        alert!,
        isScrollControlled: true,
        backgroundColor: Colors.transparent,
      );
    } catch (e) {
      //print('Error al enviar la evidencia: $e');
      debugPrint('Error al enviar la evidencia: $e');
    }
  }

  Future<void> replyQuestionnaire1(String idQualification, Widget alert) async {
    try {
      await _activityProvider.replyQuestionnaire1(
          idQualification, valuesInputQuestionnaire);

      await Get.bottomSheet(
        alert,
        isScrollControlled: true,
        backgroundColor: Colors.transparent,
      );
    } catch (e) {
      //print('Error al enviar la evidencia: $e');
    }
  }

  void filterActivities(String query) {
    if (query.isEmpty) {
      filteredActivities.assignAll(activities);
    } else {
      filteredActivities.assignAll(activities.where((activity) {
        if(activity['metadataInfo'] != null){
        Map<String, dynamic> decodedData = jsonDecode(activity['metadataInfo']);
        final String affair = activity['asunto'].toString().toLowerCase();
        final String id = activity['id'].toString().toLowerCase();
        final String nameTeacher =
            activity['personaRemitente']['nombre1'].toString().toLowerCase();
        final String lastNameTeacher =
            activity['personaRemitente']['apellido1'].toString().toLowerCase();
        final String subject =
            decodedData['nombreMateria'].toString().toLowerCase();
        return affair.contains(query.toLowerCase()) ||
            id.contains(query.toLowerCase()) ||
            nameTeacher.contains(query.toLowerCase()) ||
            lastNameTeacher.contains(query.toLowerCase()) ||
            subject.contains(query.toLowerCase());
        }else{
          return false;
        }    
      }));
    }
  }

  void setSelectedFilePath(String path) {
    selectedFilePath.value = path;
  }

  void setFilePath(File path) {
    filePath.value = path;
  }

  void saveAnswers(
      int idQuestion, String idAnswer, String description, int idTypeQuestion,
      {bool? value}) {
    var existingIndex = selectedAnswer
        .indexWhere((answer) => answer['idPregunta'] == idQuestion);
    if (idTypeQuestion == 3) {
      if (existingIndex != -1) {
        selectedAnswer[existingIndex] = {
          'idPregunta': idQuestion,
          'respuesta': idAnswer,
          'respuestas': description,
        };
      } else {
        selectedAnswer.add({
          'idPregunta': idQuestion,
          'respuesta': idAnswer,
          'respuestas': description,
        });
      }
    } else {
      if (value == true) {
        selectedAnswer.add({
          'idPregunta': idQuestion,
          'respuesta': idAnswer,
          'respuestas': description,
        });
      } else {
        selectedAnswer.removeAt(existingIndex);
      }
    }
  }

  void reiniciarRespuestas() {
    selectedAnswer.clear();
    valuesInputQuestionnaire.clear();
  }

  void addValue(String value, String idQuestion) {
    var existingIndex = valuesInputQuestionnaire
        .indexWhere((answers) => answers['idPregunta'] == idQuestion);
    if (existingIndex != -1) {
      valuesInputQuestionnaire[existingIndex] = {
        'idPregunta': idQuestion,
        'respuesta': value
      };
    } else {
      valuesInputQuestionnaire
          .add({'idPregunta': idQuestion, 'respuesta': value});
    }
  }

  void toggleSelectedOption(int index) {
    if (selectedOptions.contains(index)) {
      selectedOptions.remove(index);
    } else {
      selectedOptions.add(index);
    }
  }
}
