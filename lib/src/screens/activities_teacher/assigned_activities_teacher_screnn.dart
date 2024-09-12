import 'package:flutter/material.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';
import 'package:get/get.dart';
import 'package:vtschool/src/screens/activities_teacher/activities_teacher_controller.dart';

class AssignedActivitiesTeacherScreen extends StatelessWidget {
  final ActivitiesTeacherController _activitiesTeacherController =
      Get.put(ActivitiesTeacherController());
  final TextEditingController _searchController = TextEditingController();
  AssignedActivitiesTeacherScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Get.back(),
        ),
        title: const Text(
          'Actividades Asignadas',
          style: TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: Column(
          children: [
            // Barra de búsqueda minimalista
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
              decoration: BoxDecoration(
                color: Colors.grey[200],
                borderRadius: BorderRadius.circular(30),
              ),
              child: Row(
                children: [
                  const Icon(Icons.search, color: Colors.grey),
                  const SizedBox(width: 10),
                  Expanded(
                    child: TextField(
                      controller: _searchController,
                      onChanged: (value) {
                        _activitiesTeacherController.filterActivities(value);
                      },
                      decoration: const InputDecoration(
                        hintText: "Buscar actividades...",
                        hintStyle: TextStyle(color: Colors.grey),
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            // Lista de actividades
            Obx(() {
              if (_activitiesTeacherController.assignedActivities.isEmpty) {
                return const Center(
                  child: Text(
                    'No hay actividades',
                    style: TextStyle(fontSize: 18, color: Colors.grey),
                  ),
                );
              }
              return Expanded(
                child: ListView.builder(
                  itemCount:
                      _activitiesTeacherController.assignedActivities.length,
                  itemBuilder: (context, index) {
                    var activity =
                        _activitiesTeacherController.assignedActivities[index];
                    return Container(
                      margin: const EdgeInsets.only(bottom: 15),
                      padding: const EdgeInsets.all(15),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(15),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.3),
                            spreadRadius: 2,
                            blurRadius: 6,
                            offset: const Offset(0, 4),
                          ),
                        ],
                      ),
                      child: ListTile(
                        contentPadding: const EdgeInsets.symmetric(
                            vertical: 10, horizontal: 15),
                        title: Text(
                          activity.actividad.descripcionActividad,
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                        subtitle: Row(
                          children: [
                            Icon(
                              activity.esGrupal ? Icons.group : Icons.person,
                              color: activity.esGrupal
                                  ? Colors.blue
                                  : Colors.orange,
                            ),
                            const SizedBox(width: 5),
                            Text(
                              activity.esGrupal
                                  ? "Actividad Grupal"
                                  : "Actividad Individual",
                              style: const TextStyle(color: Colors.grey),
                            ),
                          ],
                        ),
                        trailing: IconButton(
                          icon: const Icon(Icons.person_outline,
                              color: Colors.blue),
                          onPressed: () {
                            _showUsersModal(
                                context,
                                activity
                                    .idActividad); // Pasa el ID de la actividad
                          },
                        ),
                      ),
                    );
                  },
                ),
              );
            }),
          ],
        ),
      ),
    );
  }

  void _showUsersModal(BuildContext context, int activityId) async {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return const AlertDialog(
          content: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              CircularProgressIndicator(),
              SizedBox(width: 20),
              Text('Cargando...'),
            ],
          ),
        );
      },
    );

    await _activitiesTeacherController.fetchActivitiesRegistration(activityId);

    Navigator.of(context).pop();

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (BuildContext context) {
        return Container(
          padding: const EdgeInsets.only(top: 20, bottom: 10),
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Barra decorativa en la parte superior, centrada
              Center(
                child: Container(
                  height: 5,
                  width: 50,
                  margin: const EdgeInsets.symmetric(vertical: 10),
                  decoration: BoxDecoration(
                    color: Colors.grey[300],
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
              // Título
              Container(
                padding:
                    const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                alignment: Alignment.center,
                child: const Text(
                  'Estudiantes Asignados',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Obx(() {
                if (_activitiesTeacherController.isLoading.value) {
                  return const Center(child: CircularProgressIndicator());
                }

                if (_activitiesTeacherController
                    .activitiesRegistration.isEmpty) {
                  return const Center(child: Text('No hay usuarios asignados'));
                }

                return SizedBox(
                  height: 600, // Ajusta la altura aquí
                  child: ListView.builder(
                    padding: const EdgeInsets.all(15.0),
                    itemCount: _activitiesTeacherController
                        .activitiesRegistration.length,
                    itemBuilder: (context, index) {
                      var activity = _activitiesTeacherController
                          .activitiesRegistration[index];
                      var persona =
                          activity.matriculaAcademica!.matricula!.persona;

                      // Define el color de fondo basado en el estado
                      Color backgroundColor;
                      if (activity.idEstado == 17) {
                        backgroundColor = Colors.green[100]!; // Verde claro
                      } else {
                        backgroundColor = Colors.white;
                      }

                      // Verifica si la ruta de la foto es nula o la URL predeterminada
                      bool isDefaultPhoto = persona?.rutaFoto == null ||
                          persona!.rutaFoto ==
                              'http://192.168.101.12:8001/default/user.svg';

                      return Container(
                        margin: const EdgeInsets.only(bottom: 10),
                        decoration: BoxDecoration(
                          color: backgroundColor,
                          borderRadius: BorderRadius.circular(10),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.1),
                              spreadRadius: 2,
                              blurRadius: 4,
                              offset: Offset(0, 2),
                            ),
                          ],
                        ),
                        child: ListTile(
                          contentPadding: const EdgeInsets.symmetric(
                              vertical: 10, horizontal: 15),
                          leading: isDefaultPhoto
                              ? Container(
                                  width: 60.0,
                                  height: 60.0,
                                  decoration: const BoxDecoration(
                                    shape: BoxShape.circle,
                                    image: DecorationImage(
                                      image: AssetImage(
                                          'assets/images/default_avatar.png'),
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                )
                              : Container(
                                  width: 60.0,
                                  height: 60.0,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    image: DecorationImage(
                                      image: NetworkImage(persona!.rutaFoto!),
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                          title:
                              Text('${persona!.nombre1} ${persona.apellido1}'),
                          subtitle: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(persona.identificacion ??
                                  'Sin identificación'),
                              if (activity.calificacionNumerica != null)
                                Text(
                                  'Calificación: ${activity.calificacionNumerica}',
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                            ],
                          ),
                          trailing: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              IconButton(
                                icon: Icon(Icons.message, color: Colors.blue),
                                onPressed: () {},
                              ),
                              IconButton(
                                icon:
                                    const Icon(Icons.edit, color: Colors.amber),
                                onPressed: () {
                                  _showViewFormModal(
                                    context,
                                    activity,
                                  ); // Muestra los datos de la actividad
                                },
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                );
              }),
            ],
          ),
        );
      },
    );
  }

  void _showViewFormModal(BuildContext context, var activity) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (BuildContext context) {
        return Padding(
          padding: EdgeInsets.only(
            bottom: MediaQuery.of(context).viewInsets.bottom,
          ),
          child: Container(
            padding: const EdgeInsets.all(20),
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: Container(
                    height: 5,
                    width: 50,
                    margin: const EdgeInsets.symmetric(vertical: 10),
                    decoration: BoxDecoration(
                      color: Colors.grey[300],
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
                // Título
                const Center(
                  child: Text(
                    'Detalles de la Actividad',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const SizedBox(height: 20),

                // Comentario del Docente

                // Comentario del Estudiante
                _buildFormField(
                  label: 'Comentario del Estudiante:',
                  initialValue: activity.comentarioEstudiante ?? '',
                  onChanged: (value) {},
                ),
                const SizedBox(height: 20),

                _buildFormField(
                  label: 'Comentario del Docente:',
                  initialValue: activity.comentarioDocente ?? '',
                  onChanged: (value) {},
                ),
                const SizedBox(height: 20),

                // Calificación Numérica
                _buildFormField(
                  label: 'Calificación Numérica:',
                  initialValue: activity.calificacionNumerica?.toString() ?? '',
                  onChanged: (value) {},
                ),
                const SizedBox(height: 20),

                const Text(
                  'Documento Respuesta:',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 5),
                activity.docRespuesta != null
                    ? Container(
                        height: 300,
                        child: PDFView(
                          filePath: activity.docRespuesta!.toString(),
                          enableSwipe: true,
                          swipeHorizontal: true,
                          autoSpacing: false,
                          pageFling: true,
                          pageSnap: true,
                        ),
                      )
                    : const Text('Sin documento adjunto'),
                const SizedBox(height: 20),

                // Botón de Guardar
                Align(
                  alignment: Alignment.centerRight,
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: const Text('Guardar'),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildFormField({
    required String label,
    required String initialValue,
    required ValueChanged<String> onChanged,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 5),
        TextFormField(
          initialValue: initialValue,
          onChanged: onChanged,
          decoration: InputDecoration(
            border: OutlineInputBorder(),
            contentPadding: const EdgeInsets.all(10),
          ),
        ),
      ],
    );
  }
}
