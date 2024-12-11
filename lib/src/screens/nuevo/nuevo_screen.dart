import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vtschool/src/screens/nuevo/nuevo_controller.dart';

class CoursePage extends StatelessWidget {
  final CourseController controller = Get.put(CourseController());

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
                        value: controller.selectedCourseId.value.isNotEmpty
                            ? controller.selectedCourseId.value
                            : null,
                        hint: const Text(
                          'Seleccionar Curso',
                          style: TextStyle(fontSize: 16, color: Colors.grey),
                        ),
                        isExpanded: true,
                        items: controller.allCourses.map((course) {
                          return DropdownMenuItem<String>(
                            value: course['id'] as String,
                            child: Text(
                              course['name'] as String,
                              style: const TextStyle(fontSize: 14),
                            ),
                          );
                        }).toList(),
                        onChanged: (value) {
                          if (value != null) {
                            controller.filterCourses(value);
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
              if (controller.courses.isEmpty) {
                return const Text('No hay información para mostrar');
              }
              final course = controller.courses.first;

              return Expanded(
                child: ListView(
                  padding: const EdgeInsets.all(
                      16), // Espaciado externo para todo el ListView
                  children: [
                    _buildInfoContainer(
                      title: 'Información General',
                      content: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Líder: ${course['leader']}'),
                          Text('Estudiantes: ${course['students']}'),
                          Text('Programa: ${course['program']}'),
                        ],
                      ),
                      onTap: () {
                        // Acción al tocar el contenedor
                        print('Información General tocada');
                      },
                    ),
                    _buildInfoContainer(
                      title: 'Horario',
                      content: Text(course['schedule']),
                      onTap: () {
                        print('Horario tocado');
                      },
                    ),
                    _buildInfoContainer(
                      title: 'Estadísticas',
                      content: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Completado: ${course['stats']['completed']}%'),
                          Text('En progreso: ${course['stats']['progress']}%'),
                        ],
                      ),
                      onTap: () {
                        print('Estadísticas tocadas');
                      },
                    ),
                    _buildInfoContainer(
                      title: 'Asistencia',
                      content: Text(course['attendance']),
                      onTap: () {
                        print('Asistencia tocada');
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
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap, // Detecta el toque en el contenedor
      child: Container(
        margin:
            const EdgeInsets.only(bottom: 16), // Espaciado entre contenedores
        padding: const EdgeInsets.all(16), // Espaciado interno
        decoration: BoxDecoration(
          color: Colors.white,
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
