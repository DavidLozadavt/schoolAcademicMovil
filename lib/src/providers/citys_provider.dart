import 'package:get/get.dart';
import 'package:vtschool/src/api/constant.dart';

class CitysProvider extends GetConnect {
  Future<List<dynamic>> getDepartamentos() async {
    final response = await get(getCitysUrl);
    if (response.status.hasError) {
      return Future.error(response.statusText ?? 'Error desconocido');
    } else {
      return response.body;
    }
  }
  

  Future<List<dynamic>> getMunicipios(String departamentoId) async {
    final response = await get(
      getDepartament
    );
    if (response.status.hasError) {
      return Future.error(response.statusText ?? 'Error desconocido');
    } else {
      return response.body;
    }
  }

}
