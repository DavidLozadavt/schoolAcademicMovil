import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:vtschool/src/services/auth_service.dart';

class GlobalController extends GetxController {
  final AuthService authProvider = AuthService();
  Future<void> initialRoute() async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      bool isFirstTime = prefs.getBool('isFirstTime') ?? true;

      if (isFirstTime) {
        await prefs.setBool('isFirstTime', false);
        Get.offNamed('/starting');
      } else {
        String token = await authProvider.getToken();
        String rol_user = await authProvider.getRolUser();
        if (token == '') {
          Get.offAllNamed('/login');
        } else {
          if (rol_user == 'ADMIN') {
            Get.offAllNamed('/home_admin');
          } else if (rol_user == 'ESTUDIANTE') {
            Get.offAllNamed('/home_student');
          } else if (rol_user == 'DOCENTE') {
            Get.offAllNamed('/home_teacher');
          } else if (rol_user == '') {}
        }
      }
    } catch (e) {
      print('Error: $e');
      Get.offNamed('/starting');
    }
  }

  @override
  void onReady() {
    super.onReady();
    initialRoute();
  }
}
