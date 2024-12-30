import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:vtschool/src/providers/calendar_provider.dart';

class CalendarController1 extends GetxController {
  final CalendarProvider _calendarProvider = CalendarProvider();
  var isLoading = true.obs;
  var events = <Map<String, dynamic>>[].obs;
  var filteredEvents = <Map<String, dynamic>>[].obs;

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
    String? idContrato = pref.getString('idContrato');

    try {
      if (rolUser == 'DOCENTE') {
        await _calendarProvider.fetchEventsTeacher(idContrato);
      } else if (rolUser == 'ESTUDIANTE' ||
          rolUser == 'ACUDIENTE' ||
          rolUser == 'APRENDIZ') {
        //  print('aqio $rolUser ------ $idUser');
        await _calendarProvider.fetchEventsStudent(idUser);
      } else if (rolUser == 'ADMIN') {
        await _calendarProvider.fetchEventsTeacher(idUser);
      }
      events.assignAll(_calendarProvider.events);
      filteredEvents.assignAll(events);
    } catch (error) {
      //('Error fetching events: $error');
    } finally {
      isLoading(false);
    }
  }

  void filterEvents(String query) {
    if (query.isEmpty) {
      filteredEvents.assignAll(events);
    } else {
      filteredEvents.assignAll(events.where((event) {
        final String nameSubject = event["materia"]["materia"]["nombreMateria"]
            .toString()
            .toLowerCase();
        final String workingDay = event["asignacionPeriodoProgramaJornada"]
                ["jornada"]["nombreJornada"]
            .toString()
            .toLowerCase();
        final String program = event["materia"]["grado"]["programa"]
                ["nombrePrograma"]
            .toString()
            .toLowerCase();
        return nameSubject.contains(query.toLowerCase()) ||
            workingDay.contains(query.toLowerCase()) ||
            program.contains(query.toLowerCase());
      }));
    }
  }
}
  