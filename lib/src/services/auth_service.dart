import 'dart:convert';

import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:vtschool/src/api/constant.dart';
import 'package:vtschool/src/errors/failure.dart';
import 'package:vtschool/src/models/api_response_model.dart';
import 'package:vtschool/src/models/auth_user_model.dart';


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

      //print('aaaaaaaaawwww ${response.statusCode}');

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

  Future<ApiResponse> logout() async {
  ApiResponse apiResponse = ApiResponse();
  String token = await getToken();
  try {
    final response = await http.post(Uri.parse(logoutUrl),
        headers: {'Authorization': 'Bearer $token'});

    switch (response.statusCode) {
      case 200:
        apiResponse.data = User.fromJson(jsonDecode(response.body));
        break;
      case 422:
        final errors = jsonDecode(response.body)['errors'];
        apiResponse.error = errors[errors.keys.elementAt(0)][0];
        break;
      case 403:
        apiResponse.error = jsonDecode(response.body)['message'];
        break;
      default:
        apiResponse.error = somethingWentWrong;
        break;
    }
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
