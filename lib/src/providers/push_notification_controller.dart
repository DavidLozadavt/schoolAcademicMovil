import 'package:get/get.dart';

class PushNotificationController extends GetxController {
  var notificationCount = 0.obs;


  void incrementNotificationCount() {
    notificationCount.value++;
  }

  void clearNotificationCount() {
    notificationCount.value = 0;
  }
}