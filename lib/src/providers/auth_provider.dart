import 'dart:convert';

import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:vtschool/src/api/constant.dart';
import 'package:vtschool/src/errors/failure.dart';

import 'package:vtschool/src/models/auth_user_model.dart';
import 'package:http/http.dart' as http;


class AuthProvider extends GetConnect {
  var dataUser = <Map<String, dynamic>>[].obs;
  Future login(String email, String contrasena, String tokenDevice) async {
    //SharedPreferences pref = await SharedPreferences.getInstance();
    //String? tokenDevice = pref.getString('token_device') ?? '';
    try {
      UserData apiResponse;
      Response response = await post(
        loginURL,
        headers: {'Accept': 'application/json'},
        {'email': email, 'password': contrasena, 'device_token': tokenDevice},
      );
      ('es una prueba ${response.body}');
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

  Future<Map<String, dynamic>> getProfile() async {
    try {
      String token = await getToken();
      Response response = await get('${baseURL}auth/user_data', headers: {
        'Accept': 'application/json',
        'Authorization': 'Bearer $token'
      });
      ('profle ${response.statusCode}');

      if (response.statusCode == 200) {
        return response.body['userData'];
      }
      if (response.statusCode == 401) {
        return {};
      }
    } catch (e) {
      throw Failure('$e');
    }
    throw Failure('No se pudo obtener el perfil del usuario');
  }


   Future<Map<String, dynamic>?> updateDataUser(Map<String, dynamic> studentData) async {
    try {
      String url = '${baseURL}users/update_user_mobile';
      String? token = await getToken();

      final response = await http.post(
        Uri.parse(url),
        headers: {
          'Content-Type': 'application/json',
          if (token != null) 'Authorization': 'Bearer $token', 
        },
        body: jsonEncode(studentData),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        return data; 
      } else {
        print('Error en la solicitud: ${response.body}');
        return null;
      }
    } catch (e) {
      print('Error al conectar con el servidor: $e');
      return null;
    }
  }

  Future logout() async {
    String token = await getToken();
    try {
      await post(logoutUrl, {/*'origen':'MOBILE'*/}, headers: {'Authorization': 'Bearer $token'});
    } catch (e) {
      throw Failure('$e');
    }
  }

  Future<String> getToken() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    return pref.getString('token') ?? '';
  }

  Future<String> getTokenDevice() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    return pref.getString('token_device') ?? '';
  }

  Future<String> getRolUser() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    return pref.getString('rolUser') ?? '';
  }
}
