import 'package:flutter/material.dart';
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
                        color: Colors.blueGrey,
                        borderRadius: BorderRadius.circular(15),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.2),
                            spreadRadius: 2,
                            blurRadius: 5,
                            offset: const Offset(0, 3),
                          ),
                        ],
                      ),
                      child: ListTile(
                        title: Text(
                          activity.actividad.descripcionActividad,
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                        subtitle: Text(
                          activity.esGrupal
                              ? "Actividad Grupal"
                              : "Actividad Individual",
                          style: const TextStyle(color: Colors.grey),
                        ),
                        trailing: IconButton(
                          icon: const Icon(Icons.person_outline),
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
            children: const [
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
              // Line at the top
              Container(
                height: 5,
                width: 50,
                margin: const EdgeInsets.symmetric(vertical: 10),
                decoration: BoxDecoration(
                  color: Colors.grey[300],
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              // Title
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
                  height: 600, // Adjust the height here
                  child: ListView.builder(
                    padding: const EdgeInsets.all(15.0),
                    itemCount: _activitiesTeacherController
                        .activitiesRegistration.length,
                    itemBuilder: (context, index) {
                      var activity = _activitiesTeacherController
                          .activitiesRegistration[index];
                      var persona =
                          activity.matriculaAcademica!.matricula!.persona;

                      return Container(
                        margin: const EdgeInsets.only(bottom: 10),
                        decoration: BoxDecoration(
                          color: Colors.white,
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
                          leading: persona?.rutaFoto != null
                              ? Container(
                                  width: 60.0,
                                  height: 60.0,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    image: DecorationImage(
                                      image: NetworkImage(persona!.rutaFoto),
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                )
                              : Container(
                                  width: 80.0,
                                  height: 80.0,
                                  decoration: const BoxDecoration(
                                    shape: BoxShape.circle,
                                    image: DecorationImage(
                                      image: AssetImage(
                                          'assets/images/default_avatar.png'),
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
                                onPressed: () async{
                                  
                                  // _chatController.onConnectPressed(
                                  //                   '${student['matricula']!['idPersona']}');
                                  //               _chatController.getMessage(
                                  //                   '${student['matricula']!['idPersona']}');
                                  //               _chatController
                                  //                   .setSelectedUser(users);
                                  //               Get.toNamed('/chat');
                                },
                              ),
                              IconButton(
                                icon: Icon(Icons.edit, color: Colors.amber),
                                onPressed: () {},
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
}
