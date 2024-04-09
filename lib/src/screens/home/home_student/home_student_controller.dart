/*import 'package:get/get.dart';
import 'package:vtschool/src/providers/auth_provider.dart';

class HomeStudentController extends GetxController {
  final AuthProvider authProvider = AuthProvider();
  
  var isLoading = true.obs;
  var userProfile = {}.obs;
  
  var notificationCount = 0.obs;

  void incrementNotificationCount() {
    notificationCount.value++;
  }

  void clearNotificationCount() {
    notificationCount.value = 0;
  }


  @override
  void onInit() {
    super.onInit();
    fetchEvents();
  }


  Future<void> fetchEvents() async {
    isLoading(true);
    try {
      final userData = await authProvider.getProfile();
      userProfile(userData);
    } catch (error) {
       //Get.snackbar('Error!', 'Se ha producido un error');
    } finally {
      isLoading(false);
    }
  }

 void clearUserData() {
    userProfile.value = {};
    isLoading.value = false;
  }
}*/