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
        String idStudentSelected = await authProvider.getIdStudentSelect();

        if (token == '') {
          Get.offAllNamed('/login');
        } else {
          if (rolUser == 'ADMIN') {
            Get.offAllNamed('/home_admin');
          } else if (rolUser == 'ESTUDIANTE' || rolUser == 'APRENDIZ') {
            Get.offAllNamed('/home_student');
          } else if (rolUser == 'DOCENTE') {
            Get.offAllNamed('/home_teacher');
          } else if (rolUser == 'ACUDIENTE') {
            if (idStudentSelected.isNotEmpty) {
              Get.offAllNamed('/home_guardian');
            } else if (idStudentSelected.isEmpty && rolUser.isNotEmpty) {
              Get.offAllNamed('/guardian_children');
            } else {
              Get.offAllNamed('/login');
            }
          } else {
            Get.offAllNamed('/login');
          }
        }
      }
    } catch (e) {  
      Get.offNamed('/starting');
    }
  }

  void startTokenExpirationTimer() async {
    final prefs = await SharedPreferences.getInstance();
    int tokenExpiresIn = await getIntValue() ?? 0;
    Future.delayed(Duration(minutes: tokenExpiresIn), () async {
      await prefs.remove('token');
    });
  }

  Future<int?> getIntValue() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getInt('tokenExpiresIn');
  }

  @override
  void onReady() {
    super.onReady();
    initialRoute();
    startTokenExpirationTimer();
  }
}
