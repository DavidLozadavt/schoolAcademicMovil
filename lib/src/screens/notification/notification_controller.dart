import 'package:get/get.dart';
import 'package:vtschool/src/providers/notifications_provider.dart';

class NotificationsController extends GetxController {
  final NotificationsProvider _notificationsProvider = NotificationsProvider();
  var isLoading = true.obs;
  var activities = <Map<String, dynamic>>[].obs;

  @override
  void onInit() {
    super.onInit();
    getNotifications();
  }
  
  Future<void> getNotifications() async {
    isLoading(true);
    try {
      await _notificationsProvider.getNotifications();
      activities.assignAll(_notificationsProvider.activities);
    } finally {
      isLoading(false);
    }
  }

  Future<void> readNotifications(String id) async {
    try {
      await _notificationsProvider.readNotifications(id);
      await getNotifications();
    } catch (error) {
      //print('Error fetching events: $error');
    } finally {
      isLoading(false);
    }
  }


}