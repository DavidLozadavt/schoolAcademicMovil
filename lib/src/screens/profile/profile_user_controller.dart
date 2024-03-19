import 'package:get/get.dart';
import 'package:vtschool/src/providers/auth_provider.dart';

class ProfileUserController extends GetxController {
  final AuthProvider authProvider = AuthProvider();
  
  var isLoading = true.obs;
  var userProfile = {}.obs; 

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
}