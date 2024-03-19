import 'dart:convert';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import 'package:vtschool/src/api/constant.dart';
import 'package:vtschool/src/errors/failure.dart';
import 'package:vtschool/src/models/api_response_model.dart';
import 'package:vtschool/src/models/auth_user_model.dart';


class AuthProvider extends GetConnect {
  var dataUser = <Map<String, dynamic>>[].obs;
  
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

      if (response.statusCode == 401) {
        throw Failure('Correo o contraseña incorrectos');
      }

      if (response.statusCode != 200) {
        throw Failure('Algo salió mal, vuelve a intentarlo');
      }

      if (response.statusCode == 200) {
        //Get.snackbar('Hola!!', 'Un gusto tenerte de nuevo');
        apiResponse = UserData.fromJson(response.body);
        return apiResponse;
      }
    } catch (e) {
      throw Failure('$e');
    }
  }

 Future<Map<String, dynamic>> getProfile() async {
    try {
      String token = await getToken();
      Response response = await get('${baseURL}auth/user_data', headers: {
        'Accept': 'application/json',
        'Authorization': 'Bearer $token'
      });

      if (response.statusCode != 200) {
        throw Failure('Algo salió mal, vuelve a intentarlo');
      }

      if (response.statusCode == 200) {
        return response.body['userData'];
      }
    } catch (e) {
      throw Failure('$e');
    }
    throw Failure('No se pudo obtener el perfil del usuario');
  }

  Future<ApiResponse> logout() async {
    ApiResponse apiResponse = ApiResponse();
    String token = await getToken();
    try {
      Response response = await post(logoutUrl,
          {},
          headers: {'Authorization': 'Bearer $token'});

    } catch (e) {
      apiResponse.error = serverError;
    }

    return apiResponse;
  }

  Future<String> getToken() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    return pref.getString('token') ?? '';
  }

  Future<String> getRolUser() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    return pref.getString('rolUser') ?? '';
  }
}
