import 'package:get/get.dart';
import 'package:vtschool/src/providers/auth_provider.dart';

class ProfileUserController extends GetxController {
  final AuthProvider authProvider = AuthProvider();
  var isLoading = true.obs;
  var userProfile = {}.obs;
  // var urlLogoCompany = ''.obs;

  @override
  void onInit() {
    super.onInit();
    fetchEvents();
    //urlPhotoCompany();
  }

  Future<void> fetchEvents() async {
    try {
      final userData = await authProvider.getProfile();
      userProfile(userData);
      isLoading(true);
    } finally {
      isLoading(false);
    }
  }

  void clearUserData() {
    userProfile.value = {};
    //isLoading.value = false;
  }

  // void urlPhotoCompany() async {
  //   final prefs = await SharedPreferences.getInstance();
  //   final url = prefs.getString('urlLogoCompany');
  //   if (url != null) {
  //     urlLogoCompany.value = url;
  //   }
  // }
}
