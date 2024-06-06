import 'package:get/get.dart';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:vtschool/src/providers/auth_provider.dart';

class GlobalController extends GetxController {
  final AuthProvider authProvider = AuthProvider();
  Future<void> initialRoute() async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();

      bool isFirstTime = prefs.getBool('isFirstTime') ?? true;
      if (isFirstTime) {
        await prefs.setBool('isFirstTime', false);
        Get.offNamed('/starting');
      } else {
        String token = await authProvider.getToken();
        String rolUser = await authProvider.getRolUser();
        if (token == '') {
          Get.offAllNamed('/login');
        } else {
          if (rolUser == 'ADMIN') {
            Get.offAllNamed('/home_admin');
          } else if (rolUser == 'ESTUDIANTE') {
            Get.offAllNamed('/home_student');
          } else if (rolUser == 'DOCENTE') {
            Get.offAllNamed('/home_teacher');
          } else {
            Get.offAllNamed('/login');
          }
        }
      }
    } catch (e) {
      Get.offNamed('/starting');
    }
  }

  @override
  void onReady() {
    super.onReady();
    initialRoute();
  }
}
