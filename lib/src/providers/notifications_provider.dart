import 'package:get/get.dart';

import 'package:vtschool/src/api/constant.dart';
import 'package:vtschool/src/errors/failure.dart';
import 'package:vtschool/src/providers/auth_provider.dart';


class NotificationsProvider extends GetConnect {
  final AuthProvider authProvider = AuthProvider();
  var activities = <Map<String, dynamic>>[].obs;
  
  Future<void> getNotifications() async {
    String token = await authProvider.getToken();

    Response response = await get(
      getNotificationsAllUrl,
      headers: {
        'Authorization': 'Bearer $token',
        'accept': 'application/json',
      },
    );
    print('20000000000000000 ${response.body}');
    if (response.statusCode == 200) {
      if (response.body.isNotEmpty) {
       activities.assignAll(response.body.cast<Map<String, dynamic>>());
      } else {
        throw Failure('La respuesta del servidor está vacía.');
      }
    } else {
      throw Failure('Error al cargar los eventos');
    }
  }

  Future<void> readNotifications(String id) async {
    String token = await authProvider.getToken();

    Response response = await put(
      '$putReadNotificationsUrl$id',
      {},
      headers: {
        'Authorization': 'Bearer $token',
        'accept': 'application/json',
      },
    );

    if (response.statusCode == 200) {
      
    } else {
      throw Failure('Error al cargar los eventos');
    }
  }


  
  
}
