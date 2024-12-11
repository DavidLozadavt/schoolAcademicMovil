import 'package:get/get.dart';

class CourseController extends GetxController {
  var selectedCourseId = ''.obs;
  var courses = <Map<String, dynamic>>[].obs;

  // Datos simulados
  final allCourses = [
    {
      'id': '1',
      'name': 'Curso de Matemáticas',
      'program': 'Ciencias Básicas',
      'leader': 'Prof. Juan Pérez',
      'students': 30,
      'schedule': 'Lunes y Miércoles 10:00 AM - 12:00 PM',
      'stats': {'completed': 80, 'progress': 20},
      'attendance': '90%',
    },
    {
      'id': '2',
      'name': 'Curso de Física',
      'program': 'Ciencias Naturales',
      'leader': 'Prof. María Gómez',
      'students': 25,
      'schedule': 'Martes y Jueves 2:00 PM - 4:00 PM',
      'stats': {'completed': 70, 'progress': 30},
      'attendance': '85%',
    },
  ];

  @override
  void onInit() {
    super.onInit();
    courses.value = allCourses; // Inicializa con todos los cursos
  }

  void filterCourses(String courseId) {
    selectedCourseId.value = courseId;
    courses.value = allCourses.where((course) => course['id'] == courseId).toList();
  }
}
