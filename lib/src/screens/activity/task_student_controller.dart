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
  var activityQuestionnaire = <Map<String, dynamic>>[].obs;
  var typeActivitiesById = {}.obs;
  RxString selectedFilePath = ''.obs;
  Rx<File> filePath = Rx<File>(File(''));

  @override
  void onInit() {
    super.onInit();
    getNotifications();
  }

  Future<void> getNotifications() async {
    isLoading(true);
    try {
      await _notificationsProvider.getNotifications();
      activities.assignAll(_notificationsProvider.activities);
      filteredActivities.assignAll(activities);
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
      await _activityProvider.getActivityQuestionnaire(id);
      activityQuestionnaire.assignAll(_activityProvider.questionnaireActivity);
    } finally {}
  }

  Future<void> replyActivity(String id, String? comentario, File? file) async {
    print('desde el controller: $filePath');
    try {
      await _activityProvider.replyActivity(id, comentario, file);
    } catch (e) {
      print('Error al enviar la evidencia: $e');
    }
  }

  replyActivityP(String id) async {
    try {
      if (commentController.text.isEmpty && filePath.value.path.isEmpty) {
        Get.snackbar(
          '¡Error!',
          'Debes escribir una respuesta o subir un archivo',
        );
        print('11111111111111111111111111111');
      } else {
        if (commentController.text.isNotEmpty &&
            filePath.value.path.isNotEmpty) {
          await _activityProvider.replyActivity(
              id, commentController.text, filePath.value);
          Get.back();
          Get.snackbar('¡OK!', 'Actividad contestada');
           print('222222222222222');
        } else if (filePath.value.path.isEmpty) {
          await _activityProvider.replyActivity(
              id, commentController.text, null);
          Get.back();
          Get.snackbar('¡OK!', 'Actividad contestada');
           print('3333333333333');
        } else if (commentController.text.isEmpty) {
          await _activityProvider.replyActivity(id, null, filePath.value);
          Get.back();
          Get.snackbar('¡OK!', 'Actividad contestada');
           print('444444444444444');
        }
      }
    } on Failure catch (e) {
      Get.snackbar(
        '¡Error!',
        '${e.message}!',
      );
    }
  }

  void filterActivities(String query) {
    if (query.isEmpty) {
      filteredActivities.assignAll(activities);
    } else {
      filteredActivities.assignAll(activities.where((activity) {
        Map<String, dynamic> decodedData = jsonDecode(activity['metadataInfo']);
        final String asunto = activity['asunto'].toString().toLowerCase();
        final String id = activity['id'].toString().toLowerCase();
        final String nameTeacher =
            activity['personaRemitente']['nombre1'].toString().toLowerCase();
        final String lastNameTeacher =
            activity['personaRemitente']['apellido1'].toString().toLowerCase();
        final String subject =
            decodedData['nombreMateria'].toString().toLowerCase();
        return asunto.contains(query.toLowerCase()) ||
            id.contains(query.toLowerCase()) ||
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
}
