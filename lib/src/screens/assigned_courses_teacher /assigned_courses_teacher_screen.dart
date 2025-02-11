import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vtschool/src/screens/assigned_courses_teacher%20/assigned_courses_teacher_controller.dart';

class AssignedCoursesTeacherScreen extends StatelessWidget {
  final AssignedCoursesTeacherController _assignedCoursesTeacherController =
      Get.put(AssignedCoursesTeacherController());

  AssignedCoursesTeacherScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(
          children: [
            const SizedBox(
              height: 25,
            ),
            const Text(
              'FICHAS ASIGNADAS',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            const SizedBox(
              height: 15,
            ),
            Obx(() => Center(
                  child: Container(
                    margin: const EdgeInsets.symmetric(
                        vertical: 8, horizontal: 18.0),
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.3),
                          blurRadius: 6,
                          offset: const Offset(0, 4),
                        ),
                      ],
                      border: Border.all(
                        color: Colors.blueAccent,
                        width: 1.5,
                      ),
                    ),
                    child: DropdownButtonHideUnderline(
                      child: DropdownButton<String>(
                        value: _assignedCoursesTeacherController
                                .selectedCourseId.value.isNotEmpty
                            ? _assignedCoursesTeacherController
                                .selectedCourseId.value
                            : null,
                        hint: const Text(
                          'Seleccionar Curso',
                          style: TextStyle(fontSize: 16, color: Colors.grey),
                        ),
                        isExpanded: true,
                        items: _assignedCoursesTeacherController.allCourses
                            .map((course) {
                          return DropdownMenuItem<String>(
                            value: course['id'].toString(),
                            child: Text(
                              course['codigo'] as String,
                              style: const TextStyle(fontSize: 14),
                            ),
                          );
                        }).toList(),
                        onChanged: (value) {
                          if (value != null) {
                            _assignedCoursesTeacherController
                                .filterCourses(value);
                          }
                        },
                        dropdownColor: Colors.white,
                        icon: const Icon(
                          Icons.arrow_drop_down,
                          color: Colors.blueAccent,
                          size: 24,
                        ),
                      ),
                    ),
                  ),
                )),
            Obx(() {
              if (_assignedCoursesTeacherController.curseById.isEmpty) {
                return const Center(
                    child: Text('No hay información para mostrar'));
              }
              final course = _assignedCoursesTeacherController.curseById;
              return Expanded(
                child: ListView(
                  padding: const EdgeInsets.all(16),
                  children: [
                    _buildInfoContainer(
                      //  backgroundImage: 'assets/images/fondo_chat.jpg',
                      title: 'Información General',
                      content: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              const Icon(Icons.person),
                              const SizedBox(width: 8),
                              Expanded(
                                child: SingleChildScrollView(
                                  scrollDirection: Axis.horizontal,
                                  child: Text(
                                      '${course['persona']['nombre1']} ${course['persona']['nombre2']} ${course['persona']['apellido1']} ${course['persona']['apellido2']}'),
                                ),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              const Icon(Icons.calendar_month_sharp),
                              const SizedBox(width: 8),
                              Expanded(
                                child: SingleChildScrollView(
                                    scrollDirection: Axis.horizontal,
                                    child: Text(
                                        '${course['jornada']['nombreJornada']}: ${course['jornada']['descripcion']}')),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              const Icon(Icons.class_outlined),
                              const SizedBox(width: 8),
                              Expanded(
                                child: SingleChildScrollView(
                                  scrollDirection: Axis.horizontal,
                                  child: Text('${course['programa']}'),
                                ),
                              )
                            ],
                          ),
                        ],
                      ),
                    ),
                    _buildInfoContainer(
                      backgroundImage: 'assets/images/calendar.png',
                      title: 'Horario',
                      content: Text(''),
                      onTap: () {
                        print('Horario tocado');
                      },
                    ),
                    _buildInfoContainer(
                      backgroundImage: 'assets/images/statistics.png',
                      title: 'Estadísticas',
                      content: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(''),
                          Text(''),
                        ],
                      ),
                      onTap: () async {
                        String id = _assignedCoursesTeacherController
                            .selectedCourseId.value;
                        await _assignedCoursesTeacherController.getSessions(id);
                        await _assignedCoursesTeacherController
                            .getAssistance(id);
                        await _assignedCoursesTeacherController
                            .getCompetences(id);
                        Get.toNamed('/statistics_by_course');
                        print('Estadísticas tocadas');
                      },
                    ),
                  ],
                ),
              );
            })
          ],
        ),
      ),
    );
  }

  Widget _buildInfoContainer({
    required String title,
    required Widget content,
    VoidCallback? onTap,
    String? backgroundImage, // Imagen de fondo opcional
  }) {
    return GestureDetector(
      onTap: onTap, // Detecta el toque en el contenedor
      child: Container(
        margin:
            const EdgeInsets.only(bottom: 16), // Espaciado entre contenedores
        padding: const EdgeInsets.all(16), // Espaciado interno
        decoration: BoxDecoration(
          color: backgroundImage == null
              ? Colors.white
              : null, // Color predeterminado si no hay
          image: backgroundImage != null
              ? DecorationImage(
                  image: AssetImage(backgroundImage), // Imagen de fondo
                  fit: BoxFit.cover, // Ajuste de la imagen
                )
              : null,
          borderRadius: BorderRadius.circular(12), // Bordes redondeados
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.2), // Sombra suave
              blurRadius: 6,
              offset: const Offset(0, 3), // Dirección de la sombra
            ),
          ],
          border: Border.all(
            color:
                Colors.blueAccent.withOpacity(0.8), // Borde con color destacado
            width: 1.5,
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.blueAccent, // Color del título
              ),
            ),
            const SizedBox(
                height: 8), // Separación entre el título y el contenido
            content,
          ],
        ),
      ),
    );
  }
}
