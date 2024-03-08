import 'package:get/get.dart';

import 'package:vtschool/src/services/auth_service.dart';


class GlobalController extends GetxController {
  //final AuthService _userProvider = AuthService();

  Future<void> initialRoute() async {
    
    try {
       String token = await getToken();
      if (token == '') {
        Get.offAllNamed('/login');
      } else {
        Get.offAllNamed('/home');
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
