import 'package:get/get.dart';
import 'package:vtschool/src/providers/subject_provider.dart';

class SubjectsTeacherController extends GetxController {
  final SubjectProvider _subjectProvider = SubjectProvider();
  var isLoading = true.obs;
  var subject = <Map<String, dynamic>>[].obs;

  Future<void> getSubject(String idWorkingDay,
    String idSubject,
    String idProgram,
    String startTime,
    String endTime,
    int idSchedule) async {
    try {
      await _subjectProvider.getSubject(idWorkingDay, idSubject, idProgram, startTime, endTime, idSchedule);
      subject.assignAll(_subjectProvider.subject);
    } finally {
    }
  }

  ///¿relog
  var timeElapsed = 0.obs; 
  var totalTime = 20; 

  @override
  void onInit() {
    super.onInit();
    //startTimer();
  }

  void startTimer() {
    // Incrementa el tiempo cada segundo
    Future.delayed(Duration(seconds: 1), () {
      if (timeElapsed.value < totalTime) {
        timeElapsed.value++;
        startTimer(); // Llama recursivamente hasta que el tiempo termine
      }
    });
  }

 double get progress => timeElapsed.value / totalTime;


}