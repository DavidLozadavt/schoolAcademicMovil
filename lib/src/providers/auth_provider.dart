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
      //print('es una prueba ${response.body}');
      //print('es una prueba ${response.statusCode}');
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
     // print('profle ${response.statusCode}');
     // print('profle ${response.body}');
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

  Future<Map<String, dynamic>?> updateDataUser(
      Map<String, dynamic> studentData) async {
    try {
      String url = '${baseURL}users/update_user_mobile';
      String? token = await getToken();

      final response = await http.post(
        Uri.parse(url),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
        body: jsonEncode(studentData),
      );
      print(response.statusCode);
      print(response.body);
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        return data;
      } else {
        //print('Error en la solicitud: ${response.body}');
        return null;
      }
    } catch (e) {
      //print('Error al conectar con el servidor: $e');
      return null;
    }
  }

  Future<void> updatePassword(
      String idUser, String passwordNew, String passwordOld) async {
    String token = await getToken();
    dynamic data = {
      "passwordNew": passwordNew,
      "passwordOld": passwordOld,
    };

    String jsonData = jsonEncode(data);

    Response response = await put(
      '$updatePasswordUrl$idUser',
      jsonData,
      headers: {
        'Authorization': 'Bearer $token',
        'accept': 'application/json',
      },
    );
    if (response.statusCode == 200) {
      Get.back();
      Get.snackbar("Éxito", "Contraseña cambiada correctamente");
      return;
    } else if (response.statusCode == 403) {
      throw Failure('La contraseña antigua no es correcta');
    } else {
      throw Failure('Error al actualizar contraseña');
    }
  }

  Future sendOtp(String email) async {
    Response response = await post(
      sendOtpUrl,
      headers: {'accept': 'application/json'},
      {'email': email},
    );
    //print(response.statusCode);
    //print(response.body);
    if (response.statusCode == 200) {
      Get.offAllNamed('/otp_screen');
    } else {
      throw Failure('Error al enviar correo');
    }
  }

  Future validateOtp(String email, String otp) async {
    Response response = await post(
      validateOtpUrl,
      headers: {'accept': 'application/json'},
      {'email': email, 'otp': otp},
    );
    print(response.statusCode);
    print(response.body);
    if (response.statusCode == 200) {
      Get.offAllNamed('/reset_password_by_otp');
    } else {
      throw Failure('Error al enviar el codigo');
    }
  }

  Future resetPasswordByOtp(String email, String otp, String password) async {
    Response response = await post(
      validateOtpUrl,
      headers: {'accept': 'application/json'},
      {'email': email, 'otp': otp, 'password': password},
    );
    print(response.statusCode);
    print(response.body);
    if (response.statusCode == 200) {
      Get.offAllNamed('/login');
      Get.snackbar("Éxito", "Contraseña cambiada correctamente");
    } else {
      throw Failure('Error al enviar la contraseña');
    }
  }

  Future logout() async {
    String token = await getToken();
    try {
      await post(logoutUrl, {/*'origen':'MOBILE'*/},
          headers: {'Authorization': 'Bearer $token'});
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

  Future<String> getIdStudentSelect() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    return pref.getString('idUser') ?? '';
  }
}
