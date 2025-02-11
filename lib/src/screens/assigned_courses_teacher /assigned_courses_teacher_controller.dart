import 'package:get/get.dart';
import 'package:vtschool/src/providers/courses_by_teacher_provider.dart';

class AssignedCoursesTeacherController extends GetxController {
  final CoursesByTeacherProvider _coursesByTeacherProvider =
      CoursesByTeacherProvider();
  var selectedCourseId = ''.obs;
  var allCourses = <Map<String, dynamic>>[].obs;
  var curseById = {}.obs;
  var isLoading = true.obs;
  var sessions = <Map<String, dynamic>>[].obs;
  var assistance = <Map<String, dynamic>>[].obs;
  var competences = <Map<String, dynamic>>[].obs;
  var rapsBySubject = <Map<String, dynamic>>[].obs;
  var rapsSession = <Map<String, dynamic>>[].obs;
  var selectedOption = Rx<String?>(null);
  var dataStatusByMatriculation = <Map<String, dynamic>>[].obs;
  @override
  void onInit() {
    super.onInit();
    getAllCourses();
  }

  Future<void> getAllCourses() async {
    try {
      await _coursesByTeacherProvider.getAllCourses();
      allCourses.assignAll(_coursesByTeacherProvider.allCourses);
      isLoading(true);
    } finally {
      isLoading(false);
    }
  }

  Future<void> getCourseById(String id) async {
    try {
      final curseData = await _coursesByTeacherProvider.getCourseById(id);
      curseById(curseData);
    } finally {}
  }

  Future<void> getSessions(String id) async {
    try {
      await _coursesByTeacherProvider.getSessions(id);
      sessions.assignAll(_coursesByTeacherProvider.sessions);
    } finally {}
  }

  Future<void> getAssistance(String id) async {
    try {
      await _coursesByTeacherProvider.getAssistance(id);
      assistance.assignAll(_coursesByTeacherProvider.assistance);
    } finally {}
  }

  Map<String, int> getAttendanceCounts() {
    int present = assistance.where((e) => e['asistio'] == 1).length;
    int absent = assistance.where((e) => e['asistio'] == 0).length;

    return {
      'Present': present,
      'Absent': absent,
    };
  }

  Future<void> getCompetences(String id) async {
    try {
      await _coursesByTeacherProvider.getCompetences(id);
      competences.assignAll(_coursesByTeacherProvider.competences);
    } finally {}
  }

  Future<void> getRapsBySubject(
      String idCourse, String idSubject, String idProgram) async {
    try {
      await _coursesByTeacherProvider.getRapsBySubject(
          idCourse, idSubject, idProgram);
      rapsBySubject.assignAll(_coursesByTeacherProvider.rapsBySubject);
    } finally {}
  }

  Future<void> getSessionRaps(String id) async {
    try {
      await _coursesByTeacherProvider.getSessionRaps(id);
      rapsSession.assignAll(_coursesByTeacherProvider.rapsSession);
    } finally {}
  }

  void filterCourses(String courseId) async {
    await getCourseById(courseId);
    selectedCourseId.value = courseId;
  }

  Future<void> getStatusByMatriculation(String id, String status) async {
  try {
    // Limpia la lista antes de obtener nuevos datos
    dataStatusByMatriculation.clear();

    // Llamada al proveedor para obtener los datos
    await _coursesByTeacherProvider.getStatusByMatriculation(id, status);

    // Asigna los nuevos datos a la lista observable
    if (_coursesByTeacherProvider.dataStatusByMatriculation.isNotEmpty) {
      dataStatusByMatriculation.assignAll(_coursesByTeacherProvider.dataStatusByMatriculation);
    }
  } catch (e) {
    print("Error al obtener el estado por matrícula: $e");
  }
}


  var listStatusByMatriculation = [
    'EN FORMACION',
    'RETIRO VOLUNTARIO',
    'POR EVALUAR',
    'TRASLADO',
    'APLAZADO',
    'APROBADO',
    'CURSADO',
  ].obs;
}
