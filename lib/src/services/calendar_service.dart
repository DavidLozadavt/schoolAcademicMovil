import 'package:get/get.dart';
import 'package:vtschool/src/api/constant.dart';
import 'package:vtschool/src/errors/failure.dart';
import 'package:vtschool/src/services/auth_service.dart';

class CalendarService extends GetConnect {
  final AuthService authService = AuthService();
  var events = <Map<String, dynamic>>[].obs;

  Future<void> fetchEvents() async {
    String token = await authService.getToken();

    Response response = await get(
      '$horarioMateriaURL',
      headers: {
        'Authorization': 'Bearer $token',
        'accept': 'application/json',
      },
    );

    if (response.statusCode == 200) {
      if (response.body.isNotEmpty) {
        events.assignAll(response.body.cast<Map<String, dynamic>>());
        print('aqui fue $events');
      } else {
        throw Failure('La respuesta del servidor está vacía.');
      }
    } else {
      throw Failure('Error al cargar los eventos');
    }
  }
}
