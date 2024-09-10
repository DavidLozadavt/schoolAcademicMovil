import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:get/get.dart';
import 'package:vtschool/src/models/api_assigned_activities.dart';
import 'package:vtschool/src/models/api_response_all_activities_model.dart';
import 'package:vtschool/src/providers/activity_provider.dart';
import 'package:vtschool/src/providers/auth_provider.dart';

class ActivitiesTeacherController extends GetxController {
  var isLoading = true.obs;
  var filteredActivities = <Map<String, dynamic>>[].obs;
  var activities = <Map<String, dynamic>>[].obs;
  final ActivityProvider _activityProvider = ActivityProvider();
  final AuthProvider authService = AuthProvider();
  var tituloActividad = ''.obs;
  var descripcionActividad = ''.obs;
  var archivo = Rxn<File>();

  // Future<void> getActivitiesById(String id) async {
  //   try {
  //     print('aaaaaaaaaaaa');
  //     await _activityProvider.getActivitiesById(id);
  //     activities.assignAll(_activityProvider.allActivitiesById);
  //       isLoading(true);
  //   } finally {
  //     isLoading(false);
  //   }
  // }

  var activities1 = <Actividad>[].obs;
  var assignedActivities = <AssignedActivities>[].obs;

  void getActivitiesById(String id) async {
    isLoading(true);
    try {
      activities1.value = await _activityProvider.getActivitiesById(id);
    } catch (e) {
      Get.snackbar('Error', e.toString());
    }
  }

  void getActivitiesByTeacher(String id) async {
      isLoading(true);
    try {
      assignedActivities.value = await _activityProvider.getActivitiesByTeacher(id);
    } catch (e) {
      Get.snackbar('Error', e.toString());
    }
    
  }

  void filterActivities(String query) {
    if (query.isEmpty) {
      filteredActivities.assignAll(activities);
    } else {
      filteredActivities.assignAll(activities.where((user) {
        final String name =
            user['matricula']!['persona']['nombre1'].toString().toLowerCase();
        final String lastName =
            user['matricula']!['persona']['apellido1'].toString().toLowerCase();
        final String email =
            user['matricula']!['persona']['email'].toString().toLowerCase();
        final String identifications = user['matricula']!['persona']
                ['identificacion']
            .toString()
            .toLowerCase();
        return name.contains(query.toLowerCase()) ||
            lastName.contains(query.toLowerCase()) ||
            email.contains(query.toLowerCase()) ||
            identifications.contains(query.toLowerCase());
      }));
    }
  }

  Future<void> createActivity(String id) async {
    try {
      await _activityProvider.createActivityProvider(
        id,
        tituloActividad.value,
        descripcionActividad.value,
        archivo.value,
      );
      Get.snackbar('Éxito', 'Actividad creada correctamente',
          snackPosition: SnackPosition.TOP);
      tituloActividad.value = '';
      descripcionActividad.value = '';
      archivo.value = null;
      Get.toNamed('/activities_teacher');
    } catch (e) {
      Get.snackbar('Error', e.toString(), snackPosition: SnackPosition.TOP);
    }
  }

  Future<void> seleccionarArchivo() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles();
    if (result != null && result.files.single.path != null) {
      archivo.value = File(result.files.single.path!);
    }
  }

  // RxString selectedFilePath = ''.obs;
  // Rx<File> filePath = Rx<File>(File(''));
  // void setSelectedFilePath(String path) {
  //   selectedFilePath.value = path;
  // }

  // void setFilePath(File path) {
  //   filePath.value = path;
  // }
}
