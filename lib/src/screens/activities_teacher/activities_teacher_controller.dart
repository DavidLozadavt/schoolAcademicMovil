import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:get/get.dart';
import 'package:vtschool/src/models/api_assigned_activities.dart';
import 'package:vtschool/src/models/api_response_activities_registrations_model.dart';
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
  RxList persons = [].obs;
  var activitiesRegistration = <Registrationsactivity>[].obs;
  var activities1 = <Actividad>[].obs;
  var assignedActivities = <AssignedActivities>[].obs;
  var filteredActivitiesAssigned =
      <AssignedActivities>[].obs; // RxList<AssignedActivities>

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
      assignedActivities.value =
          await _activityProvider.getActivitiesByTeacher(id);
      filteredActivitiesAssigned.value = assignedActivities;
    } catch (e) {
      Get.snackbar('Error', e.toString());
    } finally {
      isLoading(false);
    }
  }

  void filterActivitiesAssigned(String query) {
    if (query.isEmpty) {
      filteredActivitiesAssigned.value = assignedActivities;
    } else {
      final lowerCaseQuery = query.toLowerCase();
      filteredActivitiesAssigned.value = assignedActivities.where((activity) {
        final descripcion =
            activity.actividad.descripcionActividad.toLowerCase();
        final title = activity.actividad.tituloActividad.toLowerCase();
        final tipo = activity.esGrupal ? "grupal" : "individual";
        final grupo = activity.grupo?.nombreGrupo?.toLowerCase() ?? "";

        return descripcion.contains(lowerCaseQuery) ||
            tipo.contains(lowerCaseQuery) ||
            grupo.contains(lowerCaseQuery);
      }).toList();
    }
  }

  Future<void> fetchActivitiesRegistration(int activityId,
      {int? idGrupo}) async {
    isLoading(true);
    try {
      activitiesRegistration.value = await _activityProvider
          .fetchActivitiesRegistrations(activityId, groupId: idGrupo);
    } catch (e) {
      Get.snackbar("Error", "No se pudieron obtener las actividades: $e");
    } finally {
      isLoading(false);
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
}
