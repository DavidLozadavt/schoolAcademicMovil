import 'package:get/get.dart';
import 'package:vtschool/src/services/calendar_service.dart';

class CalendarController1 extends GetxController {
  final CalendarService _calendarService = CalendarService();
  var isLoading = true.obs;
  var events = <Map<String, dynamic>>[].obs;

  @override
  void onInit() {
    super.onInit();
    fetchEvents();
  }

  Future<void> fetchEvents() async {
    isLoading(true);
    try {
      await _calendarService.fetchEvents();
      events.assignAll(_calendarService.events);
      print('aaaaaaaaaaaaaaaaaaaaaaaaa $events');
    } catch (error) {
      print('Error fetching events: $error');
    } finally {
      isLoading(false);
    }
  }
}
