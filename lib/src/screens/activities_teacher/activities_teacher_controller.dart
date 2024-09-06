import 'dart:io';

import 'package:get/get.dart';
import 'package:vtschool/src/models/api_response_all_activities_model.dart';
import 'package:vtschool/src/providers/activity_provider.dart';

class ActivitiesTeacherController extends GetxController {
  var isLoading = true.obs;
  var filteredActivities = <Map<String, dynamic>>[].obs;
  var activities = <Map<String, dynamic>>[].obs;
    final ActivityProvider _activityProvider = ActivityProvider();



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

  void getActivitiesById(String id) async {
    isLoading(true);
    try {
      activities1.value = await _activityProvider.getActivitiesById(id);
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

  ///crear actividad
  ///
  RxString selectedFilePath = ''.obs;
  Rx<File> filePath = Rx<File>(File(''));
    void setSelectedFilePath(String path) {
    selectedFilePath.value = path;
  }

  void setFilePath(File path) {
    filePath.value = path;
  }

}
