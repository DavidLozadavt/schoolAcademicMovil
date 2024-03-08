import 'dart:convert';

import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;
import 'package:vtschool/src/api/constant.dart';
import 'package:vtschool/src/errors/failure.dart';
import 'package:vtschool/src/models/api_response_model.dart';
import 'package:vtschool/src/models/auth_user_model.dart';
import 'package:vtschool/src/widgets/alert.dart';
//import 'package:vtschool/src/models/user_profile_model.dart';

class AuthService extends GetConnect {
  Future login(String email, String contrasena) async {
    try {
      UserData apiResponse;
      Response response = await post(
        '${baseURL}auth/login',
        headers: {'Accept': 'application/json'},
        {
          'email': email,
          'password': contrasena,
        },
      );

      print('aaaaaaaaawwww ${response.statusCode}');

      if (response.statusCode == 401) {
        throw Failure('Correo o contraseña incorrectos');
      }

      if (response.statusCode != 200) {
        throw Failure('Algo salió mal, vuelve a intentarlo');
      }

      if (response.statusCode == 200) {
        apiResponse = UserData.fromJson(response.body);
        return apiResponse;
      }
    } catch (e) {
      throw Failure('$e');
    }
  }

  Future getProfile() async {
    ApiResponse apiResponse = ApiResponse();
    try {
      String token = await getToken();
      final response = await http.get(Uri.parse('${baseURL}auth/user_data'),
          headers: {
            'Accept': 'application/json',
            'Authorization': 'Bearer $token'
          });
      switch (response.statusCode) {
        case 200:
          // apiResponse.data = UserData.fromJson(jsonDecode(response.body));
          break;
        case 401:
          apiResponse.error = 'Unauthorized';
          break;
        default:
          apiResponse.error = 'Something went wrong';
          break;
      }
    } catch (e) {
      apiResponse.error = 'Server error';
    }

    return apiResponse;
  }

  Future<String> getToken() async {
    String token = GetStorage().read('token');
    return token;
  }
}
