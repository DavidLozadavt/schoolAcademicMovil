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
    int idSchedule,
    int idDegree) async {
    try {
      await _subjectProvider.getSubject(idWorkingDay, idSubject, idProgram, startTime, endTime, idSchedule, idDegree);
      subject.assignAll(_subjectProvider.subject);
    } finally {
    }
  }

  ///¿relog
  var timeElapsed = 0.obs; 
  var totalTime = 20; 


  void startTimer() {
    Future.delayed(const Duration(seconds: 1), () {
      if (timeElapsed.value < totalTime) {
        timeElapsed.value++;
        startTimer();
      }
    });
  }

 double get progress => timeElapsed.value / totalTime;

 //checbox
  var checkboxes = <bool>[].obs;

 void loadSubjects() async {
    if (subject.isNotEmpty && subject[0]['matriculas'] != null) {
      checkboxes.assignAll(List.filled(subject[0]['matriculas'].length, true));
    }
  }

  void toggleCheckbox(int index, bool value) {
    checkboxes[index] = value;
  }

}