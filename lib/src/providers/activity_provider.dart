import 'package:get/get.dart';
import 'package:vtschool/src/api/constant.dart';

class ActivityProvider extends GetConnect {

  
  Future<void> respuestaCalificacion(int id, dynamic data) async {
    try {
      final response = await post('$replyActivityUrl$id', data);
      if (response.status.hasError) {
        throw Exception('Error al enviar la respuesta: ${response.statusText}');
      }
    } catch (e) {
      throw Exception('Error al enviar la respuesta: $e');
    }
  }

}
