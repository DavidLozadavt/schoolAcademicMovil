import 'package:get/get.dart';
import 'package:vtschool/src/models/model.dart';

class GroupsController extends GetxController {
  var grupos = <Grupo>[].obs;

  void agregarGrupo(String nombre, int participantes) {
    int id = grupos.isNotEmpty ? grupos.last.id + 1 : 1;
    grupos.add(Grupo(id: id, nombre: nombre, participantes: participantes));
  }

  void actualizarGrupo(int id, String nuevoNombre, int nuevosParticipantes) {
    var index = grupos.indexWhere((grupo) => grupo.id == id);
    if (index != -1) {
      grupos[index] = Grupo(id: id, nombre: nuevoNombre, participantes: nuevosParticipantes);
    }
  }

  void eliminarGrupo(int id) {
    grupos.removeWhere((grupo) => grupo.id == id);
  }
}
