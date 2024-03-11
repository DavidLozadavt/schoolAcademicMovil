import 'package:get/get.dart';

class StartingController extends GetxController {
 @override
  void onReady() {
    super.onReady();
    Get.toNamed('/login');
  }
}
