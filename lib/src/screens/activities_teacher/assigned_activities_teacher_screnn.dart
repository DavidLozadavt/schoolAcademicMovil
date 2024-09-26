import 'package:flutter/material.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';
import 'package:get/get.dart';
import 'package:vtschool/src/screens/activities_teacher/activities_teacher_controller.dart';
import 'package:vtschool/src/widgets/build_form.dart';
import 'package:vtschool/src/widgets/custom_button.dart';

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
            Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 20,
              ),
              height: 55,
              decoration: BoxDecoration(
                color: Colors.grey[200],
                borderRadius: BorderRadius.circular(20),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: _searchController,
                      onChanged: (value) {
                        _activitiesTeacherController
                            .filterActivitiesAssigned(value);
                      },
                      decoration: const InputDecoration(
                        hintText: "Buscar actividades...",
                        hintStyle: TextStyle(color: Colors.grey),
                        border: InputBorder.none,
                        isDense: true,
                        contentPadding: EdgeInsets.symmetric(
                          vertical: 8,
                        ),
                      ),
                      style: const TextStyle(fontSize: 14),
                    ),
                  ),
                  const Icon(
                    Icons.search,
                    color: Colors.grey,
                    size: 28,
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            Obx(() {
              if (_activitiesTeacherController
                  .filteredActivitiesAssigned.isEmpty) {
                return const Center(
                  child: Text(
                    'No hay actividades',
                    style: TextStyle(fontSize: 18, color: Colors.grey),
                  ),
                );
              }
              return Expanded(
                child: ListView.builder(
                  itemCount: _activitiesTeacherController
                      .filteredActivitiesAssigned.length,
                  itemBuilder: (context, index) {
                    var activity = _activitiesTeacherController
                        .filteredActivitiesAssigned[index];
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
                          activity.actividad!.descripcionActividad as String,
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                        subtitle: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Icon(
                                  activity.esGrupal
                                      ? Icons.group
                                      : Icons.person,
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
                            if (activity.esGrupal &&
                                activity.grupo != null) ...[
                              const SizedBox(height: 5),
                              Text(
                                'Nombre Grupo: ${activity.grupo!.nombre}',
                                style: const TextStyle(color: Colors.grey),
                              ),
                            ],
                          ],
                        ),
                        trailing: IconButton(
                          icon: Image.asset(
                            'assets/images/trabajo-en-equipo.png',
                            width: 40,
                            height: 80,
                          ),
                          onPressed: () {
                            _showUsersModal(
                              context,
                              activityId: activity.idActividad,
                              groupId: activity.idGrupo,
                            );
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

  void _showUsersModal(BuildContext context,
      {required int activityId, int? groupId}) async {
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

    await _activitiesTeacherController.fetchActivitiesRegistration(activityId,
        idGrupo: groupId);

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
                  height: 600,
                  child: ListView.builder(
                    padding: const EdgeInsets.all(15.0),
                    itemCount: _activitiesTeacherController
                        .activitiesRegistration.length,
                    itemBuilder: (context, index) {
                      var activity = _activitiesTeacherController
                          .activitiesRegistration[index];
                      var persona =
                          activity.matriculaAcademica!.matricula!.persona;

                      Color backgroundColor;
                      if (activity.idEstado == 17) {
                        backgroundColor = Colors.green[100]!;
                      } else if (activity.idEstado == 9) {
                        backgroundColor = Colors.yellow[100]!;
                      } else {
                        backgroundColor = Colors.white;
                      }

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
                              offset: const Offset(0, 2),
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
                                      image: NetworkImage(persona.rutaFoto!),
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
                                icon: const Icon(Icons.message, color: Colors.blue),
                                onPressed: () {},
                              ),
                              IconButton(
                                icon:
                                    const Icon(Icons.edit, color: Colors.amber),
                                onPressed: () {
                                  if (activity.comentarioEstudiante != null &&
                                      activity
                                          .comentarioEstudiante!.isNotEmpty) {
                                    _showViewFormModal(context, activity);
                                  } else {
                                    // Mostrar un SnackBar usando GetX
                                    Get.snackbar(
                                      'Información',
                                      'El estudiante aún no ha respuesto la actividad.',
                                      snackPosition: SnackPosition.TOP,
                                      backgroundColor: const Color.fromARGB(
                                        255,
                                        255,
                                        226,
                                        82,
                                      ),
                                      colorText: Colors.white,
                                      duration: const Duration(seconds: 3),
                                    );
                                  }
                                },
                              )
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
    _activitiesTeacherController.comentarioDocente.value =
        activity.comentarioDocente ?? '';
    _activitiesTeacherController.calificacionNumerica.value =
        activity.calificacionNumerica?.toString() ?? '';

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
            child: SingleChildScrollView(
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

                  // Comentario del Estudiante
                  FormFieldWidget(
                    label: 'Comentario del Estudiante:',
                    initialValue: activity.comentarioEstudiante ?? '',
                    onChanged: (value) {},
                    isReadOnly: true,
                    maxLines: 5,
                    minLines: 1,
                    keyboardType: TextInputType.multiline,
                    textAlignVertical: TextAlignVertical.top,
                  ),

                  const SizedBox(height: 20),

                  const Text(
                    'Documento Respuesta:',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 5),

                  activity.docRespuesta != null &&
                          !activity.docRespuesta!.contains(
                            'http://192.168.101.12:8001/default/imagenpordefecto.png',
                          )
                      ? SizedBox(
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
                      : Container(
                          height: 300,
                          width: double.infinity, // Ajusta el ancho aquí
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            image: const DecorationImage(
                              image:
                                  AssetImage('assets/images/sin-contenido.png'),
                              // Ajusta el ajuste aquí
                            ),
                          ),
                        ),
                  const SizedBox(height: 20),

                  // Comentario del Docente
                  FormFieldWidget(
                    label: 'Comentario del Docente:',
                    initialValue:
                        _activitiesTeacherController.comentarioDocente.value,
                    onChanged: (value) {
                      _activitiesTeacherController.comentarioDocente.value =
                          value;
                    },
                    maxLines: 5,
                    minLines: 1,
                    keyboardType: TextInputType.multiline,
                    textAlignVertical: TextAlignVertical.top,
                  ),
                  const SizedBox(height: 20),

                  FormFieldWidget(
                    label: 'Calificación Numérica:',
                    initialValue:
                        _activitiesTeacherController.calificacionNumerica.value,
                    onChanged: (value) {
                      if (RegExp(r'^\d*\.?\d*$').hasMatch(value)) {
                        _activitiesTeacherController
                            .calificacionNumerica.value = value;
                      }
                    },
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'La calificación numérica es obligatoria';
                      }
                      return null;
                    },
                    keyboardType: TextInputType.number,
                    maxLines: 1,
                  ),

                  const SizedBox(height: 20),

                  Align(
                    alignment: Alignment.center,
                    child: CustomButton(
                      text: 'Calificar',
                      backgroundColor:
                          const Color.fromARGB(255, 234, 238, 240),
                      textColor: Colors.white,
                      onPressed: () {
                        _activitiesTeacherController.rateActivity(activity.id);
                        Navigator.of(context).pop();
                      },
                      icon: Icons.save,
                    ),
                  )
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
