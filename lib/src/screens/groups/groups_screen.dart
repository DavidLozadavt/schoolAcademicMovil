import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vtschool/src/screens/groups/groups_controller.dart';

class GroupsScreen   extends StatelessWidget {
  final GroupsController controller = Get.put(GroupsController());

  GroupsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Grupos"),
      ),
      body: Obx(() {
        if (controller.grupos.isEmpty) {
          return Center(
            child: Text("No hay grupos"),
          );
        }
        return ListView.builder(
          itemCount: controller.grupos.length,
          itemBuilder: (context, index) {
            var grupo = controller.grupos[index];
            return Card(
              child: ListTile(
                title: Text(grupo.nombre),
                subtitle: Text("Participantes: ${grupo.participantes}"),
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    IconButton(
                      icon: Icon(Icons.edit),
                      onPressed: () {
                        _mostrarDialogoActualizar(context, grupo.id, grupo.nombre, grupo.participantes);
                      },
                    ),
                    IconButton(
                      icon: Icon(Icons.delete),
                      onPressed: () {
                        controller.eliminarGrupo(grupo.id);
                      },
                    ),
                  ],
                ),
              ),
            );
          },
        );
      }),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          _mostrarDialogoCrear(context);
        },
      ),
    );
  }

  void _mostrarDialogoCrear(BuildContext context) {
    TextEditingController nombreController = TextEditingController();
    TextEditingController participantesController = TextEditingController();

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text("Crear grupo"),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: nombreController,
                decoration: InputDecoration(hintText: "Nombre del grupo"),
              ),
              TextField(
                controller: participantesController,
                decoration: InputDecoration(hintText: "Número de participantes"),
                keyboardType: TextInputType.number,
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Get.back();
              },
              child: Text("Cancelar"),
            ),
            TextButton(
              onPressed: () {
                if (nombreController.text.isNotEmpty &&
                    participantesController.text.isNotEmpty) {
                  int participantes = int.tryParse(participantesController.text) ?? 0;
                  controller.agregarGrupo(nombreController.text, participantes);
                }
                Get.back();
              },
              child: Text("Crear"),
            ),
          ],
        );
      },
    );
  }

  void _mostrarDialogoActualizar(BuildContext context, int id, String nombreActual, int participantesActuales) {
    TextEditingController nombreController = TextEditingController(text: nombreActual);
    TextEditingController participantesController = TextEditingController(text: participantesActuales.toString());

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text("Actualizar grupo"),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: nombreController,
                decoration: InputDecoration(hintText: "Nuevo nombre del grupo"),
              ),
              TextField(
                controller: participantesController,
                decoration: InputDecoration(hintText: "Número de participantes"),
                keyboardType: TextInputType.number,
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Get.back();
              },
              child: Text("Cancelar"),
            ),
            TextButton(
              onPressed: () {
                if (nombreController.text.isNotEmpty &&
                    participantesController.text.isNotEmpty) {
                  int nuevosParticipantes = int.tryParse(participantesController.text) ?? participantesActuales;
                  controller.actualizarGrupo(id, nombreController.text, nuevosParticipantes);
                }
                Get.back();
              },
              child: Text("Actualizar"),
            ),
          ],
        );
      },
    );
  }
}
