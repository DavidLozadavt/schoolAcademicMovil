import 'package:get/get.dart';

class ActivitiesTeacherController extends GetxController {
  var isLoading = true.obs;
  var filteredActivities = <Map<String, dynamic>>[].obs;
  var activities = <Map<String, dynamic>>[].obs;
  
  
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
}
