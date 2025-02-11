import 'package:get/get.dart';
import 'package:vtschool/src/api/constant.dart';

class CitiesProvider extends GetConnect {
  Future<List<dynamic>> getDepartments() async {
    final response = await get(getDepartament);
    if (response.status.hasError) {
      return Future.error(response.statusText ?? 'Error desconocido');
    } else {
      return response.body;
    }
  }

  Future<List<dynamic>> getCities(String departamentoId) async {
    final response = await get(
        '$getCitysUrl/$departamentoId'); // Asegúrate de usar la URL correcta
    if (response.status.hasError) {
      return Future.error(response.statusText ?? 'Error desconocido');
    } else {
      return response.body;
    }
  }
}
