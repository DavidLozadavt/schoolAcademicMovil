import 'package:get/get.dart';
import 'package:vtschool/src/api/constant.dart';
import 'package:vtschool/src/errors/failure.dart';
import 'package:vtschool/src/providers/auth_provider.dart';

class ChatProvider extends GetConnect{

  final AuthProvider authService = AuthProvider();
  var users = <Map<String, dynamic>>[].obs;

  Future<void> getUsersByUser() async {
    String token = await authService.getToken();
    Response response = await get(
      getUsersByUserUrl,
      headers: {
        'Authorization': 'Bearer $token',
        'accept': 'application/json',
      },
    );
    print('aa55555 ${response.body}');
    if (response.statusCode == 200) {
      if (response.body.isNotEmpty) {
        users.assignAll(response.body.cast<Map<String, dynamic>>());
      } else {
        throw Failure('La respuesta del servidor está vacía.');
      }
    } else {
      throw Failure('Error al cargar los eventos');
    }
  }

}