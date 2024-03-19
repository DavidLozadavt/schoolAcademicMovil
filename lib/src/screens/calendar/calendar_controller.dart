import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:vtschool/src/providers/calendar_provider.dart';

class CalendarController1 extends GetxController {
  final CalendarProvider _calendarService = CalendarProvider();
  var isLoading = true.obs;
  var events = <Map<String, dynamic>>[].obs;

  @override
  void onInit() {
    super.onInit();
    fetchEvents();
  }

  Future<void> fetchEvents() async {
    isLoading(true);
    SharedPreferences pref = await SharedPreferences.getInstance();
    String? rolUser = pref.getString('rolUser');
    String? idUser = pref.getString('idUser');
    
    try {
      if (rolUser == 'DOCENTE') {
        await _calendarService.fetchEventsTeacher(idUser);
      } else if (rolUser == 'ESTUDIANTE') {
        await _calendarService.fetchEventsStudent(idUser);
      }

      events.assignAll(_calendarService.events);
    } catch (error) {
      print('Error fetching events: $error');
    } finally {
      isLoading(false);
    }
  }
}
